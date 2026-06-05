CREATE TABLE IF NOT EXISTS `admins` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `username` TEXT NOT NULL UNIQUE,
  `password` TEXT NOT NULL,
  `email` TEXT,
  `role` TEXT CHECK( role IN ('superadmin','admin','reseller') ) DEFAULT 'admin',
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS `playlists` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `admin_id` INTEGER NOT NULL,
  `name` TEXT NOT NULL,
  `source_url` TEXT NOT NULL,
  `description` TEXT,
  `is_active` INTEGER DEFAULT 1,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `users` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `admin_id` INTEGER NOT NULL,
  `username` TEXT NOT NULL,
  `password` TEXT NOT NULL,
  `stream_key` TEXT NOT NULL DEFAULT '',
  `playlist_id` INTEGER NOT NULL,
  `max_devices` INTEGER DEFAULT 1,
  `expired_at` DATETIME NOT NULL,
  `is_active` INTEGER DEFAULT 1,
  `notes` TEXT,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE,
  FOREIGN KEY (`playlist_id`) REFERENCES `playlists` (`id`) ON DELETE CASCADE,
  UNIQUE (`admin_id`, `username`)
);

CREATE TABLE IF NOT EXISTS `tokens` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `user_id` INTEGER NOT NULL,
  `token` TEXT NOT NULL UNIQUE,
  `playlist_id` INTEGER NOT NULL,
  `device_fingerprint` TEXT,
  `ip_address` TEXT,
  `user_agent` TEXT,
  `expires_at` DATETIME NOT NULL,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `device_sessions` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `user_id` INTEGER NOT NULL,
  `device_fingerprint` TEXT NOT NULL,
  `ip_address` TEXT,
  `user_agent` TEXT,
  `last_seen` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `expires_at` DATETIME NOT NULL,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  UNIQUE (`user_id`, `device_fingerprint`)
);

CREATE TABLE IF NOT EXISTS `access_logs` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `user_id` INTEGER,
  `token` TEXT,
  `ip_address` TEXT,
  `user_agent` TEXT,
  `action` TEXT CHECK( action IN ('login','token_generate','stream_access','blocked','expired','device_limit') ) NOT NULL,
  `detail` TEXT,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX IF NOT EXISTS `idx_user_id` ON `access_logs` (`user_id`);
CREATE INDEX IF NOT EXISTS `idx_created_at` ON `access_logs` (`created_at`);
CREATE INDEX IF NOT EXISTS `idx_action` ON `access_logs` (`action`);

CREATE TABLE IF NOT EXISTS `blocked_ips` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `ip_address` TEXT NOT NULL UNIQUE,
  `reason` TEXT,
  `blocked_at` DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS `rate_limits` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `hash_key` TEXT NOT NULL UNIQUE,
  `requests` INTEGER DEFAULT 1,
  `reset_at` INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS `proxy_mappings` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `rid` TEXT NOT NULL UNIQUE,
  `user_id` INTEGER NOT NULL,
  `original_url` TEXT NOT NULL,
  `ip_prefix` TEXT NOT NULL,
  `ua_hash` TEXT NOT NULL,
  `device_fingerprint` TEXT NOT NULL,
  `expires_at` DATETIME NOT NULL,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
);
CREATE INDEX IF NOT EXISTS `idx_rid` ON `proxy_mappings` (`rid`);
CREATE INDEX IF NOT EXISTS `idx_expires_at` ON `proxy_mappings` (`expires_at`);
