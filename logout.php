<?php
require_once 'includes/config.php';
session_destroy();
header('Location: ' . PANEL_URL . '/login.php');
exit;
