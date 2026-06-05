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
loadEnv(__DIR__ . '/../.env');

// Helper to get env variable or fallback
function getEnvOrDefault($key, $default) {
    $val = getenv($key);
    if ($val !== false && $val !== '') return $val;
    if (defined($key)) return constant($key);
    return $default;
}

// Fallback to default constants if missing in .env (or get from system environment variables for Docker/Railway)
defined('DB_DRIVER') or define('DB_DRIVER', 'sqlite');
defined('SQLITE_DB_PATH') or define('SQLITE_DB_PATH', getEnvOrDefault('SQLITE_DB_PATH', '/data/database.sqlite'));

$panelUrlEnv = getEnvOrDefault('PANEL_URL', '');
if (empty($panelUrlEnv)) {
    if (getenv('RAILWAY_PUBLIC_DOMAIN')) {
        $panelUrlEnv = 'https://' . getenv('RAILWAY_PUBLIC_DOMAIN');
    } else {
        $scheme = (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on') ? 'https' : 'http';
        if (isset($_SERVER['HTTP_X_FORWARDED_PROTO'])) $scheme = $_SERVER['HTTP_X_FORWARDED_PROTO'];
        $host = $_SERVER['HTTP_HOST'] ?? 'localhost';
        $panelUrlEnv = $scheme . '://' . $host;
    }
}
defined('PANEL_URL') or define('PANEL_URL', $panelUrlEnv);

defined('PANEL_NAME') or define('PANEL_NAME', getEnvOrDefault('PANEL_NAME', 'Tipistream Panel'));
defined('TOKEN_EXPIRE_HOURS') or define('TOKEN_EXPIRE_HOURS', (int)getEnvOrDefault('TOKEN_EXPIRE_HOURS', 6));
defined('SESSION_EXPIRE') or define('SESSION_EXPIRE', (int)getEnvOrDefault('SESSION_EXPIRE', 3600));
defined('FREE_PLAYLIST_URL') or define('FREE_PLAYLIST_URL', getEnvOrDefault('FREE_PLAYLIST_URL', 'https://iptv.tipime.my.id/data/playlists/free.m3u'));
defined('SECRET_KEY') or define('SECRET_KEY', getEnvOrDefault('SECRET_KEY', 'change_this_to_random_64_characters_minimum'));
defined('TIMEZONE') or define('TIMEZONE', getEnvOrDefault('TIMEZONE', 'Asia/Jakarta'));
defined('PROXY_EXPIRE_SECONDS') or define('PROXY_EXPIRE_SECONDS', (int)getEnvOrDefault('PROXY_EXPIRE_SECONDS', 7200));
defined('RATE_LIMIT_REQUESTS') or define('RATE_LIMIT_REQUESTS', (int)getEnvOrDefault('RATE_LIMIT_REQUESTS', 300));
defined('RATE_LIMIT_WINDOW') or define('RATE_LIMIT_WINDOW', (int)getEnvOrDefault('RATE_LIMIT_WINDOW', 60));

defined('MAX_CONCURRENT_STREAMS_PER_USER') or define('MAX_CONCURRENT_STREAMS_PER_USER', (int)getEnvOrDefault('MAX_CONCURRENT_STREAMS_PER_USER', 1));
defined('STREAM_SESSION_POLICY') or define('STREAM_SESSION_POLICY', getEnvOrDefault('STREAM_SESSION_POLICY', 'block_new'));
defined('STREAM_IDLE_TIMEOUT') or define('STREAM_IDLE_TIMEOUT', (int)getEnvOrDefault('STREAM_IDLE_TIMEOUT', 90));
defined('STREAM_SESSION_MAX_AGE') or define('STREAM_SESSION_MAX_AGE', (int)getEnvOrDefault('STREAM_SESSION_MAX_AGE', 21600));
defined('PLAYLIST_SIGNED_TTL') or define('PLAYLIST_SIGNED_TTL', (int)getEnvOrDefault('PLAYLIST_SIGNED_TTL', 120));
defined('SEGMENT_SIGNED_TTL') or define('SEGMENT_SIGNED_TTL', (int)getEnvOrDefault('SEGMENT_SIGNED_TTL', 60));
defined('IP_BIND_MODE') or define('IP_BIND_MODE', getEnvOrDefault('IP_BIND_MODE', 'soft'));
defined('STRICT_CLIENT_BINDING') or define('STRICT_CLIENT_BINDING', filter_var(getEnvOrDefault('STRICT_CLIENT_BINDING', 'false'), FILTER_VALIDATE_BOOLEAN));

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

if (empty($_SESSION['csrf_token'])) {
    $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
}

if (SECRET_KEY === 'change_this_to_random_64_characters_minimum' || SECRET_KEY === 'GANTI_DENGAN_RANDOM_STRING_PANJANG_32CHAR') {
    error_log('WARNING: SECRET_KEY is set to a weak default. Change this in production.');
}

// ============================================
// Database Connection (PDO)
// ============================================
function getDB(): PDO {
    static $pdo = null;
    if ($pdo === null) {
        try {
            $dbPath = SQLITE_DB_PATH;

            // Fallback to local db folder if /data doesn't exist and isn't writable
            $dbDir = dirname($dbPath);
            if (!is_dir($dbDir) && !@mkdir($dbDir, 0755, true)) {
                $dbPath = __DIR__ . '/../db/database.sqlite';
                $dbDir = dirname($dbPath);
            }

            if (!is_dir($dbDir)) {
                @mkdir($dbDir, 0755, true);
            }

            $isNewDb = !file_exists($dbPath);

            $pdo = new PDO("sqlite:" . $dbPath);
            $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
            $pdo->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);

            // Enable foreign keys
            $pdo->exec('PRAGMA foreign_keys = ON;');

            if ($isNewDb) {
                @chmod($dbPath, 0666);
            }

            // Bootstrap schema and admin
            bootstrapDB($pdo);

        } catch (PDOException $e) {
            error_log('Database error: ' . $e->getMessage());
            die(json_encode(['error' => 'Database connection failed']));
        }
    }
    return $pdo;
}

