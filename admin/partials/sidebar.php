<div class="sidebar-overlay"></div>
<div class="sidebar">
    <div class="sidebar-logo">
        <span>⚡</span> <?= PANEL_NAME ?>
    </div>
    <nav class="sidebar-nav">
        <a href="dashboard.php" class="nav-item <?= basename($_SERVER['PHP_SELF']) === 'dashboard.php' ? 'active' : '' ?>">
            <span class="nav-icon">🏠</span> Dashboard
        </a>
        <div class="nav-label">Manajemen</div>
        <a href="playlists.php" class="nav-item <?= basename($_SERVER['PHP_SELF']) === 'playlists.php' ? 'active' : '' ?>">
            <span class="nav-icon">📺</span> Playlist M3U
        </a>
        <a href="users.php" class="nav-item <?= basename($_SERVER['PHP_SELF']) === 'users.php' ? 'active' : '' ?>">
            <span class="nav-icon">👥</span> Kelola User
        </a>
        <a href="tokens.php" class="nav-item <?= basename($_SERVER['PHP_SELF']) === 'tokens.php' ? 'active' : '' ?>">
            <span class="nav-icon">🔑</span> Token Aktif
        </a>
        <div class="nav-label">Monitoring</div>
        <a href="logs.php" class="nav-item <?= basename($_SERVER['PHP_SELF']) === 'logs.php' ? 'active' : '' ?>">
            <span class="nav-icon">📋</span> Live Log
        </a>
        <a href="blocked.php" class="nav-item <?= basename($_SERVER['PHP_SELF']) === 'blocked.php' ? 'active' : '' ?>">
            <span class="nav-icon">🚫</span> Blokir IP
        </a>
        <?php if ($_SESSION['admin_role'] === 'superadmin'): ?>
        <div class="nav-label">Sistem</div>
        <a href="admins.php" class="nav-item <?= basename($_SERVER['PHP_SELF']) === 'admins.php' ? 'active' : '' ?>">
            <span class="nav-icon">🛡️</span> Admin/Reseller
        </a>
        <?php endif; ?>
        <div class="nav-label">Akun</div>
        <a href="change-password.php" class="nav-item <?= basename($_SERVER['PHP_SELF']) === 'change-password.php' ? 'active' : '' ?>">
            <span class="nav-icon">🔒</span> Ganti Password
        </a>
        <a href="../logout.php" class="nav-item nav-logout">
            <span class="nav-icon">🚪</span> Logout
        </a>
    </nav>
</div>
