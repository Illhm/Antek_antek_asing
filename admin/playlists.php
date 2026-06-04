<?php
require_once '../includes/config.php';
requireAdmin();

$db = getDB();
$adminId = $_SESSION['admin_id'];
$role    = $_SESSION['admin_role'];
$msg = $err = '';

if (($_POST['action'] ?? '') === 'create') {
    $name = trim($_POST['name'] ?? '');
    $url  = trim($_POST['source_url'] ?? '');
    $desc = trim($_POST['description'] ?? '');
    if ($name && $url) {
        $stmt = $db->prepare("INSERT INTO playlists (admin_id, name, source_url, description) VALUES (?,?,?,?)");
        $stmt->execute([$adminId, $name, $url, $desc]);
        $msg = "Playlist berhasil ditambahkan.";
    } else { $err = "Nama dan URL wajib diisi."; }
}

if (($_POST['action'] ?? '') === 'update') {
    $id   = (int)($_POST['playlist_id'] ?? 0);
    $name = trim($_POST['name'] ?? '');
    $url  = trim($_POST['source_url'] ?? '');
    $desc = trim($_POST['description'] ?? '');
    if ($id && $name && $url) {
        $db->prepare("UPDATE playlists SET name=?, source_url=?, description=? WHERE id=? AND (admin_id=? OR ?='superadmin')")
           ->execute([$name, $url, $desc, $id, $adminId, $role]);
        $msg = "Playlist berhasil diperbarui.";
    } else { $err = "Nama dan URL wajib diisi."; }
}

if (isset($_GET['delete'])) {
    $id = (int)$_GET['delete'];
    $db->prepare("DELETE FROM playlists WHERE id=? AND (admin_id=? OR ?='superadmin')")->execute([$id, $adminId, $role]);
    $msg = "Playlist dihapus.";
}

if (isset($_GET['toggle'])) {
    $id = (int)$_GET['toggle'];
    $db->prepare("UPDATE playlists SET is_active = NOT is_active WHERE id=? AND (admin_id=? OR ?='superadmin')")->execute([$id, $adminId, $role]);
    redirect('playlists.php');
}

$where = ($role === 'superadmin') ? 'WHERE 1=1' : "WHERE p.admin_id = $adminId";
$playlists = $db->query("SELECT p.*, a.username as admin_name, (SELECT COUNT(*) FROM users WHERE playlist_id=p.id) as user_count FROM playlists p JOIN admins a ON p.admin_id=a.id $where ORDER BY p.created_at DESC")->fetchAll();
?>
<!DOCTYPE html>
<html lang="id">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Playlist - <?= PANEL_NAME ?></title>
<link rel="stylesheet" href="../assets/css/style.css">
</head>
<body>
<?php include 'partials/sidebar.php'; ?>
<div class="main-content">
<?php include 'partials/topbar.php'; ?>
<div class="page-content">
    <div class="page-header">
        <h2 class="page-title">📺 Kelola Playlist M3U</h2>
        <button class="btn btn-primary" onclick="toggleModal('modal-add')">+ Tambah Playlist</button>
    </div>

    <?php if ($msg): ?><div class="alert alert-success"><?= sanitize($msg) ?></div><?php endif; ?>
    <?php if ($err): ?><div class="alert alert-danger"><?= sanitize($err) ?></div><?php endif; ?>

    <div class="card">
        <div class="card-body p0">
            <div class="table-wrapper">
            <table class="table">
                <thead>
                    <tr><th>#</th><th>Nama</th><th class="hide-mobile">Source URL</th><th>User</th><th>Status</th><th class="hide-mobile">Admin</th><th>Aksi</th></tr>
                </thead>
                <tbody>
                <?php foreach ($playlists as $i => $p): ?>
                <tr>
                    <td class="text-muted text-sm"><?= $i+1 ?></td>
                    <td class="fw-600"><?= sanitize($p['name']) ?></td>
                    <td class="hide-mobile text-sm text-muted"><?= sanitize(substr($p['source_url'], 0, 55)) ?>…</td>
                    <td><span class="badge badge-info"><?= $p['user_count'] ?></span></td>
                    <td>
                        <a href="?toggle=<?= $p['id'] ?>">
                            <span class="badge badge-<?= $p['is_active'] ? 'success' : 'danger' ?>">
                                <?= $p['is_active'] ? 'Aktif' : 'Off' ?>
                            </span>
                        </a>
                    </td>
                    <td class="hide-mobile text-sm text-muted"><?= sanitize($p['admin_name']) ?></td>
                    <td>
                        <div class="btn-group-table">
                            <button type="button" class="btn btn-sm btn-info" onclick="toggleModal('modal-detail-<?= $p['id'] ?>')">Detail</button>
                            <button type="button" class="btn btn-sm btn-primary" onclick="toggleModal('modal-edit-<?= $p['id'] ?>')">Edit</button>
                            <a href="?delete=<?= $p['id'] ?>" class="btn btn-sm btn-danger" onclick="return confirm('Hapus playlist ini?')">Hapus</a>
                        </div>
                    </td>
                </tr>
                <?php endforeach; ?>
                <?php if (empty($playlists)): ?>
                <tr><td colspan="7" class="text-center text-muted" style="padding:32px">Belum ada playlist. Tambahkan sekarang.</td></tr>
                <?php endif; ?>
                </tbody>
            </table>
            </div>
        </div>
    </div>
