<?php
// ============================================
// IPTV Panel - Configuration
// ============================================

// Parse .env file manually (minimal footprint, works without composer)
function loadEnv($path) {
    if (!file_exists($path)) return;
    $lines = file($path, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
    foreach ($lines as $line) {
        if (strpos(trim($line), '#') === 0) continue;
        list($name, $value) = explode('=', $line, 2) + [NULL, NULL];
        if ($name !== NULL) {
            $name = trim($name);
            $value = trim($value, " \t\n\r\0\x0B\"'");
            if (!defined($name)) define($name, $value);
        }
    }
}
loadEnv(__DIR__ . '/.env');

// Fallback to default constants if missing in .env
defined('DB_HOST') or define('DB_HOST', 'localhost');
defined('DB_NAME') or define('DB_NAME', 'tipimemy_iptv_panel');
defined('DB_USER') or define('DB_USER', 'root');
defined('DB_PASS') or define('DB_PASS', '');
defined('DB_CHARSET') or define('DB_CHARSET', 'utf8mb4');

defined('PANEL_NAME') or define('PANEL_NAME', 'Tipistream Panel');
defined('PANEL_URL') or define('PANEL_URL', 'https://ott.tipime.my.id');
defined('TOKEN_EXPIRE_HOURS') or define('TOKEN_EXPIRE_HOURS', 6);
defined('SESSION_EXPIRE') or define('SESSION_EXPIRE', 3600);
defined('FREE_PLAYLIST_URL') or define('FREE_PLAYLIST_URL', 'https://iptv.tipime.my.id/data/playlists/free.m3u');
defined('SECRET_KEY') or define('SECRET_KEY', 'GANTI_DENGAN_RANDOM_STRING_PANJANG_32CHAR');
defined('TIMEZONE') or define('TIMEZONE', 'Asia/Jakarta');
defined('PROXY_EXPIRE_SECONDS') or define('PROXY_EXPIRE_SECONDS', 7200);
defined('RATE_LIMIT_REQUESTS') or define('RATE_LIMIT_REQUESTS', 300);
defined('RATE_LIMIT_WINDOW') or define('RATE_LIMIT_WINDOW', 60);

// Ensure HTTPS is used for PANEL_URL
$panelUrl = PANEL_URL;
if (strpos($panelUrl, 'http://') === 0) {
    $panelUrl = 'https://' . substr($panelUrl, 7);
}
define('SECURE_PANEL_URL', rtrim($panelUrl, '/'));

date_default_timezone_set(TIMEZONE);
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

// ============================================
// Database Connection (PDO)
// ============================================
function getDB(): PDO {
    static $pdo = null;
    if ($pdo === null) {
        try {
            $dsn = "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=" . DB_CHARSET;
            $pdo = new PDO($dsn, DB_USER, DB_PASS, [
                PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES   => false,
            ]);
        } catch (PDOException $e) {
            die(json_encode(['error' => 'Database connection failed']));
        }
    }
    return $pdo;
}

// ============================================
// Helper Functions
// ============================================

function generateToken(int $length = 64): string {
    return bin2hex(random_bytes($length / 2));
}

function hashToken(string $token): string {
    return hash_hmac('sha256', $token, SECRET_KEY);
}

function getClientIP(): string {
    foreach (['HTTP_CF_CONNECTING_IP','HTTP_X_FORWARDED_FOR','HTTP_X_REAL_IP','REMOTE_ADDR'] as $key) {
        if (!empty($_SERVER[$key])) {
            $ip = trim(explode(',', $_SERVER[$key])[0]);
            if (filter_var($ip, FILTER_VALIDATE_IP)) return $ip;
        }
    }
    return '0.0.0.0';
}

function getUA(): string {
    return $_SERVER['HTTP_USER_AGENT'] ?? 'Unknown';
}

function isAdminLoggedIn(): bool {
    return isset($_SESSION['admin_id']) && isset($_SESSION['admin_role']);
}

function requireAdmin(): void {
    if (!isAdminLoggedIn()) {
        header('Location: ' . PANEL_URL . '/login.php');
        exit;
    }
}

function redirect(string $url): void {
    header("Location: $url");
    exit;
}

function sanitize(string $str): string {
    return htmlspecialchars(trim($str), ENT_QUOTES, 'UTF-8');
}

function logAccess(int|null $userId, string|null $token, string $action, string $detail = ''): void {
    try {
        $db = getDB();
        $stmt = $db->prepare("INSERT INTO access_logs (user_id, token, ip_address, user_agent, action, detail) VALUES (?,?,?,?,?,?)");
        $stmt->execute([$userId, $token, getClientIP(), getUA(), $action, $detail]);
    } catch (Exception $e) { /* silent fail */ }
}

function isIPBlocked(string $ip): bool {
    $db = getDB();
    $stmt = $db->prepare("SELECT id FROM blocked_ips WHERE ip_address = ?");
    $stmt->execute([$ip]);
    return (bool)$stmt->fetch();
}
