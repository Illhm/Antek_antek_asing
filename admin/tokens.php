<?php
require_once '../includes/config.php';
requireAdmin();

$db = getDB();
$adminId = $_SESSION['admin_id'];
$role    = $_SESSION['admin_role'];

if (isset($_GET['revoke'])) {
    $id = (int)$_GET['revoke'];
    $db->query("DELETE FROM tokens WHERE id=$id");
    redirect('tokens.php');
}
if (isset($_GET['cleanup'])) {
    $db->query("DELETE FROM tokens WHERE expires_at < '" . date('Y-m-d H:i:s') . "'");
    redirect('tokens.php?msg=cleanup');
}

$msg = isset($_GET['msg']) ? 'Token expired dibersihkan.' : '';

$where  = ($role === 'superadmin') ? 'WHERE 1=1' : "WHERE u.admin_id = $adminId";
$tokens = $db->query("SELECT t.*, u.username, p.name as playlist_name
    FROM tokens t
    JOIN users u ON t.user_id=u.id
    JOIN playlists p ON t.playlist_id=p.id
    $where
    ORDER BY t.created_at DESC LIMIT 100")->fetchAll();
?>
<!DOCTYPE html>
<html lang="id">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Tokens - <?= PANEL_NAME ?></title>
<link rel="stylesheet" href="../assets/css/style.css">
</head>
<body>
<?php include 'partials/sidebar.php'; ?>
<div class="main-content">
<?php include 'partials/topbar.php'; ?>
<div class="page-content">
    <div class="page-header">
        <h2 class="page-title">🔑 Token Aktif</h2>
        <a href="?cleanup=1" class="btn btn-secondary" onclick="return confirm('Hapus semua token expired?')">🧹 Bersihkan Expired</a>
    </div>
    <?php if ($msg): ?><div class="alert alert-success"><?= $msg ?></div><?php endif; ?>

    <div class="card">
        <div class="card-body p0">
            <div class="table-wrapper">
            <table class="table">
                <thead>
                    <tr>
                        <th>User</th>
                        <th class="hide-mobile">Playlist</th>
                        <th>Token</th>
                        <th class="hide-mobile">IP</th>
                        <th class="hide-mobile">Player</th>
                        <th>Expired</th>
                        <th>Status</th>
                        <th>Aksi</th>
                    </tr>
                </thead>
                <tbody>
                <?php foreach ($tokens as $t):
                    $isExpired = strtotime($t['expires_at']) < time();
                    $player = 'Unknown';
                    $ua = $t['user_agent'] ?? '';
                    if (stripos($ua,'tivimate') !== false) $player = 'TiviMate';
                    elseif (stripos($ua,'ott') !== false) $player = 'OTT Nav';
                    elseif (stripos($ua,'vlc') !== false) $player = 'VLC';
                    elseif (stripos($ua,'mozilla') !== false) $player = 'Browser';
                ?>
                <tr class="<?= $isExpired ? 'row-expired' : '' ?>">
                    <td class="fw-600"><?= sanitize($t['username']) ?></td>
                    <td class="hide-mobile text-sm"><?= sanitize($t['playlist_name']) ?></td>
                    <td><code><?= substr($t['token'], 0, 12) ?>…</code></td>
                    <td class="hide-mobile text-sm text-muted"><?= sanitize($t['ip_address']) ?></td>
                    <td class="hide-mobile text-sm"><?= $player ?></td>
                    <td class="text-sm <?= $isExpired ? 'text-danger' : 'text-success' ?>"><?= date('d/m H:i', strtotime($t['expires_at'])) ?></td>
                    <td><span class="badge badge-<?= $isExpired ? 'danger' : 'success' ?>"><?= $isExpired ? 'Expired' : 'Aktif' ?></span></td>
                    <td><a href="?revoke=<?= $t['id'] ?>" class="btn btn-sm btn-danger">Cabut</a></td>
                </tr>
                <?php endforeach; ?>
                <?php if (empty($tokens)): ?>
                <tr><td colspan="8" class="text-center text-muted" style="padding:32px">Tidak ada token.</td></tr>
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
