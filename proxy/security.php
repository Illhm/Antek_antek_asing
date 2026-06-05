<?php
// ============================================
// Security Module for Proxy Proxy
// ============================================
require_once __DIR__ . '/../includes/config.php';

class ProxySecurity {

    public static function secureFetchUrl($url, $maxRedirects = 5) {
        $currentUrl = $url;
        $redirects = 0;

        while ($redirects <= $maxRedirects) {
            if (!self::isSafeUrl($currentUrl)) {
                return ['error' => true, 'code' => 403, 'message' => 'Invalid or unsafe source URL encountered.'];
            }

            $ch = curl_init($currentUrl);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_HEADER, true);
            curl_setopt($ch, CURLOPT_NOBODY, true);
            curl_setopt($ch, CURLOPT_FOLLOWLOCATION, false);
            curl_setopt($ch, CURLOPT_TIMEOUT, 10);
            curl_setopt($ch, CURLOPT_USERAGENT, 'IPTV-Panel-Proxy/1.0');
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
            curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);

            $response = curl_exec($ch);
            $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
            $headerSize = curl_getinfo($ch, CURLINFO_HEADER_SIZE);
            curl_close($ch);

            if ($httpCode >= 300 && $httpCode < 400) {
                $headers = substr($response, 0, $headerSize);
                if (preg_match('/^Location:\s*(.*)$/mi', $headers, $matches)) {
                    $redirectUrl = trim($matches[1]);
                    if (!preg_match('~^(?:f|ht)tps?://~i', $redirectUrl)) {
                        $parsed = parse_url($currentUrl);
                        $base = $parsed['scheme'] . '://' . $parsed['host'] . (isset($parsed['port']) ? ':' . $parsed['port'] : '');
                        if (strpos($redirectUrl, '/') === 0) {
                            $currentUrl = $base . $redirectUrl;
                        } else {
                            $path = isset($parsed['path']) ? $parsed['path'] : '/';
                            $dir = dirname($path);
                            // Avoid double slashes
                            if (substr($dir, -1) !== '/') $dir .= '/';
                            $currentUrl = $base . $dir . $redirectUrl;
                        }
                    } else {
                        $currentUrl = $redirectUrl;
                    }
                    $redirects++;
                    continue;
                }
            }

