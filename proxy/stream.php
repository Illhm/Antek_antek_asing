<?php
// ============================================
// PROXY STREAM - Core Engine v4
// Dual-layer: Secret Key + UA Whitelist
// ============================================
require_once '../includes/config.php';
require_once 'security.php';

$ip     = ProxySecurity::getClientIP();
$ipPrefix = ProxySecurity::getIpPrefix($ip);
$ua     = getUA();
$accept = $_SERVER['HTTP_ACCEPT'] ?? '';

// ============================================
// LAYER 1: SECRET KEY VALIDATION
// Wajib ada ?key=xxx yang cocok di database
// Tanpa ini → langsung block, tidak peduli UA
// ============================================
$username  = trim($_GET['user'] ?? '');
$keyInput  = trim($_GET['key']  ?? '');

if (!$username || !$keyInput) {
    blockResponse('Missing credentials.', 'No user/key parameter');
    exit;
}

$db = getDB();

// Ambil user + key dari DB
$stmt = $db->prepare("SELECT u.*, p.source_url FROM users u 
    JOIN playlists p ON u.playlist_id = p.id 
    WHERE u.username = ? AND u.is_active = 1");
$stmt->execute([$username]);
$user = $stmt->fetch();

if (!$user) {
    logAccess(null, null, 'blocked', "User tidak ditemukan: $username | IP:$ip");
    blockResponse('Invalid credentials.', "User not found: $username");
    exit;
}

// Validasi key — hash_equals untuk mencegah timing attack
if (!hash_equals($user['stream_key'], $keyInput)) {
    logAccess($user['id'], null, 'blocked', "Key salah | IP:$ip | UA:" . substr($ua, 0, 80));
    blockResponse('Invalid credentials.', 'Wrong stream key');
    exit;
}

// ============================================
// LAYER 2: UA WHITELIST (tetap dipertahankan)
// Orang boleh tahu key-nya, tapi UA harus player
// ============================================
$uaCheck = checkClientAllowed($ua, $accept);
if (!$uaCheck['allowed']) {
    logAccess($user['id'], null, 'blocked', "UA blocked | {$uaCheck['reason']} | IP:$ip");
    blockResponse(null, $uaCheck['reason'], $ip, $ua);
    exit;
}

// ============================================
// LAYER 3: Validasi user (expired, device)
// ============================================
if (isIPBlocked($ip)) {
    http_response_code(403); die('Access denied.');
}

if (strtotime($user['expired_at']) < time()) {
    logAccess($user['id'], null, 'expired', "Expired: $username");
    http_response_code(403); die('Subscription expired.');
}

$uaHash = ProxySecurity::getUaHash($ua);
$deviceFingerprint = ProxySecurity::getDeviceFingerprint($uaHash, $ipPrefix);

// Check Rate Limits
if (!ProxySecurity::checkRateLimit($user['id'], $deviceFingerprint, $ipPrefix)) {
    logAccess($user['id'], null, 'rate_limit', "Rate limit exceeded | IP:$ip");
    http_response_code(429); die('Too Many Requests.');
}

$stmt = $db->prepare("SELECT * FROM device_sessions WHERE user_id=? AND device_fingerprint=?");
$stmt->execute([$user['id'], $deviceFingerprint]);
$device = $stmt->fetch();

if (!$device) {
    $cnt = $db->prepare("SELECT COUNT(*) FROM device_sessions WHERE user_id=?");
    $cnt->execute([$user['id']]);
    if ((int)$cnt->fetchColumn() >= $user['max_devices']) {
        logAccess($user['id'], null, 'device_limit', "Device limit: $username ($ip)");
        http_response_code(403); die('Device limit reached. Max: ' . $user['max_devices']);
    }
    $db->prepare("INSERT INTO device_sessions (user_id,device_fingerprint,ip_address,user_agent) VALUES (?,?,?,?)")
       ->execute([$user['id'], $deviceFingerprint, $ip, $ua]);
} else {
    $db->prepare("UPDATE device_sessions SET last_seen=NOW(),ip_address=? WHERE id=?")->execute([$ip, $device['id']]);
}

// Token
$stmt = $db->prepare("SELECT * FROM tokens WHERE user_id=? AND device_fingerprint=? AND expires_at > NOW()");
$stmt->execute([$user['id'], $deviceFingerprint]);
$tokenRow = $stmt->fetch();

if (!$tokenRow) {
    $token    = generateToken(64);
    $expireAt = date('Y-m-d H:i:s', time() + TOKEN_EXPIRE_HOURS * 3600);
    $db->prepare("INSERT INTO tokens (user_id,token,playlist_id,device_fingerprint,ip_address,user_agent,expires_at) VALUES (?,?,?,?,?,?,?)")
       ->execute([$user['id'], $token, $user['playlist_id'], $deviceFingerprint, $ip, $ua, $expireAt]);
    logAccess($user['id'], $token, 'token_generate', "New token: $username");
} else {
    $token = $tokenRow['token'];
}

logAccess($user['id'], $token, 'stream_access', "IP:$ip | UA:" . substr($ua, 0, 80));

// Serve secure playlist
$comment = "#EXTM3U\n# User:$username | Exp:" . date('d/m/Y H:i', time()+PROXY_EXPIRE_SECONDS) . "\n";
fetchAndOutputSecureM3U($user['source_url'], $comment, $user['id'], $deviceFingerprint, $ipPrefix, $uaHash);


// ============================================
// HELPER FUNCTIONS
// ============================================

function blockResponse(?string $textMsg, string $logReason, string $ip = '', string $ua = ''): void {
    // Kalau ada browser headers → tampil halaman terminal
    $hasBrowserHeaders = !empty($_SERVER['HTTP_SEC_FETCH_MODE'])
        || !empty($_SERVER['HTTP_SEC_CH_UA'])
        || stripos($_SERVER['HTTP_ACCEPT'] ?? '', 'text/html') !== false;

    if ($hasBrowserHeaders || $textMsg === null) {
        showTerminalPage($ip ?: getClientIP(), $ua ?: getUA(), $logReason);
    } else {
        http_response_code(403);
        header('Content-Type: text/plain');
        die($textMsg ?? 'Access denied.');
    }
}

function isBase64UA(string $ua): bool {
    $trimmed = rtrim(trim($ua), '=');
    if (!preg_match('/^[A-Za-z0-9+\/]+=*$/', $trimmed)) return false;
    if (strlen($trimmed) < 8) return false;
    $decoded = base64_decode($ua, true);
    if ($decoded === false) return false;
    if (!mb_check_encoding($decoded, 'UTF-8')) return false;
    if (strpos($ua, '/') === false && strpos($ua, '.') === false && strpos($ua, ' ') === false) return true;
    return false;
}

function checkClientAllowed(string $ua, string $accept): array {
    // Base64 UA
    if (isBase64UA($ua)) {
        $decoded = @base64_decode($ua, true);
        return ['allowed' => false, 'reason' => 'Base64 UA: ' . substr($decoded ?: '?', 0, 60)];
    }

    // Whitelist
    $whitelist = [
        'tivimate','ott navigator','ott/','smarters','televizo','stbemu',
        'perfect player','gse smart iptv','kodi','xbmc','neutron player',
        'sparkle','flex iptv','nplayer','vlc/','mpv/','mxplayer','exoplayer',
        'libvlc','ffmpeg','libmpv','okhttp/','dalvik/','java/','cfnetwork',
        'stagefright','lavf/','gvfs/',
    ];
    $uaLower = strtolower(trim($ua));
    foreach ($whitelist as $w) {
        if (strpos($uaLower, strtolower($w)) !== false)
            return ['allowed' => true, 'reason' => "Whitelist: $w"];
    }

    // Hard block
    $hardBlock = [
        'reqable','postman','insomnia','paw/','httpie','thunder client',
        'bruno/','hoppscotch','restsharp','apifox','apidog','charles proxy',
        'fiddler','curl/','wget/','python-requests','python-urllib','python/',
        'aiohttp','httpx/','requests/','node-fetch','axios/','got/','node/',
        'undici','go-http-client','dart/','ruby','php/','scrapy','selenium',
        'puppeteer','playwright','headlesschrome','phantomjs','lighthouse',
    ];
    foreach ($hardBlock as $b) {
        if (strpos($uaLower, strtolower($b)) !== false)
            return ['allowed' => false, 'reason' => "Hard block: $b"];
    }

    // Browser headers
    if (!empty($_SERVER['HTTP_SEC_FETCH_MODE']) || !empty($_SERVER['HTTP_SEC_FETCH_DEST']) || !empty($_SERVER['HTTP_SEC_CH_UA']))
        return ['allowed' => false, 'reason' => 'Browser headers (Sec-Fetch/CH-UA)'];
    if (stripos($accept, 'text/html') !== false)
        return ['allowed' => false, 'reason' => 'Accept: text/html'];

    $uaLen = strlen(trim($ua));
    if ($uaLen === 0) return ['allowed' => false, 'reason' => 'UA empty'];
    if ($uaLen < 8)   return ['allowed' => false, 'reason' => 'UA too short'];

    // Tidak dikenal → tolak
    return ['allowed' => false, 'reason' => 'UA not in whitelist: ' . substr($ua, 0, 80)];
}

function fetchAndOutputSecureM3U(string $sourceUrl, string $topComment, $uid, $deviceFingerprint, $ipPrefix, $uaHash): void {
    $context = stream_context_create(['http' => [
        'timeout' => 10, 'follow_location' => true, 'user_agent' => 'IPTV-Panel-Proxy/1.0',
    ]]);
    $raw = @file_get_contents($sourceUrl, false, $context);
    if ($raw === false) { http_response_code(502); die('Could not fetch source playlist.'); }

    header('Content-Type: application/x-mpegURL');
    header('Content-Disposition: attachment; filename="playlist.m3u"');
    header('Cache-Control: no-cache, no-store');

    $raw = preg_replace('/^#EXTM3U[^\n]*\n?/', '', $raw, 1);

    // Rewrite all URLs to secure proxy URLs
    $securePlaylist = ProxySecurity::rewritePlaylist($raw, $uid, $deviceFingerprint, $ipPrefix, $uaHash, $sourceUrl);

    echo $topComment . $securePlaylist;
}

function showTerminalPage(string $ip, string $ua, string $reason = ''): void {
    $geoData  = @json_decode(@file_get_contents("http://ip-api.com/json/{$ip}?fields=country,isp,org,regionName,city,proxy,mobile"), true);
    $country  = $geoData['country']  ?? 'Unknown';
    $isp      = $geoData['isp']      ?? ($geoData['org'] ?? 'Unknown');
    $city     = trim(($geoData['city'] ?? '') . (isset($geoData['regionName']) ? ', '.$geoData['regionName'] : ''));
    $isProxy  = (!empty($geoData['proxy']) && $geoData['proxy']) ? 'TERDETEKSI ⚠' : 'Tidak';
    $connType = (!empty($geoData['mobile']) && $geoData['mobile']) ? 'Mobile / Data' : 'Kabel / WiFi';

    $uaL = strtolower($ua);
    $clientName = 'Unknown';
    if     (strpos($uaL,'reqable')  !== false) $clientName = 'Reqable (API Tool)';
    elseif (strpos($uaL,'postman')  !== false) $clientName = 'Postman';
    elseif (strpos($uaL,'python')   !== false) $clientName = 'Python Script';
    elseif (strpos($uaL,'curl/')    !== false) $clientName = 'cURL';
    elseif (strpos($uaL,'edg/')     !== false) $clientName = 'Microsoft Edge';
    elseif (strpos($uaL,'chrome/')  !== false) $clientName = 'Google Chrome';
    elseif (strpos($uaL,'firefox/') !== false) $clientName = 'Mozilla Firefox';
    elseif (strlen(trim($ua)) < 30)            $clientName = 'Custom / Unknown';

    $os = 'Unknown';
    if     (strpos($uaL,'windows nt 10') !== false) $os = 'Windows 10/11';
    elseif (strpos($uaL,'windows')       !== false) $os = 'Windows';
    elseif (preg_match('/android ([\d.]+)/i', $ua, $m)) $os = 'Android '.$m[1];
    elseif (strpos($uaL,'iphone')        !== false) $os = 'iOS (iPhone)';
    elseif (strpos($uaL,'macintosh')     !== false) $os = 'macOS';
    elseif (strpos($uaL,'linux')         !== false) $os = 'Linux';

    http_response_code(200);
    header('Content-Type: text/html; charset=utf-8');
    $panelName = htmlspecialchars(PANEL_NAME);
    echo <<<HTML
<!DOCTYPE html><html lang="id"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>{$panelName}</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Share+Tech+Mono&display=swap');
*{margin:0;padding:0;box-sizing:border-box}
body{background:#0a0a0a;color:#00ff41;font-family:'Share Tech Mono','Courier New',monospace;
min-height:100vh;display:flex;align-items:center;justify-content:center;padding:20px}
.t{background:#0d1117;border:1px solid #00ff41;border-radius:4px;padding:32px 36px;
width:100%;max-width:740px;box-shadow:0 0 40px rgba(0,255,65,.12)}
.ttl{font-size:1.1rem;font-weight:bold;margin-bottom:6px;letter-spacing:1px}
hr{border:none;border-top:1px dashed #1a4d2e;margin:14px 0}
.r{display:flex;margin:7px 0;font-size:.875rem;line-height:1.6}
.l{color:#00cc33;min-width:200px;flex-shrink:0}
.v{color:#e0ffe8;word-break:break-all}
.warn{color:#ffcc00}.ok{color:#00ff41}.danger{color:#ff4444}
.msg{margin-top:18px;border:1px solid #1a4d2e;padding:14px 16px;border-radius:3px;
font-size:.84rem;color:#aaffcc;line-height:1.8}
.cursor{display:inline-block;width:10px;height:1em;background:#00ff41;
animation:blink 1s step-end infinite;vertical-align:text-bottom;margin-top:14px}
@keyframes blink{50%{opacity:0}}
</style></head><body><div class="t">
<div class="ttl">&gt; {$panelName} &mdash; CLIENT DETECTOR</div><hr>
<div class="r"><span class="l">WAKTU AKSES</span><span class="v">: HTML . date('d-m-Y H:i:s') . <<<HTML
</span></div>
<div class="r"><span class="l">IP ADDRESS</span><span class="v">: HTML . htmlspecialchars($ip) . <<<HTML
</span></div>
HTML . ($city ? '<div class="r"><span class="l">KOTA / WILAYAH</span><span class="v">: '.htmlspecialchars($city).'</span></div>' : '') . <<<HTML
<div class="r"><span class="l">NEGARA</span><span class="v">: HTML . htmlspecialchars($country) . <<<HTML
</span></div>
<div class="r"><span class="l">ISP</span><span class="v">: HTML . htmlspecialchars($isp) . <<<HTML
</span></div>
<div class="r"><span class="l">TIPE KONEKSI</span><span class="v">: HTML . htmlspecialchars($connType) . <<<HTML
</span></div>
<div class="r"><span class="l">VPN / PROXY</span><span class="v HTML . ($isProxy !== 'Tidak' ? 'warn' : 'ok') . <<<HTML
">: HTML . $isProxy . <<<HTML
</span></div>
<div class="r"><span class="l">SISTEM OPERASI</span><span class="v">: HTML . htmlspecialchars($os) . <<<HTML
</span></div>
<div class="r"><span class="l">CLIENT TERDETEKSI</span><span class="v danger">: HTML . htmlspecialchars($clientName) . <<<HTML
</span></div>
<div class="r"><span class="l">USER AGENT</span><span class="v">: HTML . htmlspecialchars(substr($ua ?: '(kosong)', 0, 130)) . <<<HTML
</span></div>
<div class="r"><span class="l">STATUS</span><span class="v ok">: AKSES DITOLAK</span></div>
<hr>
<div class="msg">
PESAN &nbsp;&nbsp;: Akses ditolak. URL ini hanya bisa digunakan di aplikasi IPTV resmi.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gunakan URL lengkap yang diberikan admin (termasuk parameter key).<br><br>
APLIKASI : OTT Navigator &nbsp;|&nbsp; TiviMate &nbsp;|&nbsp; IPTV Smarters &nbsp;|&nbsp; Televizo &nbsp;|&nbsp; VLC
</div>
<div><span class="cursor"></span></div>
</div></body></html>
HTML;
    exit;
}
