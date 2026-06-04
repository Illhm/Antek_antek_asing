ALTER TABLE `proxy_mappings`
ADD COLUMN `user_id` int(11) NOT NULL AFTER `rid`,
ADD COLUMN `ip_prefix` varchar(45) NOT NULL AFTER `original_url`,
ADD COLUMN `ua_hash` varchar(64) NOT NULL AFTER `ip_prefix`,
ADD COLUMN `device_fingerprint` varchar(255) NOT NULL AFTER `ua_hash`;