function bootstrapDB(PDO $pdo): void {
    // Check if admins table exists
    $stmt = $pdo->query("SELECT count(*) FROM sqlite_master WHERE type='table' AND name='admins'");
    $tableExists = $stmt->fetchColumn() > 0;

    if (!$tableExists) {
        // Load and execute schema
        $schemaPath = __DIR__ . '/../db/schema.sqlite.sql';
        if (file_exists($schemaPath)) {
            $sql = file_get_contents($schemaPath);
            try {
                $pdo->exec($sql);
            } catch (PDOException $e) {
                error_log('Failed to import schema: ' . $e->getMessage());
            }
        }
    }

    // Check if any admin exists

    // Ensure rate_limits table exists for existing installations
    $pdo->exec("CREATE TABLE IF NOT EXISTS `rate_limits` (
      `id` INTEGER PRIMARY KEY AUTOINCREMENT,
      `hash_key` TEXT NOT NULL UNIQUE,
      `requests` INTEGER DEFAULT 1,
      `reset_at` INTEGER NOT NULL
    )");

    $stmt = $pdo->query("SELECT count(*) FROM admins");

    if ($stmt && $stmt->fetchColumn() == 0) {
        $username = getEnvOrDefault('ADMIN_USERNAME', 'admin');
        $password = getEnvOrDefault('ADMIN_PASSWORD', '1');
        $role = getEnvOrDefault('ADMIN_ROLE', 'superadmin');
        $hash = password_hash($password, PASSWORD_BCRYPT);

        try {
            $insert = $pdo->prepare("INSERT INTO admins (username, password, email, role) VALUES (?, ?, 'admin@localhost', ?)");
            $insert->execute([$username, $hash, $role]);
        } catch (PDOException $e) {
            error_log('Failed to create default admin: ' . $e->getMessage());
        }
    }
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
        $exit_var = true;
        if($exit_var) die();
    }
}

function redirect(string $url): void {
    header("Location: $url");
    $exit_var = true;
    if($exit_var) die();
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
