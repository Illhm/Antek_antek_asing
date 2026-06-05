<?php
require_once '../includes/config.php';
requireAdmin();

$db = getDB();
$adminId = $_SESSION['admin_id'];
$role    = $_SESSION['admin_role'];
$msg = $err = '';

// GET playlists for dropdown
if ($role === 'superadmin') {
    $myPlaylists = $db->query("SELECT id, name FROM playlists WHERE is_active=1")->fetchAll();
} else {
    $stmt2 = $db->prepare("SELECT id, name FROM playlists WHERE admin_id=? AND is_active=1");
    $stmt2->execute([$adminId]);
    $myPlaylists = $stmt2->fetchAll();
}

// CREATE USER
if (($_POST['action'] ?? '') === 'create') {
    if (!isset($_POST['csrf_token']) || !hash_equals($_SESSION['csrf_token'], $_POST['csrf_token'])) die('CSRF token validation failed');
    $uname    = trim($_POST['username'] ?? '');
    $pass     = $_POST['password'] ?? '';
    $plId     = (int)($_POST['playlist_id'] ?? 0);
    $maxDev   = (int)($_POST['max_devices'] ?? 1);
    $notes    = trim($_POST['notes'] ?? '');

    $expDuration = $_POST['exp_duration'] ?? '30';
    if ($expDuration === 'custom') {
        $expDays = (float)($_POST['exp_days_custom'] ?? 30);
    } else {
        $expDays = (float)$expDuration;
    }
    if ($expDays <= 0) $expDays = 1;

    if ($uname && $pass && $plId) {
        $expSeconds = (int)($expDays * 86400);
        $expDate = date('Y-m-d H:i:s', time() + $expSeconds);
        $hashed  = password_hash($pass, PASSWORD_DEFAULT);
        try {
            $streamKeyPlain = bin2hex(random_bytes(16));
            $streamKeyHash = password_hash($streamKeyPlain, PASSWORD_DEFAULT);
            $stmt = $db->prepare("INSERT INTO users (admin_id, username, password, stream_key, playlist_id, max_devices, expired_at, notes) VALUES (?,?,?,?,?,?,?,?)");
            $stmt->execute([$adminId, $uname, $hashed, $streamKeyHash, $plId, $maxDev, $expDate, $notes]);
            $durationLabel = formatDuration($expDays);
            $streamUrl = PANEL_URL . '/proxy/stream.php?user=' . urlencode($uname) . '&key=' . $streamKeyPlain;
            $msg = "User <b>$uname</b> berhasil dibuat. Durasi: $durationLabel | Expired: " . date('d/m/Y H:i', strtotime($expDate)) . "<br><b>URL: (Simpan ini! Tidak bisa dilihat lagi)</b> <code>$streamUrl</code>";
        } catch (PDOException $e) {
            $err = "Username sudah ada.";
        }
    } else { $err = "Username, password, dan playlist wajib diisi."; }
}

// RESET SESSION
if (($_POST['action'] ?? '') === 'reset_session') {
    if (!isset($_POST['csrf_token']) || !hash_equals($_SESSION['csrf_token'], $_POST['csrf_token'])) {
        die('CSRF token validation failed');
    }
    $id = (int)($_POST['user_id'] ?? 0);
    $db->prepare("DELETE FROM device_sessions WHERE user_id=?")->execute([$id]);
    $db->prepare("DELETE FROM tokens WHERE user_id=?")->execute([$id]);
    $msg = "Sesi perangkat dan token aktif berhasil direset.";
}

