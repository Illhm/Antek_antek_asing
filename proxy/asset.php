<?php
// ============================================
// Secure Asset Proxy
// ============================================
require_once __DIR__ . '/../includes/config.php';
require_once 'security.php';

$rid = $_GET['rid'] ?? '';
$uid = $_GET['uid'] ?? '';
$exp = $_GET['exp'] ?? '';
$sig = $_GET['sig'] ?? '';

if (!$rid || !$uid || !$exp || !$sig) {
    http_response_code(403);
    die('Missing parameters.');
}

$ip = ProxySecurity::getClientIP();
$ipPrefix = ProxySecurity::getIpPrefix($ip);
$ua = $_SERVER['HTTP_USER_AGENT'] ?? '';

// Validate Expiry
if (time() > (int)$exp) {
    http_response_code(403);
    die('Link expired.');
}

// Resolve mapping early to compare stored payload bindings
$mapping = ProxySecurity::resolveProxyMapping($rid);

if (!$mapping) {
    http_response_code(404);
    die('Resource not found or expired.');
}

$originalUrl = $mapping['original_url'];
$storedIpPrefix = $mapping['ip_prefix'];
$storedUaHash = $mapping['ua_hash'];
$storedDeviceFingerprint = $mapping['device_fingerprint'];
$storedUserId = $mapping['user_id'];

// Prevent mapping hijacking across users
if ($uid != $storedUserId) {
    error_log("HMAC MAPPING MISMATCH | RID: $rid | MAPPING_UID: $storedUserId | GIVEN_UID: $uid");
    http_response_code(403);
    die('Invalid binding.');
}

// Verify Signature with stored parameters to ensure URL hasn't been tampered with
if (!ProxySecurity::verifyHmac($sig, $rid, $uid, $storedDeviceFingerprint, $storedIpPrefix, $storedUaHash, (int)$exp)) {
    http_response_code(403);
    die('Invalid signature.');
}

// Now verify that the CURRENT user matches the stored mapping requirements
$currentUaHash = ProxySecurity::getUaHash($ua);
$currentDeviceFingerprint = ProxySecurity::getDeviceFingerprint($currentUaHash, $ipPrefix);

if (!hash_equals($storedIpPrefix, $ipPrefix) || !hash_equals($storedUaHash, $currentUaHash) || !hash_equals($storedDeviceFingerprint, $currentDeviceFingerprint)) {
    error_log("SECURITY CONTEXT MISMATCH | RID: $rid | IP_PREFIX: $storedIpPrefix vs $ipPrefix | UA_HASH: $storedUaHash vs $currentUaHash");
    http_response_code(403);
    die('Security context mismatch.');
}

// Check Rate Limits
if (!ProxySecurity::checkRateLimit($uid, $storedDeviceFingerprint, $storedIpPrefix)) {
    http_response_code(429);
    die('Too Many Requests.');
}

// Validate User Details
global $db;
if (!$db) $db = getDB();

$stmt = $db->prepare("SELECT is_active, expired_at FROM users WHERE id = ?");
$stmt->execute([$uid]);
$user = $stmt->fetch();

if (!$user || !$user['is_active']) {
    http_response_code(403);
    die('User inactive.');
}

if (strtotime($user['expired_at']) < time()) {
    http_response_code(403);
    die('Subscription expired.');
}

// Resolve redirect using cURL for better handling of query strings with commas/brackets
function getFinalUrlAndContentType($url) {
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_HEADER, 1);
    curl_setopt($ch, CURLOPT_NOBODY, 1);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
    curl_setopt($ch, CURLOPT_MAXREDIRS, 3);
    curl_setopt($ch, CURLOPT_TIMEOUT, 15);
    curl_setopt($ch, CURLOPT_USERAGENT, 'IPTV-Panel-Proxy/1.0');
    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);

    curl_exec($ch);
    $finalUrl = curl_getinfo($ch, CURLINFO_EFFECTIVE_URL);
    $contentType = curl_getinfo($ch, CURLINFO_CONTENT_TYPE);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    return [$finalUrl, $contentType, $httpCode];
}

list($finalUrl, $contentType, $httpCode) = getFinalUrlAndContentType($originalUrl);

// Some CDNs might return 404/403 to HEAD requests, so we just log or ignore it and proceed.
if ($httpCode >= 400 && $httpCode != 404 && $httpCode != 403 && $httpCode != 405) {
    // We try fetching directly later, so we do not die here.
}

// Ensure we fetch from the final resolved URL after redirects
$originalUrl = $finalUrl;

// Ensure any URL fragments/query params aren't lost in redirects
if (strpos($originalUrl, '://') === false) {
    $originalUrl = ProxySecurity::resolveProxyMapping($rid); // fallback to mapping
}

// If the content is another playlist (M3U/M3U8), we must rewrite it recursively.
// Also rewrite MPD manifests if necessary, though it is usually handled differently, we can treat them similarly if they contain URLs.
if (stripos($contentType, 'mpegurl') !== false || stripos($originalUrl, '.m3u8') !== false || stripos($originalUrl, '.m3u') !== false || stripos($originalUrl, '.mpd') !== false || stripos($contentType, 'dash+xml') !== false) {
    // We use cURL as default for fetching the manifest to ensure we pass headers correctly
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $originalUrl);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
    curl_setopt($ch, CURLOPT_TIMEOUT, 15);
    curl_setopt($ch, CURLOPT_USERAGENT, 'IPTV-Panel-Proxy/1.0');
    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    $content = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    if ($content === false || $httpCode >= 400) {
        // Fallback to file_get_contents if curl fails (very rare but possible due to strange TLS configurations)
        $content = @file_get_contents($originalUrl, false, $context);
        if ($content === false && $httpCode >= 400 && $httpCode != 404 && $httpCode != 403) {
            http_response_code(502);
            die('Failed to fetch playlist. HTTP Code: ' . $httpCode);
        }
    }

    header('Content-Type: application/vnd.apple.mpegurl');
    header('Cache-Control: no-cache, no-store');

    // Output the recursively rewritten playlist
    echo ProxySecurity::rewritePlaylist($content, $uid, $storedDeviceFingerprint, $storedIpPrefix, $storedUaHash, $originalUrl);
    exit;
}

// Otherwise, stream the binary content (TS segment, key, etc.) safely
header('Content-Type: ' . ($contentType ?: 'application/octet-stream'));
header('Cache-Control: public, max-age=86400'); // Cache segments

// Open the remote stream
$fp = @fopen($originalUrl, 'rb', false, $context);
if (!$fp) {
    http_response_code(502);
    die('Failed to open stream.');
}

// Stream the content through without buffering it all into memory
if ($fp) {
    while (!feof($fp)) {
        echo fread($fp, 8192);
        ob_flush();
        flush();
    }
    fclose($fp);
} else {
    // cURL Fallback for binary streaming
    $ch = curl_init($originalUrl);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
    curl_setopt($ch, CURLOPT_TIMEOUT, 30);
    curl_setopt($ch, CURLOPT_USERAGENT, 'IPTV-Panel-Proxy/1.0');
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);

    // Pass headers along, skipping Transfer-Encoding chunked since curl handles it
    curl_setopt($ch, CURLOPT_HEADERFUNCTION, function($curl, $header) {
        if (stripos($header, 'Transfer-Encoding:') === false) {
            header($header);
        }
        return strlen($header);
    });

    // Write body directly to output
    curl_setopt($ch, CURLOPT_WRITEFUNCTION, function($curl, $body) {
        echo $body;
        ob_flush();
        flush();
        return strlen($body);
    });

    curl_exec($ch);
    curl_close($ch);
}
exit;
