<?php
require_once '../includes/config.php';
requireAdmin();

$db = getDB();
$msg = $err = '';

if (($_POST['action'] ?? '') === 'block') {
    if (!isset($_POST['csrf_token']) || !hash_equals($_SESSION['csrf_token'], $_POST['csrf_token'])) die('CSRF token validation failed');
    $ip     = trim($_POST['ip'] ?? '');
    $reason = trim($_POST['reason'] ?? '');
    if (filter_var($ip, FILTER_VALIDATE_IP)) {
        try {
            $db->prepare("INSERT INTO blocked_ips (ip_address, reason) VALUES (?,?)")->execute([$ip, $reason]);
            $msg = "IP <b>$ip</b> berhasil diblokir.";
        } catch (PDOException $e) { $err = "IP sudah ada di daftar blokir."; }
    } else { $err = "Format IP tidak valid."; }
}

if (($_POST['action'] ?? '') === 'unblock') {
    if (!isset($_POST['csrf_token']) || !hash_equals($_SESSION['csrf_token'], $_POST['csrf_token'])) die('CSRF token validation failed');
    $id = (int)$_POST['id'];
    $db->prepare("DELETE FROM blocked_ips WHERE id=?")->execute([$id]);
    $msg = "IP berhasil diunblokir.";
}

$blocked = $db->query("SELECT * FROM blocked_ips ORDER BY blocked_at DESC")->fetchAll();
?>
<!DOCTYPE html>
<html lang="id">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Blokir IP - <?= PANEL_NAME ?></title>
<link rel="stylesheet" href="../assets/css/style.css">
</head>
<body>
<?php include 'partials/sidebar.php'; ?>
<div class="main-content">
<?php include 'partials/topbar.php'; ?>
<div class="page-content">
    <div class="page-header">
        <h2 class="page-title">🚫 Manajemen Blokir IP</h2>
    </div>

    <?php if ($msg): ?><div class="alert alert-success"><?= $msg ?></div><?php endif; ?>
    <?php if ($err): ?><div class="alert alert-danger"><?= sanitize($err) ?></div><?php endif; ?>

    <div class="card mb-1">
        <div class="card-header">Tambah IP ke Blacklist</div>
        <div class="card-body">
            <form method="POST">
        <input type="hidden" name="csrf_token" value="<?= sanitize($_SESSION['csrf_token']) ?>">
                <input type="hidden" name="action" value="block">
                <div class="form-row" style="margin-bottom:10px">
                    <div class="form-group" style="margin-bottom:0">
                        <label>IP Address</label>
                        <input type="text" name="ip" class="form-control" placeholder="Contoh: 192.168.1.100" required>
                    </div>
                    <div class="form-group" style="margin-bottom:0">
                        <label>Alasan (opsional)</label>
                        <input type="text" name="reason" class="form-control" placeholder="Alasan pemblokiran">
                    </div>
                </div>
                <button type="submit" class="btn btn-danger">🚫 Blokir IP</button>
            </form>
        </div>
    </div>

    <div class="card">
        <div class="card-body p0">
            <div class="table-wrapper">
            <table class="table table-compact">
                <thead>
                    <tr><th>IP Address</th><th class="hide-mobile">Alasan</th><th class="hide-mobile">Diblokir</th><th>Aksi</th></tr>
                </thead>
                <tbody>
                <?php foreach ($blocked as $b): ?>
                <tr>
                    <td>
                        <code><?= sanitize($b['ip_address']) ?></code>
                        <?php if ($b['reason']): ?>
                        <br class="d-none d-mobile-block"><small class="text-muted"><?= sanitize($b['reason']) ?></small>
                        <?php endif; ?>
                    </td>
                    <td class="hide-mobile text-sm text-muted"><?= sanitize($b['reason'] ?: '—') ?></td>
                    <td class="hide-mobile text-sm text-muted"><?= date('d/m/Y H:i', strtotime($b['blocked_at'])) ?></td>
                    <td>
                                <form method="POST" style="display:inline;">
                                    <input type="hidden" name="csrf_token" value="<?= sanitize($_SESSION['csrf_token']) ?>">
                                    <input type="hidden" name="action" value="unblock">
                                    <input type="hidden" name="id" value="<?= $b['id'] ?>">
                                    <button type="submit" class="btn btn-sm btn-success" onclick="return confirm('Hapus blokir untuk IP ini?')">Unblock</button>
                                </form>
                            </td>
                </tr>
                <?php endforeach; ?>
                <?php if (empty($blocked)): ?>
                <tr><td colspan="4" class="text-center text-muted" style="padding:32px">Tidak ada IP yang diblokir.</td></tr>
                <?php endif; ?>
                </tbody>
            </table>
            </div>
        </div>
    </div>
</div>
</div>
<script src="../assets/js/app.js"></script>
</body>
</html>