// ROTATE KEY
if (($_POST['action'] ?? '') === 'rotate_key') {
    if (!isset($_POST['csrf_token']) || !hash_equals($_SESSION['csrf_token'], $_POST['csrf_token'])) {
        die('CSRF token validation failed');
    }
    $id = (int)($_POST['user_id'] ?? 0);
    $uname = trim($_POST['username'] ?? 'User');
    $streamKeyPlain = bin2hex(random_bytes(16));
    $streamKeyHash = password_hash($streamKeyPlain, PASSWORD_DEFAULT);
    $db->prepare("UPDATE users SET stream_key=? WHERE id=? AND " . ($role === 'superadmin' ? "1=1" : "admin_id=$adminId"))->execute([$streamKeyHash, $id]);
    $streamUrl = PANEL_URL . '/proxy/stream.php?user=' . urlencode($uname) . '&key=' . $streamKeyPlain;
    $msg = "Key berhasil dirotasi. <b>URL BARU (Simpan!):</b> <code>$streamUrl</code>";
}


// EXTEND USER
if (($_POST['action'] ?? '') === 'extend') {
    if (!isset($_POST['csrf_token']) || !hash_equals($_SESSION['csrf_token'], $_POST['csrf_token'])) die('CSRF token validation failed');
    $id = (int)$_POST['id'];
    $days = (int)($_POST['days'] ?? 30);
    $stmt = $db->prepare("SELECT expired_at FROM users WHERE id=? AND " . ($role === 'superadmin' ? "1=1" : "admin_id=$adminId"));
    $stmt->execute([$id]);
    $u = $stmt->fetch();
    if ($u) {
        $currentExp = strtotime($u['expired_at']);
        if ($currentExp < time()) $currentExp = time();
        $newExp = date('Y-m-d H:i:s', $currentExp + ($days * 86400));
        $db->prepare("UPDATE users SET expired_at=? WHERE id=?")->execute([$newExp, $id]);
        $msg = "Masa aktif berhasil ditambah $days hari.";
    }
}

// UPDATE USER
if (($_POST['action'] ?? '') === 'update') {
    if (!isset($_POST['csrf_token']) || !hash_equals($_SESSION['csrf_token'], $_POST['csrf_token'])) die('CSRF token validation failed');
    $id     = (int)($_POST['user_id'] ?? 0);
    $uname  = trim($_POST['username'] ?? '');
    $pass   = $_POST['password'] ?? '';
    $plId   = (int)($_POST['playlist_id'] ?? 0);
    $maxDev = (int)($_POST['max_devices'] ?? 1);
    $notes  = trim($_POST['notes'] ?? '');
    $expRaw = trim($_POST['expired_at'] ?? '');

    if ($id && $uname && $plId) {
        $sets   = ['username=?', 'playlist_id=?', 'max_devices=?', 'notes=?'];
        $params = [$uname, $plId, $maxDev, $notes];
        if ($pass !== '') {
            $sets[]   = 'password=?';
            $params[] = password_hash($pass, PASSWORD_DEFAULT);
        }
        if ($expRaw !== '') {
            $sets[]   = 'expired_at=?';
            $params[] = date('Y-m-d H:i:s', strtotime($expRaw));
        }
        $params[] = $id;
        $params[] = $adminId;
        try {
            $sql = "UPDATE users SET " . implode(', ', $sets) . " WHERE id=? AND admin_id=?";
            $db->prepare($sql)->execute($params);
            $msg = "User <b>" . sanitize($uname) . "</b> berhasil diperbarui.";
        } catch (PDOException $e) {
            $err = "Gagal memperbarui. Username mungkin sudah dipakai.";
        }
    } else { $err = "Username dan playlist wajib diisi."; }
}

// DELETE
if (($_POST['action'] ?? '') === 'delete') {
    if (!isset($_POST['csrf_token']) || !hash_equals($_SESSION['csrf_token'], $_POST['csrf_token'])) die('CSRF token validation failed');
    $id = (int)$_POST['id'];
    $db->prepare("DELETE FROM users WHERE id=? AND admin_id=?")->execute([$id, $adminId]);
    $msg = "User dihapus.";
}