            return ['error' => false, 'finalUrl' => $currentUrl];
        }

        return ['error' => true, 'code' => 502, 'message' => 'Too many redirects.'];
    }

    public static function isSafeUrl($url) {
        $parsed = parse_url($url);
        if (!$parsed || !isset($parsed['host']) || !isset($parsed['scheme'])) return false;

        $scheme = strtolower($parsed['scheme']);
        if ($scheme !== 'http' && $scheme !== 'https') return false;

        $host = $parsed['host'];

        // Resolve IP
        $ip = gethostbyname($host);
        if ($ip === $host) {
            // Check if it's already an IP
            if (!filter_var($host, FILTER_VALIDATE_IP)) return false;
        }

        // Check for local/internal/metadata IPs
        $blockedRanges = [
            '127.0.0.0/8',
            '10.0.0.0/8',
            '172.16.0.0/12',
            '192.168.0.0/16',
            '169.254.0.0/16', // Link-local
            '::1/128',
            'fc00::/7',
            'fe80::/10'
        ];

        foreach ($blockedRanges as $range) {
            if (self::ipInRange($ip, $range)) return false;
        }

        return true;
    }

    // Cloudflare IPv4 ranges (Updated frequently by CF, these are standard static ones)
    private static $cfIpsV4 = [
        '173.245.48.0/20', '103.21.244.0/22', '103.22.200.0/22', '103.31.4.0/22',
        '141.101.64.0/18', '108.162.192.0/18', '190.93.240.0/20', '188.114.96.0/20',
        '197.234.240.0/22', '198.41.128.0/17', '162.158.0.0/15', '104.16.0.0/13',
        '104.24.0.0/14', '172.64.0.0/13', '131.0.72.0/22'
    ];

    private static $cfIpsV6 = [
        '2400:cb00::/32', '2606:4700::/32', '2803:f800::/32', '2405:b500::/32',
        '2405:8100::/32', '2a06:98c0::/29', '2c0f:f248::/32'
    ];

    /**
     * Checks if an IP is within a CIDR range.
     */
    private static function ipInRange($ip, $cidr) {
        if (strpos($cidr, '/') === false) {
            $cidr .= (strpos($ip, ':') !== false) ? '/128' : '/32';
        }
        list($subnet, $bits) = explode('/', $cidr);

        if (strpos($ip, ':') === false && strpos($subnet, ':') === false) {
            // IPv4
            $ip = ip2long($ip);
            $subnet = ip2long($subnet);
            $mask = -1 << (32 - $bits);
            $subnet &= $mask;
            return ($ip & $mask) == $subnet;
        } elseif (strpos($ip, ':') !== false && strpos($subnet, ':') !== false) {
            // IPv6
            $ip = inet_pton($ip);
            $subnet = inet_pton($subnet);
            if ($ip === false || $subnet === false) return false;

            $binIp = '';
            $binSubnet = '';
            foreach (str_split($ip) as $char) $binIp .= str_pad(decbin(ord($char)), 8, '0', STR_PAD_LEFT);
            foreach (str_split($subnet) as $char) $binSubnet .= str_pad(decbin(ord($char)), 8, '0', STR_PAD_LEFT);

            return substr($binIp, 0, $bits) === substr($binSubnet, 0, $bits);
        }
        return false;
    }

    /**
     * Securely get client IP, trusting CF-Connecting-IP/X-Forwarded-For only if REMOTE_ADDR is Cloudflare
     */
    public static function getClientIP() {
        $remoteAddr = $_SERVER['REMOTE_ADDR'] ?? '0.0.0.0';
        $isCloudflare = false;

        foreach (self::$cfIpsV4 as $range) {
            if (self::ipInRange($remoteAddr, $range)) { $isCloudflare = true; break; }
        }
        if (!$isCloudflare) {
            foreach (self::$cfIpsV6 as $range) {
                if (self::ipInRange($remoteAddr, $range)) { $isCloudflare = true; break; }
            }
        }

        if ($isCloudflare) {
            if (!empty($_SERVER['HTTP_CF_CONNECTING_IP'])) {
                return trim(explode(',', $_SERVER['HTTP_CF_CONNECTING_IP'])[0]);
            }
            if (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
                return trim(explode(',', $_SERVER['HTTP_X_FORWARDED_FOR'])[0]);
            }
        }

        return $remoteAddr;
    }

    /**
     * Get IP Prefix (/24 for IPv4, /64 for IPv6)
     */
    public static function getIpPrefix($ip) {
        if (filter_var($ip, FILTER_VALIDATE_IP, FILTER_FLAG_IPV4)) {
            $parts = explode('.', $ip);
            return $parts[0] . '.' . $parts[1] . '.' . $parts[2] . '.0/24';
        } elseif (filter_var($ip, FILTER_VALIDATE_IP, FILTER_FLAG_IPV6)) {
            // Very simplified /64 prefix extraction for IPv6
            $ipBin = inet_pton($ip);
            if ($ipBin !== false) {
                $prefix = substr($ipBin, 0, 8) . str_repeat(chr(0), 8);
                return inet_ntop($prefix) . '/64';
            }
        }
        return $ip;
    }

    /**
     * Get User Agent Hash
     */
    public static function getUaHash($ua) {
        return hash('sha256', trim($ua));
    }

    /**
     * Generate Strong Device Fingerprint Hash
     */
    public static function getDeviceFingerprint($uaHash, $ipPrefix) {
        return hash_hmac('sha256', $uaHash . '|' . $ipPrefix, SECRET_KEY);
    }

    /**
     * Build Canonical HMAC Payload
     */
    public static function buildHmacPayload($rid, $uid, $deviceFingerprint, $ipPrefix, $uaHash, $expiry) {
        return "$rid|$uid|$deviceFingerprint|$ipPrefix|$uaHash|$expiry";
    }

    /**
     * Generate HMAC Signature
     */
    public static function generateHmac($rid, $uid, $deviceFingerprint, $ipPrefix, $uaHash, $expiry) {
        $payload = self::buildHmacPayload($rid, $uid, $deviceFingerprint, $ipPrefix, $uaHash, $expiry);
        return hash_hmac('sha256', $payload, SECRET_KEY);
    }

    /**
     * Verify HMAC Signature
     */
    public static function verifyHmac($sig, $rid, $uid, $deviceFingerprint, $ipPrefix, $uaHash, $expiry) {
        if (time() > $expiry) return false;
        $expectedSig = self::generateHmac($rid, $uid, $deviceFingerprint, $ipPrefix, $uaHash, $expiry);
        $isValid = hash_equals($expectedSig, $sig);

        if (!$isValid) {
            $expectedPayload = self::buildHmacPayload($rid, $uid, $deviceFingerprint, $ipPrefix, $uaHash, $expiry);
            error_log("HMAC MISMATCH | RID: $rid | UID: $uid | EXP: $expiry | EXPECTED SIG: $expectedSig | PROVIDED SIG: $sig");
        }
        return $isValid;
    }

    /**
     * Rate Limiting Check
     * Returns true if allowed, false if limit exceeded
     */
    public static function checkRateLimit($uid, $deviceHash, $ipPrefix) {
        global $db;
        if (!$db) $db = getDB(); // Ensure we grab it from config.php if global fails

        $hashKey = hash('sha256', "$uid:$deviceHash:$ipPrefix");
        $window = RATE_LIMIT_WINDOW;
        $maxRequests = RATE_LIMIT_REQUESTS;

        // Cleanup old rate limits
        if (rand(1, 100) === 1) {
            $db->exec("DELETE FROM rate_limits WHERE reset_at < " . time() . "");
            $db->exec("DELETE FROM proxy_mappings WHERE expires_at < '" . date('Y-m-d H:i:s') . "'");
        }

        $stmt = $db->prepare("SELECT requests, reset_at FROM rate_limits WHERE hash_key = ?");
        $stmt->execute([$hashKey]);
        $row = $stmt->fetch();

        if ($row) {
            if ($row['reset_at'] < time()) {
                // Reset window
                $resetAt = time() + $window;
                $stmt = $db->prepare("UPDATE rate_limits SET requests = 1, reset_at = ? WHERE hash_key = ?");
                $stmt->execute([$resetAt, $hashKey]);
                return true;
            } else {
                if ($row['requests'] >= $maxRequests) {
                    return false; // Limit exceeded
                }
                $stmt = $db->prepare("UPDATE rate_limits SET requests = requests + 1 WHERE hash_key = ?");
                $stmt->execute([$hashKey]);
                return true;
            }
        } else {
            $resetAt = time() + $window;
            $stmt = $db->prepare("INSERT INTO rate_limits (hash_key, requests, reset_at) VALUES (?, 1, ?)");
            $stmt->execute([$hashKey, $resetAt]);
            return true;
        }
    }

    /**
     * Create a Proxy Mapping
     */
    public static function createProxyMapping($originalUrl, $uid, $ipPrefix, $uaHash, $deviceFingerprint, $isPlaylist = false) {
        global $db;
        if (!$db) $db = getDB();

        $rid = bin2hex(random_bytes(16));
        $expirySeconds = $isPlaylist ? PLAYLIST_SIGNED_TTL : SEGMENT_SIGNED_TTL;
        $expiresAt = date('Y-m-d H:i:s', time() + $expirySeconds);

        $stmt = $db->prepare("INSERT INTO proxy_mappings (rid, user_id, original_url, ip_prefix, ua_hash, device_fingerprint, expires_at) VALUES (?, ?, ?, ?, ?, ?, ?)");
        $stmt->execute([$rid, $uid, $originalUrl, $ipPrefix, $uaHash, $deviceFingerprint, $expiresAt]);
        return $rid;
    }

    /**
     * Resolve Proxy Mapping
     */
    public static function resolveProxyMapping($rid) {
        global $db;
        if (!$db) $db = getDB();

        $stmt = $db->prepare("SELECT * FROM proxy_mappings WHERE rid = ? AND expires_at > '" . date('Y-m-d H:i:s') . "'");
        $stmt->execute([$rid]);
        return $stmt->fetch() ?: null;
    }

    /**
     * Build Signed Proxy URL
     */
    public static function buildProxyUrl($rid, $uid, $deviceFingerprint, $ipPrefix, $uaHash, $isPlaylist = false) {
        $expiry = time() + ($isPlaylist ? PLAYLIST_SIGNED_TTL : SEGMENT_SIGNED_TTL);
        $sig = self::generateHmac($rid, $uid, $deviceFingerprint, $ipPrefix, $uaHash, $expiry);

        $proxyUrl = SECURE_PANEL_URL . '/proxy/asset.php' .
            '?rid=' . urlencode($rid) .
            '&uid=' . urlencode($uid) .
            '&exp=' . urlencode($expiry) .
            '&sig=' . urlencode($sig);

        return $proxyUrl;
    }

    /**
     * Parse and Rewrite M3U/M3U8 Content
     */
    public static function rewritePlaylist($content, $uid, $deviceFingerprint, $ipPrefix, $uaHash, $sourceUrl) {
        $lines = explode("\n", $content);
        $output = [];

        // Helper to resolve relative URLs
        $resolveUrl = function($url) use ($sourceUrl) {
            if (strpos($url, 'http://') === 0 || strpos($url, 'https://') === 0) {
                return $url;
            }
            $parsed = parse_url($sourceUrl);
            $base = $parsed['scheme'] . '://' . $parsed['host'] . (isset($parsed['port']) ? ':' . $parsed['port'] : '');

            if (strpos($url, '/') === 0) {
                return $base . $url;
            } else {
                $path = isset($parsed['path']) ? $parsed['path'] : '/';
                $dir = dirname($path);
                if ($dir === '/' || $dir === '\\') $dir = '';

                // If directory is empty, we must append a slash before the relative URL
                if (empty($dir)) {
                    $dir = '/';
                }

                // Ensure $dir ends with a slash if it's not empty and we're appending
                if (substr($dir, -1) !== '/') {
                    $dir .= '/';
                }
                return $base . $dir . $url;
            }
        };

        foreach ($lines as $line) {
            $line = trim($line);
            if (empty($line)) continue;

            if (strpos($line, '#EXT-X-KEY:') === 0 || strpos($line, '#EXT-X-MAP:') === 0 || strpos($line, '#EXT-X-MEDIA:') === 0 || strpos($line, '#EXT-X-I-FRAME-STREAM-INF:') === 0) {
                // Rewrite URI="..." attributes
                $line = preg_replace_callback('/URI="([^"]+)"/', function($matches) use ($resolveUrl, $uid, $ipPrefix, $uaHash, $deviceFingerprint) {
                    $originalUrl = $resolveUrl($matches[1]);
                    $isChildList = (strpos($originalUrl, ".m3u") !== false); $rid = self::createProxyMapping($originalUrl, $uid, $ipPrefix, $uaHash, $deviceFingerprint, $isChildList);
                    $proxyUrl = self::buildProxyUrl($rid, $uid, $deviceFingerprint, $ipPrefix, $uaHash, $isChildList);
                    return 'URI="' . $proxyUrl . '"';
                }, $line);
                $output[] = $line;
            } elseif (strpos($line, '#') === 0) {
                // Other comments / tags
                $output[] = $line;
            } else {
                // It's a URL (segment, stream, child playlist)
                $originalUrl = $resolveUrl($line);
                $isChildList = (strpos($originalUrl, ".m3u") !== false); $rid = self::createProxyMapping($originalUrl, $uid, $ipPrefix, $uaHash, $deviceFingerprint, $isChildList);
                $proxyUrl = self::buildProxyUrl($rid, $uid, $deviceFingerprint, $ipPrefix, $uaHash, $isChildList);
                $output[] = $proxyUrl;
            }
        }

        return implode("\n", $output) . "\n";
    }
}
