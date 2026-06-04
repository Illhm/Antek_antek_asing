<?php
require_once 'includes/config.php';
if (isAdminLoggedIn()) {
    redirect(PANEL_URL . '/admin/dashboard.php');
} else {
    redirect(PANEL_URL . '/login.php');
}
