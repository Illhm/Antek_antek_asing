<?php
// ============================================
// IPTV Panel - Configuration
// ============================================

#$<<<<<<< jules-7723024745216889762-3e6247d4
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
#=======
define('DB_HOST', 'localhost');
define('DB_NAME', 'tipimemy_iptv_panel');
define('DB_USER', 'tipimemy_iptv');       // Ganti dengan user MySQL Anda
define('DB_PASS', '');           // Ganti dengan password MySQL Anda
define('DB_CHARSET', 'utf8mb4');

// Panel settings
define('PANEL_NAME', 'Tipistream Panel');
define('PANEL_URL', 'http://ott.tipime.my.id'); // Ganti dengan domain Anda
define('TOKEN_EXPIRE_HOURS', 6);   // Token stream expired setelah X jam
define('SESSION_EXPIRE', 3600);    // Admin session expire (detik)
#>>>>>>> main

// Helper to get env variable or fallback
function getEnvOrDefault($key, $default) {
    $val = getenv($key);
    return $val !== false ? $val : $default;
}

// Fallback to default constants if missing in .env (or get from system environment variables for Docker/Railway)
defined('DB_DRIVER') or define('DB_DRIVER', 'sqlite');
defined('SQLITE_DB_PATH') or define('SQLITE_DB_PATH', getEnvOrDefault('SQLITE_DB_PATH', '/data/database.sqlite'));

defined('PANEL_NAME') or define('PANEL_NAME', getEnvOrDefault('PANEL_NAME', 'Tipistream Panel'));
defined('PANEL_URL') or define('PANEL_URL', getEnvOrDefault('PANEL_URL', 'https://ott.tipime.my.id'));
defined('TOKEN_EXPIRE_HOURS') or define('TOKEN_EXPIRE_HOURS', (int)getEnvOrDefault('TOKEN_EXPIRE_HOURS', 6));
defined('SESSION_EXPIRE') or define('SESSION_EXPIRE', (int)getEnvOrDefault('SESSION_EXPIRE', 3600));
defined('FREE_PLAYLIST_URL') or define('FREE_PLAYLIST_URL', getEnvOrDefault('FREE_PLAYLIST_URL', 'https://iptv.tipime.my.id/data/playlists/free.m3u'));
defined('SECRET_KEY') or define('SECRET_KEY', getEnvOrDefault('SECRET_KEY', 'GANTI_DENGAN_RANDOM_STRING_PANJANG_32CHAR'));
defined('TIMEZONE') or define('TIMEZONE', getEnvOrDefault('TIMEZONE', 'Asia/Jakarta'));
defined('PROXY_EXPIRE_SECONDS') or define('PROXY_EXPIRE_SECONDS', (int)getEnvOrDefault('PROXY_EXPIRE_SECONDS', 7200));
defined('RATE_LIMIT_REQUESTS') or define('RATE_LIMIT_REQUESTS', (int)getEnvOrDefault('RATE_LIMIT_REQUESTS', 300));
defined('RATE_LIMIT_WINDOW') or define('RATE_LIMIT_WINDOW', (int)getEnvOrDefault('RATE_LIMIT_WINDOW', 60));

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
    $stmt = $pdo->query("SELECT count(*) FROM admins");
    if ($stmt && $stmt->fetchColumn() == 0) {
        $username = getEnvOrDefault('ADMIN_USERNAME', 'admin');
        $password = getEnvOrDefault('ADMIN_PASSWORD', '1');
        $hash = password_hash($password, PASSWORD_BCRYPT);

        try {
            $insert = $pdo->prepare("INSERT INTO admins (username, password, email, role) VALUES (?, ?, 'admin@localhost', 'superadmin')");
            $insert->execute([$username, $hash]);
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
