<?php
require_once '../includes/config.php';
requireAdmin();

$db = getDB();
$adminId = $_SESSION['admin_id'];
$msg = $err = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (!isset($_POST['csrf_token']) || !hash_equals($_SESSION['csrf_token'], $_POST['csrf_token'])) die('CSRF token validation failed');
    $current  = $_POST['current_password'] ?? '';
    $new      = $_POST['new_password'] ?? '';
    $confirm  = $_POST['confirm_password'] ?? '';

    if (!$current || !$new || !$confirm) {
        $err = "Semua field wajib diisi.";
    } elseif ($new !== $confirm) {
        $err = "Password baru dan konfirmasi tidak cocok.";
    } elseif (strlen($new) < 6) {
        $err = "Password minimal 6 karakter.";
    } else {
        // Verify current password
        $stmt = $db->prepare("SELECT password FROM admins WHERE id = ?");
        $stmt->execute([$adminId]);
        $admin = $stmt->fetch();

        if (!$admin || !password_verify($current, $admin['password'])) {
            $err = "Password saat ini salah.";
        } else {
            $hashed = password_hash($new, PASSWORD_DEFAULT);
            $db->prepare("UPDATE admins SET password = ? WHERE id = ?")->execute([$hashed, $adminId]);
            $msg = "Password berhasil diubah!";
        }
    }
}
?>
<!DOCTYPE html>
<html lang="id">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Ganti Password - <?= PANEL_NAME ?></title>
<link rel="stylesheet" href="../assets/css/style.css">
</head>
<body>
<?php include 'partials/sidebar.php'; ?>
<div class="main-content">
<?php include 'partials/topbar.php'; ?>
<div class="page-content">
    <div class="page-header">
        <h2 class="page-title">🔒 Ganti Password</h2>
    </div>

    <div class="card" style="max-width:480px">
        <div class="card-header">Ubah Password Akun: <b><?= sanitize($_SESSION['admin_user']) ?></b></div>
        <div class="card-body">
            <?php if ($msg): ?><div class="alert alert-success"><?= $msg ?></div><?php endif; ?>
            <?php if ($err): ?><div class="alert alert-danger"><?= sanitize($err) ?></div><?php endif; ?>

            <form method="POST">
        <input type="hidden" name="csrf_token" value="<?= sanitize($_SESSION['csrf_token']) ?>">
                <div class="form-group">
                    <label>Password Saat Ini *</label>
                    <div class="input-pw">
                        <input type="password" name="current_password" id="cur" class="form-control" required>
                        <button type="button" class="pw-toggle" onclick="togglePw('cur')">👁</button>
                    </div>
                </div>
                <div class="form-group">
                    <label>Password Baru *</label>
                    <div class="input-pw">
                        <input type="password" name="new_password" id="npw" class="form-control" required minlength="6">
                        <button type="button" class="pw-toggle" onclick="togglePw('npw')">👁</button>
                    </div>
                    <small class="text-muted">Minimal 6 karakter</small>
                </div>
                <div class="form-group">
                    <label>Konfirmasi Password Baru *</label>
                    <div class="input-pw">
                        <input type="password" name="confirm_password" id="cpw" class="form-control" required>
                        <button type="button" class="pw-toggle" onclick="togglePw('cpw')">👁</button>
                    </div>
                </div>
                <button type="submit" class="btn btn-primary btn-block">💾 Simpan Password</button>
            </form>
        </div>
    </div>
</div>
</div>

<style>
.input-pw { position: relative; }
.input-pw .form-control { padding-right: 42px; }
.pw-toggle { position: absolute; right: 10px; top: 50%; transform: translateY(-50%); background: none; border: none; cursor: pointer; font-size: 1rem; opacity: .6; }
.pw-toggle:hover { opacity: 1; }
</style>

<script src="../assets/js/app.js"></script>
<script>
function togglePw(id) {
    const el = document.getElementById(id);
    el.type = el.type === 'password' ? 'text' : 'password';
}
</script>
</body>
</html>