// TOGGLE
if (isset($_GET['toggle'])) {
    $id = (int)$_GET['toggle'];
    $db->prepare("UPDATE users SET is_active = NOT is_active WHERE id=? AND admin_id=?")->execute([$id, $adminId]);
    redirect('../admin/users.php');
}

// EXTEND
if (isset($_GET['extend']) && isset($_GET['days'])) {
    $id   = (int)$_GET['extend'];
    $days = (int)$_GET['days'];
    $userRow = $db->query("SELECT expired_at FROM users WHERE id=$id AND admin_id=$adminId")->fetch();
    if ($userRow) {
        $currentExp = strtotime($userRow['expired_at']);
        $now = time();
        $base = ($currentExp > $now) ? $currentExp : $now;
        $newExp = date('Y-m-d H:i:s', strtotime("+$days days", $base));
        $db->prepare("UPDATE users SET expired_at = ? WHERE id=? AND admin_id=?")->execute([$newExp, $id, $adminId]);
    }
    $msg = "Masa aktif diperpanjang $days hari.";
}

function formatDuration(float $days): string {
    $seconds = $days * 86400;
    if ($seconds < 3600) return round($seconds / 60) . ' Menit';
    if ($seconds < 86400) return round($seconds / 3600, 1) . ' Jam';
    return round($days) . ' Hari';
}

