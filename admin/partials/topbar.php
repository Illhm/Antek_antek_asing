<div class="topbar">
    <button class="sidebar-toggle" aria-label="Toggle sidebar">☰</button>
    <div class="topbar-title"><?= ucfirst(str_replace('.php','',basename($_SERVER['PHP_SELF']))) ?></div>
    <div class="topbar-right">
        <span class="topbar-user">
            👤 <?= sanitize($_SESSION['admin_user']) ?>
            <span class="badge badge-info"><?= $_SESSION['admin_role'] ?></span>
        </span>
        <span class="topbar-time" id="clock"></span>
    </div>
</div>
<script>
(function() {
    function updateClock() {
        const el = document.getElementById('clock');
        if (el) el.textContent = new Date().toLocaleTimeString('id-ID');
    }
    setInterval(updateClock, 1000);
    updateClock();
})();
</script>
