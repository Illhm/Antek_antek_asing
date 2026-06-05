<?php
require_once 'includes/config.php';

if (isAdminLoggedIn()) redirect(PANEL_URL . '/admin/dashboard.php');

$error = '';
$ip = getClientIP();


if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = trim($_POST['username'] ?? '');
    $password = $_POST['password'] ?? '';
    $csrfToken = $_POST['csrf_token'] ?? '';

    // Rate Limiting Logic for Login
    $db = getDB();
    $rateLimitKey = 'login_' . md5($ip);
    $window = 300; // 5 minutes
    $maxAttempts = 5;
    $now = time();

    // Clean old rate limits
    $db->prepare("DELETE FROM rate_limits WHERE reset_at < ?")->execute([$now]);

    $stmt = $db->prepare("SELECT requests, reset_at FROM rate_limits WHERE hash_key = ?");
    $stmt->execute([$rateLimitKey]);
    $rateLimit = $stmt->fetch();

    if ($rateLimit && $rateLimit['requests'] >= $maxAttempts && $rateLimit['reset_at'] > $now) {
        $error = 'Terlalu banyak percobaan login. Silakan coba lagi nanti.';
    } elseif (!hash_equals($_SESSION['csrf_token'], $csrfToken)) {
        $error = 'CSRF token tidak valid.';
    } elseif ($username && $password) {
        $stmt = $db->prepare("SELECT * FROM admins WHERE username = ?");
        $stmt->execute([$username]);
        $admin = $stmt->fetch();

        if ($admin && password_verify($password, $admin['password'])) {
            // Prevent Session Fixation
            session_regenerate_id(true);

            $_SESSION['admin_id']   = $admin['id'];
            $_SESSION['admin_user'] = $admin['username'];
            $_SESSION['admin_role'] = $admin['role'];
            $db->prepare("DELETE FROM rate_limits WHERE hash_key = ?")->execute([$rateLimitKey]);
            logAccess($admin['id'], null, 'login', 'Login berhasil');
            redirect(PANEL_URL . '/admin/dashboard.php');
        } else {
            $error = 'Username atau password salah.';
            logAccess(null, null, 'login', "Gagal login: $username");

            // Increment rate limit
            if ($rateLimit) {
                $db->prepare("UPDATE rate_limits SET requests = requests + 1 WHERE hash_key = ?")->execute([$rateLimitKey]);
            } else {
                $db->prepare("INSERT INTO rate_limits (hash_key, requests, reset_at) VALUES (?, 1, ?)")->execute([$rateLimitKey, $now + $window]);
            }
        }
    } else {
        $error = 'Isi semua field.';
    }
}
?>
<!DOCTYPE html>
<html lang="id">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login - <?= PANEL_NAME ?></title>
<link rel="stylesheet" href="assets/css/style.css">
</head>
<body class="login-body">
<div class="login-container">
    <div class="login-logo">
        <h1>⚡ <?= PANEL_NAME ?></h1>
        <p>IPTV Management Panel</p>
    </div>
    <?php if ($error): ?>
    <div class="alert alert-danger"><?= sanitize($error) ?></div>
    <?php endif; ?>
    <form method="POST" autocomplete="off">
        <input type="hidden" name="csrf_token" value="<?= sanitize($_SESSION['csrf_token']) ?>">
        <div class="form-group">
            <label>Username</label>
            <input type="text" name="username" class="form-control" required autofocus>
        </div>
        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" class="form-control" required>
        </div>
        <button type="submit" class="btn btn-primary btn-block">LOGIN</button>
    </form>
</div>
</body>
</html>
