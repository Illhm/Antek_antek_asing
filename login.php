<?php
require_once 'includes/config.php';

if (isAdminLoggedIn()) redirect(PANEL_URL . '/admin/dashboard.php');

$error = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = trim($_POST['username'] ?? '');
    $password = $_POST['password'] ?? '';

    if ($username && $password) {
        $db = getDB();
        $stmt = $db->prepare("SELECT * FROM admins WHERE username = ?");
        $stmt->execute([$username]);
        $admin = $stmt->fetch();

        if ($admin && password_verify($password, $admin['password'])) {
            $_SESSION['admin_id']   = $admin['id'];
            $_SESSION['admin_user'] = $admin['username'];
            $_SESSION['admin_role'] = $admin['role'];
            logAccess($admin['id'], null, 'login', 'Login berhasil');
            redirect(PANEL_URL . '/admin/dashboard.php');
        } else {
            $error = 'Username atau password salah.';
            logAccess(null, null, 'login', "Gagal login: $username");
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
        <div class="form-group">
            <label>Username</label>
            <input type="text" name="username" class="form-control" placeholder="Username admin" required autofocus>
        </div>
        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" class="form-control" placeholder="Password" required>
        </div>
        <button type="submit" class="btn btn-primary btn-block" style="margin-top:4px">Login →</button>
    </form>
</div>
</body>
</html>
