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
// Wajib ada ?user=xxx dan (?key=xxx ATAU ?t=xxx)
// ============================================
$username  = trim($_GET['user'] ?? '');
$keyInput  = trim($_GET['key']  ?? '');
$tokenInput = trim($_GET['t'] ?? '');

if (!$username) {
    blockResponse('Missing credentials.', 'No user parameter');
    die();
}

if (!$keyInput && !$tokenInput) {
    blockResponse('Missing credentials.', 'No key or token parameter');
    die();
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
    die();
}

// Validasi key
$validAuth = false;

if ($keyInput) {
    // Migration logic for plain text stream key
    if (strlen($user['stream_key']) < 40 && hash_equals($user['stream_key'], $keyInput)) {
        $newHash = password_hash($user['stream_key'], PASSWORD_DEFAULT);
        $db->prepare("UPDATE users SET stream_key = ? WHERE id = ?")->execute([$newHash, $user['id']]);
        $user['stream_key'] = $newHash;
        $validAuth = true;
    } elseif (password_verify($keyInput, $user['stream_key'])) {
        $validAuth = true;
    }
} elseif ($tokenInput) {
    $stmt = $db->prepare("SELECT * FROM tokens WHERE user_id=? AND token=? AND expires_at > ?");
    $stmt->execute([$user['id'], $tokenInput, date('Y-m-d H:i:s')]);
    if ($stmt->fetch()) {
        $validAuth = true;
    }
}

if (!$validAuth) {
    logAccess($user['id'], null, 'blocked', "Key/Token salah | IP:$ip | UA:" . substr($ua, 0, 80));
    blockResponse('Invalid credentials.', 'Wrong stream key or token');
    die();
}

// ============================================
// LAYER 2: UA WHITELIST (tetap dipertahankan)
// ============================================
$uaCheck = checkClientAllowed($ua, $accept);
if (!$uaCheck['allowed']) {
    logAccess($user['id'], null, 'blocked', "UA blocked | {$uaCheck['reason']} | IP:$ip");
    blockResponse(null, $uaCheck['reason'], $ip, $ua);
    die();
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

// Opportunistic Session Cleanup
$nowStr = date('Y-m-d H:i:s');
$db->exec("DELETE FROM device_sessions WHERE expires_at < '$nowStr'");
$db->exec("DELETE FROM tokens WHERE expires_at < '$nowStr'");

$stmt = $db->prepare("SELECT * FROM device_sessions WHERE user_id=? AND device_fingerprint=?");
$stmt->execute([$user['id'], $deviceFingerprint]);
$device = $stmt->fetch();

$policy = STREAM_SESSION_POLICY;
$idleTimeout = STREAM_IDLE_TIMEOUT;
$maxAge = STREAM_SESSION_MAX_AGE;
$maxDevices = $user['max_devices'] ?: MAX_CONCURRENT_STREAMS_PER_USER;
$expiresAt = date('Y-m-d H:i:s', time() + $idleTimeout);

if (!$device) {
    $cnt = $db->prepare("SELECT COUNT(*) FROM device_sessions WHERE user_id=?");
    $cnt->execute([$user['id']]);
    if ((int)$cnt->fetchColumn() >= $maxDevices) {
        if ($policy === 'block_new') {
            logAccess($user['id'], null, 'device_limit', "Device limit: $username ($ip)");
            http_response_code(403); die('Device limit reached. Max: ' . $maxDevices);
        } else {
            // kick_old logic not fully implemented, block anyway
            http_response_code(403); die('Device limit reached.');
        }
    }
    $db->prepare("INSERT INTO device_sessions (user_id,device_fingerprint,ip_address,user_agent,expires_at) VALUES (?,?,?,?,?)")
       ->execute([$user['id'], $deviceFingerprint, $ip, $ua, $expiresAt]);
} else {
    $db->prepare("UPDATE device_sessions SET last_seen=?, expires_at=?, ip_address=? WHERE id=?")->execute([$nowStr, $expiresAt, $ip, $device['id']]);
}

// Token
$stmt = $db->prepare("SELECT * FROM tokens WHERE user_id=? AND device_fingerprint=? AND expires_at > ?");
$stmt->execute([$user['id'], $deviceFingerprint, $nowStr]);
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
$comment = "#EXTM3U\n# User:$username | Exp:" . date('d/m/Y H:i', time()+PLAYLIST_SIGNED_TTL) . "\n";
fetchAndOutputSecureM3U($user['source_url'], $comment, $user['id'], $deviceFingerprint, $ipPrefix, $uaHash);

// ============================================
// HELPER FUNCTIONS
// ============================================

function checkClientAllowed(string $ua, string $accept): array {
    if (strpos($ua, 'M3U8-Downloader') !== false || strpos($ua, 'reqable') !== false)
        return ['allowed' => false, 'reason' => 'Downloader / API Tool'];

    if (!empty($_SERVER['HTTP_SEC_FETCH_MODE']) || !empty($_SERVER['HTTP_SEC_FETCH_DEST']) || !empty($_SERVER['HTTP_SEC_CH_UA']))
        return ['allowed' => false, 'reason' => 'Browser headers (Sec-Fetch/CH-UA)'];
    if (stripos($accept, 'text/html') !== false)
        return ['allowed' => false, 'reason' => 'Accept: text/html'];

    $uaLen = strlen(trim($ua));
    if ($uaLen === 0) return ['allowed' => false, 'reason' => 'UA empty'];
    if ($uaLen < 8)   return ['allowed' => false, 'reason' => 'UA too short'];

    return ['allowed' => true, 'reason' => 'OK'];
}

function fetchAndOutputSecureM3U(string $sourceUrl, string $topComment, $uid, $deviceFingerprint, $ipPrefix, $uaHash): void {
    $fetchResult = ProxySecurity::secureFetchUrl($sourceUrl);
    if ($fetchResult['error']) {
        http_response_code($fetchResult['code']); die($fetchResult['message']);
    }

    $safeUrl = $fetchResult['finalUrl'];

    $ch = curl_init($safeUrl);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, false);
    curl_setopt($ch, CURLOPT_TIMEOUT, 15);
    curl_setopt($ch, CURLOPT_USERAGENT, 'IPTV-Panel-Proxy/1.0');
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
    $raw = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    if ($raw === false || $httpCode >= 400) { http_response_code(502); die('Could not fetch source playlist.'); }

    header('Content-Type: application/x-mpegURL');
    header('Content-Disposition: attachment; filename="playlist.m3u"');
    header('Cache-Control: no-cache, no-store');

    $raw = preg_replace('/^#EXTM3U[^
]*
?/', '', $raw, 1);

    // Rewrite all URLs to secure proxy URLs
    $securePlaylist = ProxySecurity::rewritePlaylist($raw, $uid, $deviceFingerprint, $ipPrefix, $uaHash, $safeUrl);

    echo $topComment . $securePlaylist;
}

function blockResponse(string $reason = null, string $detail = '', string $ip = '', string $ua = ''): void {
    http_response_code(403);
    die($reason ?: 'Access Denied.');
}