</div>
</div>

<?php foreach ($playlists as $p): ?>
<div class="modal-overlay" id="modal-detail-<?= $p['id'] ?>">
    <div class="modal">
        <div class="modal-header">
            <h3>Detail Playlist</h3>
            <button onclick="toggleModal('modal-detail-<?= $p['id'] ?>')" class="modal-close">✕</button>
        </div>
        <div class="modal-body">
            <table class="table table-compact">
                <tr><th style="width:120px">Nama</th><td><?= sanitize($p['name']) ?></td></tr>
                <tr><th>Source URL</th><td class="break-all text-xs"><code style="word-break:break-all;white-space:normal"><?= sanitize($p['source_url']) ?></code></td></tr>
                <tr><th>Deskripsi</th><td><?= sanitize($p['description'] ?: '—') ?></td></tr>
                <tr><th>Jumlah User</th><td><?= $p['user_count'] ?> user</td></tr>
                <tr><th>Status</th><td><?= $p['is_active'] ? '<span class="badge badge-success">Aktif</span>' : '<span class="badge badge-danger">Nonaktif</span>' ?></td></tr>
                <tr><th>Admin</th><td><?= sanitize($p['admin_name']) ?></td></tr>
                <tr><th>Dibuat</th><td><?= date('d/m/Y H:i', strtotime($p['created_at'])) ?></td></tr>
            </table>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary" onclick="toggleModal('modal-detail-<?= $p['id'] ?>')">Tutup</button>
        </div>
    </div>
</div>

<div class="modal-overlay" id="modal-edit-<?= $p['id'] ?>">
    <div class="modal">
        <div class="modal-header">
            <h3>Edit Playlist</h3>
            <button onclick="toggleModal('modal-edit-<?= $p['id'] ?>')" class="modal-close">✕</button>
        </div>
        <form method="POST">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="playlist_id" value="<?= $p['id'] ?>">
            <div class="form-group">
                <label>Nama Playlist *</label>
                <input type="text" name="name" class="form-control" value="<?= sanitize($p['name']) ?>" required>
            </div>
            <div class="form-group">
                <label>URL Source M3U *</label>
                <input type="url" name="source_url" class="form-control" value="<?= sanitize($p['source_url']) ?>" required>
                <small class="text-muted">URL ini tersembunyi dari user. Hanya proxy yang mengaksesnya.</small>
            </div>
            <div class="form-group">
                <label>Deskripsi</label>
                <textarea name="description" class="form-control" rows="2"><?= sanitize($p['description']) ?></textarea>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" onclick="toggleModal('modal-edit-<?= $p['id'] ?>')">Batal</button>
                <button type="submit" class="btn btn-primary">Simpan Perubahan</button>
            </div>
        </form>
    </div>
</div>
<?php endforeach; ?>

<div class="modal-overlay" id="modal-add">
    <div class="modal">
        <div class="modal-header">
            <h3>Tambah Playlist M3U</h3>
            <button onclick="toggleModal('modal-add')" class="modal-close">✕</button>
        </div>
        <form method="POST">
            <input type="hidden" name="action" value="create">
            <div class="form-group">
                <label>Nama Playlist *</label>
                <input type="text" name="name" class="form-control" placeholder="Contoh: Indo HD Pack" required>
            </div>
            <div class="form-group">
                <label>URL Source M3U *</label>
                <input type="url" name="source_url" class="form-control" placeholder="http://source.tv:8080/get.php?..." required>
                <small class="text-muted">URL ini tersembunyi dari user. Hanya proxy yang mengaksesnya.</small>
            </div>
            <div class="form-group">
                <label>Deskripsi</label>
                <textarea name="description" class="form-control" rows="2" placeholder="Opsional"></textarea>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" onclick="toggleModal('modal-add')">Batal</button>
                <button type="submit" class="btn btn-primary">Simpan Playlist</button>
            </div>
        </form>
    </div>
</div>

<script src="../assets/js/app.js"></script>
</body>
</html>
