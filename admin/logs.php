<?php
require_once '../includes/config.php';
requireAdmin();

$db = getDB();
$filter = $_GET['filter'] ?? 'all';
$search = trim($_GET['search'] ?? '');

$where = "WHERE 1=1";
if ($filter !== 'all') $where .= " AND l.action = " . $db->quote($filter);
if ($search) $where .= " AND (u.username LIKE " . $db->quote("%$search%") . " OR l.ip_address LIKE " . $db->quote("%$search%") . ")";

$logs = $db->query("SELECT l.*, u.username FROM access_logs l LEFT JOIN users u ON l.user_id=u.id $where ORDER BY l.created_at DESC LIMIT 200")->fetchAll();
?>
<!DOCTYPE html>
<html lang="id">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Live Log - <?= PANEL_NAME ?></title>
<link rel="stylesheet" href="../assets/css/style.css">
</head>
<body>
<?php include 'partials/sidebar.php'; ?>
<div class="main-content">
<?php include 'partials/topbar.php'; ?>
<div class="page-content">
    <div class="page-header">
        <h2 class="page-title">📋 Live Monitoring Log</h2>
        <button class="btn btn-secondary" onclick="location.reload()">↺ Refresh</button>
    </div>

    <div class="card mb-1">
        <div class="card-body">
            <form method="GET" class="filter-form">
                <select name="filter" class="form-control form-control-sm" onchange="this.form.submit()">
                    <option value="all" <?= $filter==='all'?'selected':'' ?>>Semua Aksi</option>
                    <option value="stream_access"  <?= $filter==='stream_access'?'selected':'' ?>>Stream Access</option>
                    <option value="token_generate" <?= $filter==='token_generate'?'selected':'' ?>>Token Generate</option>
                    <option value="blocked"        <?= $filter==='blocked'?'selected':'' ?>>Blocked</option>
                    <option value="expired"        <?= $filter==='expired'?'selected':'' ?>>Expired</option>
                    <option value="device_limit"   <?= $filter==='device_limit'?'selected':'' ?>>Device Limit</option>
                    <option value="login"          <?= $filter==='login'?'selected':'' ?>>Login</option>
                </select>
                <input type="text" name="search" class="form-control form-control-sm" placeholder="Cari user / IP..." value="<?= sanitize($search) ?>">
                <button type="submit" class="btn btn-sm btn-primary">Cari</button>
                <a href="logs.php" class="btn btn-sm btn-secondary">Reset</a>
            </form>
        </div>
    </div>

    <div class="card">
        <div class="card-body p0">
            <div class="table-wrapper">
            <table class="table">
                <thead>
                    <tr>
                        <th>Waktu</th>
                        <th>User</th>
                        <th>Aksi</th>
                        <th>IP</th>
                        <th class="hide-mobile">Player</th>
                        <th class="hide-mobile">Detail</th>
                    </tr>
                </thead>
                <tbody id="log-table">
                <?php foreach ($logs as $log):
                    $badgeClass = match($log['action']) {
                        'stream_access' => 'success',
                        'blocked','device_limit','expired' => 'danger',
                        'token_generate' => 'info',
                        default => 'secondary'
                    };
                    $player = '';
                    $ua = $log['user_agent'] ?? '';
                    if (stripos($ua,'tivimate') !== false) $player = '📱 TiviMate';
                    elseif (stripos($ua,'ott') !== false) $player = '📺 OTT Navigator';
                    elseif (stripos($ua,'smarters') !== false) $player = '🎬 Smarters';
                    elseif (stripos($ua,'vlc') !== false) $player = '🟠 VLC';
                    elseif (stripos($ua,'mozilla') !== false) $player = '🌐 Browser';
                ?>
                <tr>
                    <td class="text-sm text-muted"><?= date('d/m H:i:s', strtotime($log['created_at'])) ?></td>
                    <td><?= sanitize($log['username'] ?? '-') ?></td>
                    <td><span class="badge badge-<?= $badgeClass ?>"><?= $log['action'] ?></span></td>
                    <td class="text-sm text-muted"><?= sanitize($log['ip_address']) ?></td>
                    <td class="hide-mobile text-sm"><?= $player ?: '<span class="text-dim">—</span>' ?></td>
                    <td class="hide-mobile text-sm text-muted"><?= sanitize(substr($log['detail'] ?? '', 0, 60)) ?></td>
                </tr>
                <?php endforeach; ?>
                <?php if (empty($logs)): ?>
                <tr><td colspan="6" class="text-center text-muted" style="padding:32px">Tidak ada log.</td></tr>
                <?php endif; ?>
                </tbody>
            </table>
            </div>
        </div>
    </div>
</div>
</div>
<script src="../assets/js/app.js"></script>
<script>
setTimeout(function() { location.reload(); }, 15000);
</script>
</body>
</html>