$whereUsers = ($role === 'superadmin') ? 'WHERE 1=1' : "WHERE u.admin_id = $adminId";
$users = $db->query("SELECT u.*, p.name as playlist_name, a.username as admin_name,
    (SELECT COUNT(DISTINCT device_fingerprint) FROM device_sessions WHERE user_id=u.id) as active_devices
    FROM users u JOIN playlists p ON u.playlist_id=p.id JOIN admins a ON u.admin_id=a.id
    $whereUsers ORDER BY u.created_at DESC")->fetchAll();
?>
<!DOCTYPE html>
<html lang="id">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Users - <?= PANEL_NAME ?></title>
<link rel="stylesheet" href="../assets/css/style.css">
</head>
<body>
<?php include 'partials/sidebar.php'; ?>
<div class="main-content">
<?php include 'partials/topbar.php'; ?>
<div class="page-content">
    <div class="page-header">
        <h2 class="page-title">👥 Kelola User</h2>
        <button class="btn btn-primary" onclick="toggleModal('modal-add')">+ Tambah User</button>
    </div>

    <?php if ($msg): ?><div class="alert alert-success"><?= $msg ?></div><?php endif; ?>
    <?php if ($err): ?><div class="alert alert-danger"><?= sanitize($err) ?></div><?php endif; ?>

    <div class="card">
        <div class="card-body p0">
            <div class="table-wrapper">
            <table class="table">
                <thead>
                    <tr>
                        <th>Username</th>
                        <th>Playlist</th>
                        <th>Device</th>
                        <th>Expired</th>
                        <th>Status</th>
                        <th class="hide-mobile">Token URL</th>
                        <th>Aksi</th>
                    </tr>
                </thead>
                <tbody>
                <?php foreach ($users as $u):
                    $expired = strtotime($u['expired_at']) < time();
                    $tokenUrl = PANEL_URL . '/proxy/stream.php?user=' . urlencode($u['username']) . '&key=[HIDDEN]';
                ?>
                <tr class="<?= $expired ? 'row-expired' : '' ?>">
                    <td>
                        <span class="fw-600"><?= sanitize($u['username']) ?></span>
                        <?php if ($u['notes']): ?>
                        <br><small class="text-muted"><?= sanitize($u['notes']) ?></small>
                        <?php endif; ?>
                    </td>
                    <td><?= sanitize($u['playlist_name']) ?></td>
                    <td>
                        <span class="badge badge-<?= $u['active_devices'] >= $u['max_devices'] ? 'danger' : 'success' ?>">
                            <?= $u['active_devices'] ?>/<?= $u['max_devices'] ?>
                        </span>
                    </td>
                    <td class="<?= $expired ? 'text-danger' : '' ?> text-sm">
                        <?= date('d/m/Y', strtotime($u['expired_at'])) ?>
                        <br><span class="text-xs text-muted"><?= date('H:i', strtotime($u['expired_at'])) ?></span>
                    </td>
                    <td>
                        <a href="?toggle=<?= $u['id'] ?>">
                            <span class="badge badge-<?= $u['is_active'] && !$expired ? 'success' : 'danger' ?>">
                                <?= $u['is_active'] && !$expired ? 'Aktif' : ($expired ? 'Expired' : 'Nonaktif') ?>
                            </span>
                        </a>
                    </td>
                    <td class="hide-mobile">
                        <div class="token-url-wrap">
                            <input type="text" class="form-control form-control-sm" value="<?= $tokenUrl ?>" readonly onclick="this.select()">
                            <button class="btn btn-sm btn-secondary" onclick="copyText('<?= $tokenUrl ?>')" title="Copy">📋</button>
                        </div>
                    </td>
                    <td>
                        <div class="btn-group-table">
                            <button type="button" class="btn btn-sm btn-info" onclick="toggleModal('modal-detail-<?= $u['id'] ?>')">Detail</button>
                            <button type="button" class="btn btn-sm btn-primary" onclick="toggleModal('modal-edit-<?= $u['id'] ?>')">Edit</button>
                            <form method="POST" style="display:inline;">
                                <input type="hidden" name="csrf_token" value="<?= sanitize($_SESSION['csrf_token']) ?>">
                                <input type="hidden" name="action" value="extend">
                                <input type="hidden" name="id" value="<?= $u['id'] ?>">
                                <input type="hidden" name="days" value="30">
                                <button type="submit" class="btn btn-sm btn-success" title="+30 hari">+30h</button>
                            </form>
                            <form method="POST" style="display:inline;">
                                <input type="hidden" name="csrf_token" value="<?= sanitize($_SESSION['csrf_token']) ?>">
                                <input type="hidden" name="action" value="reset_session">
                                <input type="hidden" name="user_id" value="<?= $u['id'] ?>">
                                <button type="submit" class="btn btn-sm btn-info" onclick="return confirm('Reset sesi aktif user ini?')">Rst Sesi</button>
                            </form>
                            <form method="POST" style="display:inline;">
                                <input type="hidden" name="csrf_token" value="<?= sanitize($_SESSION['csrf_token']) ?>">
                                <input type="hidden" name="action" value="rotate_key">
                                <input type="hidden" name="user_id" value="<?= $u['id'] ?>">
                                <input type="hidden" name="username" value="<?= sanitize($u['username']) ?>">
                                <button type="submit" class="btn btn-sm btn-warning" onclick="return confirm('Generate key baru? URL lama akan mati.')">Rot Key</button>
                            </form>
                            <form method="POST" style="display:inline;">
                                <input type="hidden" name="csrf_token" value="<?= sanitize($_SESSION['csrf_token']) ?>">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="<?= $u['id'] ?>">
                                <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Hapus user <?= sanitize($u['username']) ?>?')">Del</button>
                            </form>
                        </div>
                    </td>
                </tr>
                <?php endforeach; ?>
                <?php if (empty($users)): ?>
                <tr><td colspan="7" class="text-center text-muted" style="padding:32px">Belum ada user. Klik "+ Tambah User" untuk memulai.</td></tr>
                <?php endif; ?>
                </tbody>
            </table>
            </div>
        </div>
    </div>
</div>
</div>

<!-- Modal Detail & Edit per User -->
<?php foreach ($users as $u):
    $uExpired = strtotime($u['expired_at']) < time();
    $uTokenUrl = PANEL_URL . '/proxy/stream.php?user=' . urlencode($u['username']);
?>
<div class="modal-overlay" id="modal-detail-<?= $u['id'] ?>">
    <div class="modal">
        <div class="modal-header">
            <h3>Detail User: <?= sanitize($u['username']) ?></h3>
            <button onclick="toggleModal('modal-detail-<?= $u['id'] ?>')" class="modal-close">✕</button>
        </div>
        <div class="modal-body">
            <table class="table table-compact">
                <tr><th style="width:130px">Username</th><td><?= sanitize($u['username']) ?></td></tr>
                <tr><th>Catatan</th><td><?= sanitize($u['notes'] ?: '-') ?></td></tr>
                <tr><th>Playlist</th><td><?= sanitize($u['playlist_name']) ?></td></tr>
                <tr><th>Perangkat</th><td><?= $u['active_devices'] ?> / <?= $u['max_devices'] ?></td></tr>
                <tr><th>Masa Aktif</th><td class="<?= $uExpired ? 'text-danger' : '' ?>"><?= date('d/m/Y H:i', strtotime($u['expired_at'])) ?><?= $uExpired ? ' <span class="badge badge-danger">Expired</span>' : '' ?></td></tr>
                <tr><th>Status</th><td><?= $u['is_active'] && !$uExpired ? '<span class="badge badge-success">Aktif</span>' : ($uExpired ? '<span class="badge badge-danger">Expired</span>' : '<span class="badge badge-secondary">Nonaktif</span>') ?></td></tr>
                <tr><th>Admin</th><td><?= sanitize($u['admin_name']) ?></td></tr>
                <tr><th>Dibuat</th><td><?= date('d/m/Y H:i', strtotime($u['created_at'])) ?></td></tr>
                <tr><th>Token URL</th>
                    <td class="break-all text-xs">
                        <code style="word-break:break-all;white-space:normal"><?= sanitize($uTokenUrl) ?></code>
                    </td>
                </tr>
            </table>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary" onclick="toggleModal('modal-detail-<?= $u['id'] ?>')">Tutup</button>
            <button type="button" class="btn btn-primary" onclick="copyText('<?= $uTokenUrl ?>')">📋 Salin Token URL</button>
        </div>
    </div>
</div>

<div class="modal-overlay" id="modal-edit-<?= $u['id'] ?>">
    <div class="modal">
        <div class="modal-header">
            <h3>Edit User: <?= sanitize($u['username']) ?></h3>
            <button onclick="toggleModal('modal-edit-<?= $u['id'] ?>')" class="modal-close">✕</button>
        </div>
        <form method="POST">
        <input type="hidden" name="csrf_token" value="<?= sanitize($_SESSION['csrf_token']) ?>">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="user_id" value="<?= $u['id'] ?>">
            <div class="form-group">
                <label>Username *</label>
                <input type="text" name="username" class="form-control" value="<?= sanitize($u['username']) ?>" required>
            </div>
            <div class="form-group">
                <label>Password Baru</label>
                <input type="text" name="password" class="form-control" placeholder="Kosongkan jika tidak diubah">
            </div>
            <div class="form-group">
                <label>Playlist *</label>
                <select name="playlist_id" class="form-control" required>
                    <option value="">-- Pilih Playlist --</option>
                    <?php foreach ($myPlaylists as $pl): ?>
                    <option value="<?= $pl['id'] ?>" <?= $pl['id'] == $u['playlist_id'] ? 'selected' : '' ?>><?= sanitize($pl['name']) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>Max Perangkat</label>
                    <input type="number" name="max_devices" class="form-control" value="<?= (int)$u['max_devices'] ?>" min="1">
                </div>
                <div class="form-group">
                    <label>Masa Aktif (Expired)</label>
                    <input type="datetime-local" name="expired_at" class="form-control" value="<?= date('Y-m-d\TH:i', strtotime($u['expired_at'])) ?>">
                </div>
            </div>
            <div class="form-group">
                <label>Catatan</label>
                <input type="text" name="notes" class="form-control" value="<?= sanitize($u['notes']) ?>" placeholder="No HP pelanggan, dll (opsional)">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" onclick="toggleModal('modal-edit-<?= $u['id'] ?>')">Batal</button>
                <button type="submit" class="btn btn-primary">Simpan Perubahan</button>
            </div>
        </form>
    </div>
</div>
<?php endforeach; ?>

<!-- Modal Add User -->
<div class="modal-overlay" id="modal-add">
    <div class="modal">
        <div class="modal-header">
            <h3>Tambah User Baru</h3>
            <button onclick="toggleModal('modal-add')" class="modal-close">✕</button>
        </div>
        <form method="POST">
        <input type="hidden" name="csrf_token" value="<?= sanitize($_SESSION['csrf_token']) ?>">
            <input type="hidden" name="action" value="create">
            <div class="form-group">
                <label>Username *</label>
                <input type="text" name="username" class="form-control" required autocomplete="off">
            </div>
            <div class="form-group">
                <label>Password *</label>
                <input type="text" name="password" class="form-control" required autocomplete="off">
            </div>
            <div class="form-group">
                <label>Playlist *</label>
                <select name="playlist_id" class="form-control" required>
                    <option value="">-- Pilih Playlist --</option>
                    <?php foreach ($myPlaylists as $pl): ?>
                    <option value="<?= $pl['id'] ?>"><?= sanitize($pl['name']) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>Max Perangkat</label>
                    <input type="number" name="max_devices" class="form-control" value="1" min="1">
                </div>
                <div class="form-group">
                    <label>Durasi Akses</label>
                    <select name="exp_duration" id="exp_duration" class="form-control" onchange="toggleCustomDuration(this.value)">
                        <optgroup label="⏱ Menit">
                            <option value="0.003472">5 Menit</option>
                            <option value="0.020833">30 Menit</option>
                        </optgroup>
                        <optgroup label="🕐 Jam">
                            <option value="0.041667">1 Jam</option>
                            <option value="0.125">3 Jam</option>
                            <option value="0.25">6 Jam</option>
                            <option value="0.5">12 Jam</option>
                        </optgroup>
                        <optgroup label="📅 Hari">
                            <option value="1">1 Hari</option>
                            <option value="3">3 Hari</option>
                            <option value="7">7 Hari</option>
                            <option value="14">14 Hari</option>
                            <option value="30" selected>30 Hari</option>
                            <option value="60">60 Hari</option>
                            <option value="90">90 Hari</option>
                            <option value="180">6 Bulan</option>
                            <option value="365">1 Tahun</option>
                        </optgroup>
                        <optgroup label="⚙ Lainnya">
                            <option value="custom">Custom...</option>
                        </optgroup>
                    </select>
                </div>
            </div>
            <div class="form-group" id="custom-duration-wrap" style="display:none">
                <label>Custom Durasi (hari, boleh desimal)</label>
                <input type="number" name="exp_days_custom" id="exp_days_custom" class="form-control" placeholder="cth: 0.5 = 12jam | 2 = 2hari" step="0.001" min="0.001">
                <small class="text-muted">0.003472 = 5 menit &nbsp;|&nbsp; 0.041667 = 1 jam &nbsp;|&nbsp; 1 = 1 hari</small>
            </div>
            <div class="form-group">
                <label>Catatan</label>
                <input type="text" name="notes" class="form-control" placeholder="No HP pelanggan, dll (opsional)">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" onclick="toggleModal('modal-add')">Batal</button>
                <button type="submit" class="btn btn-primary">Buat User</button>
            </div>
        </form>
    </div>
</div>

<script src="../assets/js/app.js"></script>
<script>
function toggleCustomDuration(val) {
    var wrap  = document.getElementById('custom-duration-wrap');
    var input = document.getElementById('exp_days_custom');
    if (val === 'custom') {
        wrap.style.display = 'block';
        input.required = true;
    } else {
        wrap.style.display = 'none';
        input.required = false;
    }
}
</script>
</body>
</html>
