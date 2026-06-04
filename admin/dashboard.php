<?php
require_once '../includes/config.php';
requireAdmin();

$db = getDB();
$adminId = $_SESSION['admin_id'];
$role    = $_SESSION['admin_role'];

$whereAdmin  = ($role === 'superadmin') ? 'WHERE 1=1' : "WHERE admin_id = $adminId";
$whereAdminU = ($role === 'superadmin') ? "WHERE is_active=1 AND expired_at > '" . date('Y-m-d H:i:s') . "'" : "WHERE admin_id=$adminId AND is_active=1 AND expired_at > '" . date('Y-m-d H:i:s') . "'";

$totalUsers   = $db->query("SELECT COUNT(*) FROM users $whereAdmin")->fetchColumn();
$activeUsers  = $db->query("SELECT COUNT(*) FROM users $whereAdminU")->fetchColumn();
$totalLists   = $db->query("SELECT COUNT(*) FROM playlists " . ($whereAdmin ?: "WHERE 1=1"))->fetchColumn();
$todayLogs    = $db->query("SELECT COUNT(*) FROM access_logs WHERE date(created_at) = '" . date('Y-m-d') . "'")->fetchColumn();
$streamOnline = $db->query("SELECT COUNT(DISTINCT user_id) FROM tokens WHERE expires_at > '" . date('Y-m-d H:i:s') . "'")->fetchColumn();

$logs = $db->query("SELECT l.*, u.username FROM access_logs l LEFT JOIN users u ON l.user_id=u.id ORDER BY l.created_at DESC LIMIT 20")->fetchAll();
$expiring = $db->query("SELECT u.username, u.expired_at, p.name as playlist FROM users u JOIN playlists p ON u.playlist_id=p.id WHERE u.expired_at BETWEEN '" . date('Y-m-d H:i:s') . "' AND '" . date('Y-m-d H:i:s', strtotime('+3 days')) . "' ORDER BY u.expired_at ASC LIMIT 10")->fetchAll();
?>
<!DOCTYPE html>
<html lang="id">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dashboard - <?= PANEL_NAME ?></title>
<link rel="stylesheet" href="../assets/css/style.css">
</head>
<body>
<?php include 'partials/sidebar.php'; ?>
<div class="main-content">
<?php include 'partials/topbar.php'; ?>

<div class="page-content">
    <div class="page-header">
        <h2 class="page-title">🏠 Dashboard</h2>
    </div>

    <div class="stats-grid">
        <div class="stat-card blue">
            <div class="stat-icon">👥</div>
            <div class="stat-info">
                <div class="stat-number"><?= $totalUsers ?></div>
                <div class="stat-label">Total User</div>
            </div>
        </div>
        <div class="stat-card green">
            <div class="stat-icon">✅</div>
            <div class="stat-info">
                <div class="stat-number"><?= $activeUsers ?></div>
                <div class="stat-label">User Aktif</div>
            </div>
        </div>
        <div class="stat-card purple">
            <div class="stat-icon">📺</div>
            <div class="stat-info">
                <div class="stat-number"><?= $totalLists ?></div>
                <div class="stat-label">Playlist</div>
            </div>
        </div>
        <div class="stat-card orange">
            <div class="stat-icon">🔴</div>
            <div class="stat-info">
                <div class="stat-number"><?= $streamOnline ?></div>
                <div class="stat-label">Streaming Aktif</div>
            </div>
        </div>
        <div class="stat-card gray">
            <div class="stat-icon">📋</div>
            <div class="stat-info">
                <div class="stat-number"><?= $todayLogs ?></div>
                <div class="stat-label">Log Hari Ini</div>
            </div>
        </div>
    </div>

    <div class="row-2col">
        <div class="card">
            <div class="card-header">📋 Aktivitas Terbaru</div>
            <div class="card-body p0">
                <div class="table-wrapper">
                <table class="table table-compact">
                    <thead><tr><th>User</th><th>Aksi</th><th class="hide-mobile">IP</th><th>Waktu</th></tr></thead>
                    <tbody>
                    <?php foreach ($logs as $log): ?>
                    <tr>
                        <td><?= sanitize($log['username'] ?? 'guest') ?></td>
                        <td><span class="badge badge-<?= $log['action'] === 'blocked' ? 'danger' : ($log['action'] === 'stream_access' ? 'success' : 'info') ?>"><?= $log['action'] ?></span></td>
                        <td class="hide-mobile text-sm text-muted"><?= sanitize($log['ip_address']) ?></td>
                        <td class="text-sm text-muted"><?= date('d/m H:i', strtotime($log['created_at'])) ?></td>
                    </tr>
                    <?php endforeach; ?>
                    <?php if (empty($logs)): ?><tr><td colspan="4" class="text-center text-muted" style="padding:24px">Belum ada log</td></tr><?php endif; ?>
                    </tbody>
                </table>
                </div>
            </div>
        </div>

        <div class="card">
            <div class="card-header">⚠️ Segera Expired (3 Hari)</div>
            <div class="card-body p0">
                <div class="table-wrapper">
                <table class="table table-compact">
                    <thead><tr><th>User</th><th class="hide-mobile">Playlist</th><th>Expired</th></tr></thead>
                    <tbody>
                    <?php foreach ($expiring as $u): ?>
                    <tr>
                        <td><?= sanitize($u['username']) ?></td>
                        <td class="hide-mobile text-sm"><?= sanitize($u['playlist']) ?></td>
                        <td class="text-danger text-sm"><?= date('d/m/Y', strtotime($u['expired_at'])) ?></td>
                    </tr>
                    <?php endforeach; ?>
                    <?php if (empty($expiring)): ?><tr><td colspan="3" class="text-center text-muted" style="padding:24px">Tidak ada</td></tr><?php endif; ?>
                    </tbody>
                </table>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
<script src="../assets/js/app.js"></script>
</body>
</html>
