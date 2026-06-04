CREATE TABLE IF NOT EXISTS `proxy_mappings` (
  `rid` varchar(64) NOT NULL,
  `original_url` text NOT NULL,
  `expires_at` datetime NOT NULL,
  PRIMARY KEY (`rid`),
  KEY `idx_expires_at` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `rate_limits` (
  `hash_key` varchar(64) NOT NULL,
  `requests` int(11) NOT NULL DEFAULT 1,
  `reset_at` datetime NOT NULL,
  PRIMARY KEY (`hash_key`),
  KEY `idx_reset_at` (`reset_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
