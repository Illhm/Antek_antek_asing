-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 04, 2026 at 10:04 PM
-- Server version: 11.4.12-MariaDB
-- PHP Version: 8.4.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tipimemy_iptv_panel`
--

-- --------------------------------------------------------

--
-- Table structure for table `access_logs`
--

CREATE TABLE `access_logs` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `token` varchar(128) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `action` enum('login','token_generate','stream_access','blocked','expired','device_limit') NOT NULL,
  `detail` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `access_logs`
--

INSERT INTO `access_logs` (`id`, `user_id`, `token`, `ip_address`, `user_agent`, `action`, `detail`, `created_at`) VALUES
(1, NULL, NULL, '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'login', 'Gagal login: Tipistream', '2026-05-31 16:11:20'),
(2, NULL, NULL, '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'login', 'Gagal login: admin', '2026-05-31 16:11:24'),
(3, NULL, NULL, '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'login', 'Gagal login: Tipistream', '2026-05-31 16:11:33'),
(4, 1, NULL, '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'login', 'Login berhasil', '2026-05-31 16:12:14'),
(5, 1, NULL, '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'login', 'Login berhasil', '2026-05-31 16:16:46'),
(6, NULL, NULL, '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'login', 'Gagal login: admin', '2026-05-31 16:17:43'),
(7, 1, NULL, '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'login', 'Login berhasil', '2026-05-31 16:17:50'),
(8, 1, 'cbc0a996d5b3641cddfc00a25fc5d5662f86119a96bfc3237bd43dd8cf3957c8', '149.154.161.215', 'TelegramBot (like TwitterBot)', 'token_generate', 'New token for trial', '2026-05-31 16:25:44'),
(9, 1, 'cbc0a996d5b3641cddfc00a25fc5d5662f86119a96bfc3237bd43dd8cf3957c8', '149.154.161.215', 'TelegramBot (like TwitterBot)', 'stream_access', 'Format: m3u | IP: 149.154.161.215', '2026-05-31 16:25:44'),
(10, 1, NULL, '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'device_limit', 'Device limit exceeded: trial (2402:a7c0:3003:104:1c00:5fff:fe00:f5)', '2026-05-31 16:26:17'),
(11, 1, NULL, '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'device_limit', 'Device limit exceeded: trial (2402:a7c0:3003:104:1c00:5fff:fe00:f5)', '2026-05-31 16:26:23'),
(12, NULL, NULL, '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'blocked', 'User tidak ditemukan: trial', '2026-05-31 16:27:11'),
(13, 2, '9cb95f6f4b7caa945967f68c2ac9c956e66c77871dcc7299470ddac5c5e3df3a', '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'token_generate', 'New token for trial', '2026-05-31 16:27:23'),
(14, 2, '9cb95f6f4b7caa945967f68c2ac9c956e66c77871dcc7299470ddac5c5e3df3a', '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 2402:a7c0:3003:104:1c00:5fff:fe00:f5', '2026-05-31 16:27:23'),
(15, 2, 'a7017b3702d587f9ef66f3d130f59ef5e57c5a3eacde534928807e32e23ad4d4', '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'token_generate', 'New token for trial', '2026-05-31 16:27:42'),
(16, 2, 'a7017b3702d587f9ef66f3d130f59ef5e57c5a3eacde534928807e32e23ad4d4', '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'stream_access', 'Format: m3u | IP: 2402:a7c0:3003:104:1c00:5fff:fe00:f5', '2026-05-31 16:27:42'),
(17, 4, '147a8381d6d5cee8fcca65d69b7cc3f72c2451e893c8a358d1ca5f448740bc77', '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'token_generate', 'New token for trial1', '2026-05-31 16:51:48'),
(18, 4, '147a8381d6d5cee8fcca65d69b7cc3f72c2451e893c8a358d1ca5f448740bc77', '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 2402:a7c0:3003:104:1c00:5fff:fe00:f5', '2026-05-31 16:51:48'),
(19, 4, '333eddcf9cd6d33e99652aec4b8fe96942b162169add3b9feda34d639eff6093', '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'token_generate', 'New token for trial1', '2026-05-31 16:53:07'),
(20, 4, '333eddcf9cd6d33e99652aec4b8fe96942b162169add3b9feda34d639eff6093', '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 2402:a7c0:3003:104:1c00:5fff:fe00:f5', '2026-05-31 16:53:07'),
(21, 4, '333eddcf9cd6d33e99652aec4b8fe96942b162169add3b9feda34d639eff6093', '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 2402:a7c0:3003:104:1c00:5fff:fe00:f5', '2026-05-31 16:53:18'),
(22, 4, '333eddcf9cd6d33e99652aec4b8fe96942b162169add3b9feda34d639eff6093', '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 2402:a7c0:3003:104:1c00:5fff:fe00:f5', '2026-05-31 16:53:22'),
(23, 3, NULL, '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'expired', 'User expired: trial', '2026-05-31 16:53:35'),
(24, 3, NULL, '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'expired', 'User expired: trial', '2026-05-31 16:53:38'),
(25, 3, NULL, '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'expired', 'User expired: trial', '2026-05-31 16:55:49'),
(26, 5, '42136f39edb728dce828e747831c677f18fd26eb42c7bc24325523b66a621e25', '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'token_generate', 'New token for trial', '2026-05-31 17:01:59'),
(27, 5, '42136f39edb728dce828e747831c677f18fd26eb42c7bc24325523b66a621e25', '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 2402:a7c0:3003:104:1c00:5fff:fe00:f5', '2026-05-31 17:01:59'),
(28, 5, '42136f39edb728dce828e747831c677f18fd26eb42c7bc24325523b66a621e25', '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 2402:a7c0:3003:104:1c00:5fff:fe00:f5', '2026-05-31 17:02:07'),
(29, 5, '42136f39edb728dce828e747831c677f18fd26eb42c7bc24325523b66a621e25', '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 2402:a7c0:3003:104:1c00:5fff:fe00:f5', '2026-05-31 17:03:39'),
(30, 6, '0039315f35ff090827f1ba563e6037901277644d0861b259b5fbdfc3b69b5594', '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'token_generate', 'New token for trial2', '2026-05-31 17:07:22'),
(31, 6, '0039315f35ff090827f1ba563e6037901277644d0861b259b5fbdfc3b69b5594', '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 2402:a7c0:3003:104:1c00:5fff:fe00:f5', '2026-05-31 17:07:22'),
(32, 6, '0039315f35ff090827f1ba563e6037901277644d0861b259b5fbdfc3b69b5594', '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 2402:a7c0:3003:104:1c00:5fff:fe00:f5', '2026-05-31 17:10:50'),
(33, 6, '0039315f35ff090827f1ba563e6037901277644d0861b259b5fbdfc3b69b5594', '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 2402:a7c0:3003:104:1c00:5fff:fe00:f5', '2026-05-31 17:23:31'),
(34, 6, '0039315f35ff090827f1ba563e6037901277644d0861b259b5fbdfc3b69b5594', '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 2402:a7c0:3003:104:1c00:5fff:fe00:f5', '2026-05-31 17:23:43'),
(35, 6, '0039315f35ff090827f1ba563e6037901277644d0861b259b5fbdfc3b69b5594', '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 2402:a7c0:3003:104:1c00:5fff:fe00:f5', '2026-05-31 17:29:09'),
(36, 7, '2857d536476f769d7aef42cca0d5db5f5eacbcdbda17e1f985d1be4b2cd7465a', '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'token_generate', 'New token for trial3', '2026-05-31 17:29:34'),
(37, 7, '2857d536476f769d7aef42cca0d5db5f5eacbcdbda17e1f985d1be4b2cd7465a', '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 2402:a7c0:3003:104:1c00:5fff:fe00:f5', '2026-05-31 17:29:34'),
(38, 7, '768e187701dd929c22796912754fa4a2735a2b754bed19dfd147f2f629ca7c32', '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'token_generate', 'New token for trial3', '2026-05-31 17:30:08'),
(39, 7, '768e187701dd929c22796912754fa4a2735a2b754bed19dfd147f2f629ca7c32', '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 2402:a7c0:3003:104:1c00:5fff:fe00:f5', '2026-05-31 17:30:08'),
(40, 7, '768e187701dd929c22796912754fa4a2735a2b754bed19dfd147f2f629ca7c32', '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 2402:a7c0:3003:104:1c00:5fff:fe00:f5', '2026-05-31 17:30:53'),
(41, 7, '768e187701dd929c22796912754fa4a2735a2b754bed19dfd147f2f629ca7c32', '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 2402:a7c0:3003:104:1c00:5fff:fe00:f5', '2026-05-31 17:31:11'),
(42, 7, NULL, '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Player/1.7.4.1 (Linux;Android 13; in; 1qxhupg)', 'device_limit', 'Device limit exceeded: trial3 (2402:a7c0:3003:104:1c00:5fff:fe00:f5)', '2026-05-31 17:31:36'),
(43, 7, NULL, '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Player/1.7.4.1 (Linux;Android 13; in; 1qxhupg)', 'device_limit', 'Device limit exceeded: trial3 (2402:a7c0:3003:104:1c00:5fff:fe00:f5)', '2026-05-31 17:31:46'),
(44, 7, NULL, '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Player/1.7.4.1 (Linux;Android 13; in; 1qxhupg)', 'device_limit', 'Device limit exceeded: trial3 (2402:a7c0:3003:104:1c00:5fff:fe00:f5)', '2026-05-31 17:31:48'),
(45, 7, NULL, '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Player/1.7.4.1 (Linux;Android 13; in; 1qxhupg)', 'device_limit', 'Device limit exceeded: trial3 (2402:a7c0:3003:104:1c00:5fff:fe00:f5)', '2026-05-31 17:32:31'),
(46, 8, '6342df8454763a0e13e74f35d91f630014ea26b73b3acdb0e5b83feb14c6da7d', '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'token_generate', 'New token for tipistream', '2026-05-31 17:41:48'),
(47, 8, '6342df8454763a0e13e74f35d91f630014ea26b73b3acdb0e5b83feb14c6da7d', '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 2402:a7c0:3003:104:1c00:5fff:fe00:f5', '2026-05-31 17:41:48'),
(48, 8, '6342df8454763a0e13e74f35d91f630014ea26b73b3acdb0e5b83feb14c6da7d', '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 2402:a7c0:3003:104:1c00:5fff:fe00:f5', '2026-05-31 17:42:03'),
(49, 1, NULL, '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Mobile Safari/537.36', 'login', 'Login berhasil', '2026-05-31 17:46:54'),
(50, 1, NULL, '64.120.92.26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'login', 'Login berhasil', '2026-05-31 18:50:09'),
(51, 8, 'f0d697ab377e72067ba5972e6dc948f21ab7b26e21b44ab3cd367139072d858c', '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'token_generate', 'New token for tipistream', '2026-05-31 19:00:20'),
(52, 8, 'f0d697ab377e72067ba5972e6dc948f21ab7b26e21b44ab3cd367139072d858c', '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 64.120.92.26', '2026-05-31 19:00:20'),
(53, 7, NULL, '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'expired', 'User expired, sajikan playlist gratis: trial3', '2026-05-31 19:00:32'),
(54, 8, 'f0d697ab377e72067ba5972e6dc948f21ab7b26e21b44ab3cd367139072d858c', '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 64.120.92.26', '2026-05-31 19:00:56'),
(55, 1, NULL, '64.120.92.26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'login', 'Login berhasil', '2026-05-31 19:06:24'),
(56, 2, NULL, '64.120.92.26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'login', 'Login berhasil', '2026-05-31 20:14:14'),
(57, 1, NULL, '64.120.92.26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'login', 'Login berhasil', '2026-06-01 16:24:00'),
(58, 8, '9dfb045ef1d3a1961a76af1f797f8b94b77d46f8c40ff22a4c314d4fc05e7f18', '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'token_generate', 'New token for tipistream', '2026-06-01 16:24:22'),
(59, 8, '9dfb045ef1d3a1961a76af1f797f8b94b77d46f8c40ff22a4c314d4fc05e7f18', '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 64.120.92.26', '2026-06-01 16:24:22'),
(60, 8, '9dfb045ef1d3a1961a76af1f797f8b94b77d46f8c40ff22a4c314d4fc05e7f18', '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 64.120.92.26', '2026-06-01 16:24:30'),
(61, 8, '9dfb045ef1d3a1961a76af1f797f8b94b77d46f8c40ff22a4c314d4fc05e7f18', '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 64.120.92.26', '2026-06-01 16:26:46'),
(62, 8, '9dfb045ef1d3a1961a76af1f797f8b94b77d46f8c40ff22a4c314d4fc05e7f18', '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 64.120.92.26', '2026-06-01 16:27:15'),
(63, 8, '9dfb045ef1d3a1961a76af1f797f8b94b77d46f8c40ff22a4c314d4fc05e7f18', '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 64.120.92.26', '2026-06-01 16:56:25'),
(64, 10, 'c61f8b172c679e052f5250efd4fd9e7776777f707ce9bb9a3160f060e7a69ee8', '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'token_generate', 'New token for timnasu19', '2026-06-01 16:56:41'),
(65, 10, 'c61f8b172c679e052f5250efd4fd9e7776777f707ce9bb9a3160f060e7a69ee8', '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 64.120.92.26', '2026-06-01 16:56:41'),
(66, 10, 'c61f8b172c679e052f5250efd4fd9e7776777f707ce9bb9a3160f060e7a69ee8', '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 64.120.92.26', '2026-06-01 17:01:56'),
(67, 10, 'a34dd0b7052da8dc165a64b81b89da3184879d625dcb94b06f1d2e1c08fa6bd1', '36.68.52.58', 'OTT Navigator/1.7.0.2.4 (Linux;Android 12; en; zrihkw)', 'token_generate', 'New token for timnasu19', '2026-06-01 17:18:02'),
(68, 10, 'a34dd0b7052da8dc165a64b81b89da3184879d625dcb94b06f1d2e1c08fa6bd1', '36.68.52.58', 'OTT Navigator/1.7.0.2.4 (Linux;Android 12; en; zrihkw)', 'stream_access', 'Format: m3u | IP: 36.68.52.58', '2026-06-01 17:18:02'),
(69, 1, NULL, '64.120.92.26', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Mobile Safari/537.36', 'login', 'Login berhasil', '2026-06-01 17:48:02'),
(70, 10, 'ddb3b55372f87ea71817f706475f4f1b9c7be32e8999c80782c17a0b197997f4', '2402:8780:1063:b25:d9ca:2dd8:982e:e5e0', 'OTT Navigator/1.7.0.2.4 (Linux;Android 10; in; hixduh)', 'token_generate', 'New token for timnasu19', '2026-06-01 17:58:25'),
(71, 10, 'ddb3b55372f87ea71817f706475f4f1b9c7be32e8999c80782c17a0b197997f4', '2402:8780:1063:b25:d9ca:2dd8:982e:e5e0', 'OTT Navigator/1.7.0.2.4 (Linux;Android 10; in; hixduh)', 'stream_access', 'Format: m3u | IP: 2402:8780:1063:b25:d9ca:2dd8:982e:e5e0', '2026-06-01 17:58:25'),
(72, 1, NULL, '64.120.92.26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'login', 'Login berhasil', '2026-06-01 18:36:16'),
(73, 1, NULL, '64.120.92.26', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Mobile Safari/537.36', 'login', 'Login berhasil', '2026-06-01 18:36:56'),
(74, 1, NULL, '64.120.92.26', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Mobile Safari/537.36', 'login', 'Login berhasil', '2026-06-01 18:41:01'),
(75, 1, NULL, '64.120.92.26', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Mobile Safari/537.36', 'login', 'Login berhasil', '2026-06-01 18:42:47'),
(76, 10, 'ddb3b55372f87ea71817f706475f4f1b9c7be32e8999c80782c17a0b197997f4', '2402:8780:1063:b25:d9ca:2dd8:982e:e5e0', 'OTT Navigator/1.7.0.2.4 (Linux;Android 10; in; hixduh)', 'stream_access', 'Format: m3u | IP: 2402:8780:1063:b25:d9ca:2dd8:982e:e5e0', '2026-06-01 18:48:47'),
(77, 1, NULL, '64.120.92.26', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Mobile Safari/537.36', 'login', 'Login berhasil', '2026-06-01 18:56:48'),
(78, 1, NULL, '64.120.92.26', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36', 'login', 'Login berhasil', '2026-06-01 19:00:59'),
(79, 10, '6c35599beb24e06062fefc16cd6d5a2e47e75c14e2fe13a6bdbe73539c88e1bd', '182.9.49.127', 'OTT Navigator/1.7.3.1 (Linux;Android 11; in; 1mao2sq)', 'token_generate', 'New token for timnasu19', '2026-06-01 19:03:28'),
(80, 10, '6c35599beb24e06062fefc16cd6d5a2e47e75c14e2fe13a6bdbe73539c88e1bd', '182.9.49.127', 'OTT Navigator/1.7.3.1 (Linux;Android 11; in; 1mao2sq)', 'stream_access', 'Format: m3u | IP: 182.9.49.127', '2026-06-01 19:03:28'),
(81, 10, '6c35599beb24e06062fefc16cd6d5a2e47e75c14e2fe13a6bdbe73539c88e1bd', '182.9.49.127', 'OTT Navigator/1.7.3.1 (Linux;Android 11; in; 1mao2sq)', 'stream_access', 'Format: m3u | IP: 182.9.49.127', '2026-06-01 19:03:48'),
(82, 10, 'd02bdd97d9793a3495ae359cd5ba05df6dde53fad636914dbbaff260b45a53b6', '2a03:2880:18ff:47::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'token_generate', 'New token for timnasu19', '2026-06-01 19:15:52'),
(83, 10, 'eca4a6204d17ea731facc2bfff02a98802c9aabcb30bc1c96fe11ee9a80b3451', '2a03:2880:24ff:43::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'token_generate', 'New token for timnasu19', '2026-06-01 19:15:52'),
(84, 10, 'd02bdd97d9793a3495ae359cd5ba05df6dde53fad636914dbbaff260b45a53b6', '2a03:2880:18ff:47::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'stream_access', 'Format: m3u | IP: 2a03:2880:18ff:47::', '2026-06-01 19:15:52'),
(85, 10, 'eca4a6204d17ea731facc2bfff02a98802c9aabcb30bc1c96fe11ee9a80b3451', '2a03:2880:24ff:43::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'stream_access', 'Format: m3u | IP: 2a03:2880:24ff:43::', '2026-06-01 19:15:52'),
(86, 10, '49a30ab54314a267e6e24521387c11083615f166dc8247d036c577e00ad9c6a0', '2a03:2880:10ff:5d::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'token_generate', 'New token for timnasu19', '2026-06-01 19:15:52'),
(87, 10, '49a30ab54314a267e6e24521387c11083615f166dc8247d036c577e00ad9c6a0', '2a03:2880:10ff:5d::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'stream_access', 'Format: m3u | IP: 2a03:2880:10ff:5d::', '2026-06-01 19:15:52'),
(88, 10, '2bab68430402d3b2216dbe46b7f6c6dd4d96f57d532795147952f534c42850f9', '2a03:2880:10ff:46::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'token_generate', 'New token for timnasu19', '2026-06-01 19:15:52'),
(89, 10, '2bab68430402d3b2216dbe46b7f6c6dd4d96f57d532795147952f534c42850f9', '2a03:2880:10ff:46::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'stream_access', 'Format: m3u | IP: 2a03:2880:10ff:46::', '2026-06-01 19:15:52'),
(90, 10, '163a3fc6ca5ac80e362ab6c60e45ed1245cc5cafc65e875601dd18be1ac47be7', '2a03:2880:15ff:44::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'token_generate', 'New token for timnasu19', '2026-06-01 19:15:52'),
(91, 10, '163a3fc6ca5ac80e362ab6c60e45ed1245cc5cafc65e875601dd18be1ac47be7', '2a03:2880:15ff:44::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'stream_access', 'Format: m3u | IP: 2a03:2880:15ff:44::', '2026-06-01 19:15:52'),
(92, 10, 'c98a9dcdf6f416888d0383e23badfdf909ea5db26c61b7f21e001298ed5b9668', '2a03:2880:18ff:71::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'token_generate', 'New token for timnasu19', '2026-06-01 19:15:52'),
(93, 10, 'c98a9dcdf6f416888d0383e23badfdf909ea5db26c61b7f21e001298ed5b9668', '2a03:2880:18ff:71::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'stream_access', 'Format: m3u | IP: 2a03:2880:18ff:71::', '2026-06-01 19:15:52'),
(94, 10, 'f382d7cf5cbab45b89de0aacff529fb639d5f01dea9c671d4dfb33874f4d6949', '2a03:2880:13ff:2::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'token_generate', 'New token for timnasu19', '2026-06-01 19:15:53'),
(95, 10, 'f382d7cf5cbab45b89de0aacff529fb639d5f01dea9c671d4dfb33874f4d6949', '2a03:2880:13ff:2::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'stream_access', 'Format: m3u | IP: 2a03:2880:13ff:2::', '2026-06-01 19:15:53'),
(96, 10, 'fec84488cc02fa5fe6eb32a313aa343b5b72cf265377514ae66c818508ddfb6f', '2a03:2880:2ff:5a::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'token_generate', 'New token for timnasu19', '2026-06-01 19:16:21'),
(97, 10, 'fec84488cc02fa5fe6eb32a313aa343b5b72cf265377514ae66c818508ddfb6f', '2a03:2880:2ff:5a::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'stream_access', 'Format: m3u | IP: 2a03:2880:2ff:5a::', '2026-06-01 19:16:21'),
(98, 10, '2c708089f9c504ce6f5a40326341b7d20a07a9c79d0d04b25b46a28b7644e574', '2a03:2880:7ff:17::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'token_generate', 'New token for timnasu19', '2026-06-01 19:16:21'),
(99, 10, '2c708089f9c504ce6f5a40326341b7d20a07a9c79d0d04b25b46a28b7644e574', '2a03:2880:7ff:17::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'stream_access', 'Format: m3u | IP: 2a03:2880:7ff:17::', '2026-06-01 19:16:21'),
(100, 10, 'b911bb53234625746ba0b94c6116c952ed6ecaeab673b4af79b23eb4bd179e0c', '2a03:2880:11ff:5b::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'token_generate', 'New token for timnasu19', '2026-06-01 19:16:21'),
(101, 10, 'b911bb53234625746ba0b94c6116c952ed6ecaeab673b4af79b23eb4bd179e0c', '2a03:2880:11ff:5b::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'stream_access', 'Format: m3u | IP: 2a03:2880:11ff:5b::', '2026-06-01 19:16:21'),
(102, 10, 'f44b3f735398811df5a3e2cace2da22bec3c8254fa680dae4b50e954d8478167', '2a03:2880:25ff:46::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'token_generate', 'New token for timnasu19', '2026-06-01 19:16:23'),
(103, 10, 'f44b3f735398811df5a3e2cace2da22bec3c8254fa680dae4b50e954d8478167', '2a03:2880:25ff:46::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'stream_access', 'Format: m3u | IP: 2a03:2880:25ff:46::', '2026-06-01 19:16:23'),
(104, 10, '118d8997fcb57ebb0157e18ab71f41e21f9e92dbc738a5be680e581b7723ae0a', '2a03:2880:24ff:4a::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'token_generate', 'New token for timnasu19', '2026-06-01 19:16:37'),
(105, 10, '118d8997fcb57ebb0157e18ab71f41e21f9e92dbc738a5be680e581b7723ae0a', '2a03:2880:24ff:4a::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'stream_access', 'Format: m3u | IP: 2a03:2880:24ff:4a::', '2026-06-01 19:16:37'),
(106, 12, 'e58a995a651fc7612ff213b1d776dbf084a4691e81ad46f5c5b56076fd441fa6', '149.154.161.233', 'TelegramBot (like TwitterBot)', 'token_generate', 'New token for raihan', '2026-06-01 19:17:56'),
(107, 12, 'e58a995a651fc7612ff213b1d776dbf084a4691e81ad46f5c5b56076fd441fa6', '149.154.161.233', 'TelegramBot (like TwitterBot)', 'stream_access', 'Format: m3u | IP: 149.154.161.233', '2026-06-01 19:17:56'),
(108, 10, '6b078a6e3cc1c13be83014db0f64a687639f829a1afdd38025a296d9b3f654a4', '2404:c0:5b12:2413:5c6b:c7ff:c78b:b6cc', 'OTT Navigator/1.7.3.3 (Linux;Android 16; in; xzugrx)', 'token_generate', 'New token for timnasu19', '2026-06-01 19:22:31'),
(109, 10, '6b078a6e3cc1c13be83014db0f64a687639f829a1afdd38025a296d9b3f654a4', '2404:c0:5b12:2413:5c6b:c7ff:c78b:b6cc', 'OTT Navigator/1.7.3.3 (Linux;Android 16; in; xzugrx)', 'stream_access', 'Format: m3u | IP: 2404:c0:5b12:2413:5c6b:c7ff:c78b:b6cc', '2026-06-01 19:22:31'),
(110, 10, '118d8997fcb57ebb0157e18ab71f41e21f9e92dbc738a5be680e581b7723ae0a', '2a03:2880:24ff:4a::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'stream_access', 'Format: m3u | IP: 2a03:2880:24ff:4a::', '2026-06-01 19:35:31'),
(111, 12, 'abd1a6af48f15249324d279ec076c093919d64c25cef0296092318cb62501c57', '202.65.239.1', 'OTT Navigator/1.7.2.2 (Linux;Android 6.0.1; in; 1em86x2)', 'token_generate', 'New token for raihan', '2026-06-01 19:36:40'),
(112, 12, 'abd1a6af48f15249324d279ec076c093919d64c25cef0296092318cb62501c57', '202.65.239.1', 'OTT Navigator/1.7.2.2 (Linux;Android 6.0.1; in; 1em86x2)', 'stream_access', 'Format: m3u | IP: 202.65.239.1', '2026-06-01 19:36:40'),
(113, 12, 'abd1a6af48f15249324d279ec076c093919d64c25cef0296092318cb62501c57', '202.65.239.1', 'OTT Navigator/1.7.2.2 (Linux;Android 6.0.1; in; 1em86x2)', 'stream_access', 'Format: m3u | IP: 202.65.239.1', '2026-06-01 19:37:38'),
(114, 10, 'cab872da33a8648776b3a0fc6fe6f1e1f19681cff516e73adce2bd9d8f9f884b', '31.186.87.211', 'Unknown', 'token_generate', 'New token for timnasu19', '2026-06-01 19:39:26'),
(115, 10, 'cab872da33a8648776b3a0fc6fe6f1e1f19681cff516e73adce2bd9d8f9f884b', '31.186.87.211', 'Unknown', 'stream_access', 'Format: m3u | IP: 31.186.87.211', '2026-06-01 19:39:26'),
(116, 10, '6c35599beb24e06062fefc16cd6d5a2e47e75c14e2fe13a6bdbe73539c88e1bd', '182.9.49.127', 'OTT Navigator/1.7.3.1 (Linux;Android 11; in; 1mao2sq)', 'stream_access', 'Format: m3u | IP: 182.9.49.127', '2026-06-01 19:39:55'),
(117, 10, 'ca4f3e0260c25420ec3ec915e755a44c9220df32332246ce03bbe26c1bf272fa', '182.2.205.160', 'WhatsApp/2.23.20.0', 'token_generate', 'New token for timnasu19', '2026-06-01 19:40:37'),
(118, 10, 'ca4f3e0260c25420ec3ec915e755a44c9220df32332246ce03bbe26c1bf272fa', '182.2.205.160', 'WhatsApp/2.23.20.0', 'stream_access', 'Format: m3u | IP: 182.2.205.160', '2026-06-01 19:40:38'),
(119, 10, '623b95f1ed5311e3c1ec8874bbd5033dd7b9e26c7e133d4c1c61af3a1de6ab01', '182.9.49.127', 'OTT Navigator/1.7.1.6 (Linux;Android 11; in; 7bhc31)', 'token_generate', 'New token for timnasu19', '2026-06-01 19:42:42'),
(120, 10, '623b95f1ed5311e3c1ec8874bbd5033dd7b9e26c7e133d4c1c61af3a1de6ab01', '182.9.49.127', 'OTT Navigator/1.7.1.6 (Linux;Android 11; in; 7bhc31)', 'stream_access', 'Format: m3u | IP: 182.9.49.127', '2026-06-01 19:42:42'),
(121, 10, '402924f00a6e3bb51209772fa830df75534f4c44880fee13da4b70ddb224214e', '103.126.87.176', 'WhatsApp/2.23.20.0', 'token_generate', 'New token for timnasu19', '2026-06-01 19:45:04'),
(122, 10, '402924f00a6e3bb51209772fa830df75534f4c44880fee13da4b70ddb224214e', '103.126.87.176', 'WhatsApp/2.23.20.0', 'stream_access', 'Format: m3u | IP: 103.126.87.176', '2026-06-01 19:45:04'),
(123, 10, 'c2cfd4c240492b6d180f153d3bc8e113a286b3cf6352d92df6582cfe2a1326f3', '103.126.87.176', 'OTT TV/1.7.4.1 (Linux;Android 12; in; bezwvi)', 'token_generate', 'New token for timnasu19', '2026-06-01 19:48:22'),
(124, 10, 'c2cfd4c240492b6d180f153d3bc8e113a286b3cf6352d92df6582cfe2a1326f3', '103.126.87.176', 'OTT TV/1.7.4.1 (Linux;Android 12; in; bezwvi)', 'stream_access', 'Format: m3u | IP: 103.126.87.176', '2026-06-01 19:48:22'),
(125, 10, 'a7773cf6520d2c4d83cd8bf23d20c2294c4d28c1ef34a27431310d48763340b3', '103.184.123.42', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'token_generate', 'New token for timnasu19', '2026-06-01 19:50:15'),
(126, 10, 'a7773cf6520d2c4d83cd8bf23d20c2294c4d28c1ef34a27431310d48763340b3', '103.184.123.42', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 103.184.123.42', '2026-06-01 19:50:15'),
(127, 10, 'a7773cf6520d2c4d83cd8bf23d20c2294c4d28c1ef34a27431310d48763340b3', '103.184.123.42', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 103.184.123.42', '2026-06-01 19:50:17'),
(128, 10, '010618695afdb153d8b61c643040e1295363b9b34901ecc6a7dc3d593a51bbbd', '2a03:2880:16ff:8::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'token_generate', 'New token for timnasu19', '2026-06-01 19:52:42'),
(129, 10, '010618695afdb153d8b61c643040e1295363b9b34901ecc6a7dc3d593a51bbbd', '2a03:2880:16ff:8::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'stream_access', 'Format: m3u | IP: 2a03:2880:16ff:8::', '2026-06-01 19:52:42'),
(130, 10, 'a7773cf6520d2c4d83cd8bf23d20c2294c4d28c1ef34a27431310d48763340b3', '103.184.123.42', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 103.184.123.42', '2026-06-01 19:53:05'),
(131, 10, '42140e60dad6d977abce46ef3fdb490de1d01ebbaa7fbf77ede9f04a7461cb20', '114.125.238.125', 'OTT Navigator/1.7.3.3 (Linux;Android 15; id; 1c5wme0)', 'token_generate', 'New token for timnasu19', '2026-06-01 19:53:36'),
(132, 10, '42140e60dad6d977abce46ef3fdb490de1d01ebbaa7fbf77ede9f04a7461cb20', '114.125.238.125', 'OTT Navigator/1.7.3.3 (Linux;Android 15; id; 1c5wme0)', 'stream_access', 'Format: m3u | IP: 114.125.238.125', '2026-06-01 19:53:36'),
(133, 10, '6dedaeb3d1f99b4b33dc23d1a8d0eb20ee1bbce4d88929e0df310152cac5613d', '103.133.61.171', 'OTT Navigator/1.7.3.3 (Linux;Android 16; in; xzugrx)', 'token_generate', 'New token for timnasu19', '2026-06-01 19:58:26'),
(134, 10, '6dedaeb3d1f99b4b33dc23d1a8d0eb20ee1bbce4d88929e0df310152cac5613d', '103.133.61.171', 'OTT Navigator/1.7.3.3 (Linux;Android 16; in; xzugrx)', 'stream_access', 'Format: m3u | IP: 103.133.61.171', '2026-06-01 19:58:26'),
(135, 1, NULL, '103.184.123.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'login', 'Login berhasil', '2026-06-01 20:04:30'),
(136, 10, '8d9a89de47260623f63660fc9998c6806943b8414aa369e3444c037b3e419626', '2404:c0:701f:6699:d4f2:ddff:feb4:e423', 'Reqable/3.1.2', 'token_generate', 'New token for timnasu19', '2026-06-01 20:06:00'),
(137, 10, '8d9a89de47260623f63660fc9998c6806943b8414aa369e3444c037b3e419626', '2404:c0:701f:6699:d4f2:ddff:feb4:e423', 'Reqable/3.1.2', 'stream_access', 'Format: m3u | IP: 2404:c0:701f:6699:d4f2:ddff:feb4:e423', '2026-06-01 20:06:00'),
(138, 10, 'ca4f3e0260c25420ec3ec915e755a44c9220df32332246ce03bbe26c1bf272fa', '182.2.205.160', 'WhatsApp/2.23.20.0', 'stream_access', 'Format: m3u | IP: 182.2.205.160', '2026-06-01 20:07:47'),
(139, 10, '2f23bdc7ca4a95968c1a38bee2d6cccf8b527bd7357634a48351fd9b9f460966', '182.5.136.169', 'VLC/3.0.22-rc1 LibVLC/3.0.22-rc1', 'token_generate', 'New token for timnasu19', '2026-06-01 20:10:01'),
(140, 10, '2f23bdc7ca4a95968c1a38bee2d6cccf8b527bd7357634a48351fd9b9f460966', '182.5.136.169', 'VLC/3.0.22-rc1 LibVLC/3.0.22-rc1', 'stream_access', 'Format: m3u | IP: 182.5.136.169', '2026-06-01 20:10:01'),
(141, 10, '2f23bdc7ca4a95968c1a38bee2d6cccf8b527bd7357634a48351fd9b9f460966', '182.5.136.169', 'VLC/3.0.22-rc1 LibVLC/3.0.22-rc1', 'stream_access', 'Format: m3u | IP: 182.5.136.169', '2026-06-01 20:10:11'),
(142, 10, '85dc96171ea821508ed4822e1445aab9998b9381e2d633bf6d69a1fa1a1398c4', '2404:c0:701f:6699:d4f2:ddff:feb4:e423', 'TWF1TWFsaW5nS2FoS29udG9s==', 'token_generate', 'New token for timnasu19', '2026-06-01 20:10:22'),
(143, 10, '85dc96171ea821508ed4822e1445aab9998b9381e2d633bf6d69a1fa1a1398c4', '2404:c0:701f:6699:d4f2:ddff:feb4:e423', 'TWF1TWFsaW5nS2FoS29udG9s==', 'stream_access', 'Format: m3u | IP: 2404:c0:701f:6699:d4f2:ddff:feb4:e423', '2026-06-01 20:10:22'),
(144, 10, '85dc96171ea821508ed4822e1445aab9998b9381e2d633bf6d69a1fa1a1398c4', '2404:c0:701f:6699:d4f2:ddff:feb4:e423', 'TWF1TWFsaW5nS2FoS29udG9s==', 'stream_access', 'Format: m3u | IP: 2404:c0:701f:6699:d4f2:ddff:feb4:e423', '2026-06-01 20:10:24'),
(145, 10, '1bff31badfa8a0fe7e1a4c67630f08c919fe08a2e3aff529163c36cfff3c220c', '157.20.207.171', 'TWF1TWFsaW5nS2FoS29udG9s==', 'token_generate', 'New token for timnasu19', '2026-06-01 20:10:51'),
(146, 10, '1bff31badfa8a0fe7e1a4c67630f08c919fe08a2e3aff529163c36cfff3c220c', '157.20.207.171', 'TWF1TWFsaW5nS2FoS29udG9s==', 'stream_access', 'Format: m3u | IP: 157.20.207.171', '2026-06-01 20:10:51'),
(147, 10, '2f23bdc7ca4a95968c1a38bee2d6cccf8b527bd7357634a48351fd9b9f460966', '182.5.136.169', 'VLC/3.0.22-rc1 LibVLC/3.0.22-rc1', 'stream_access', 'Format: m3u | IP: 182.5.136.169', '2026-06-01 20:10:55'),
(148, 10, '406cff69785e6b4edcdfa0734802db6b7a315d1ada742bb9635094cfe3975dcb', '64.233.173.236', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'token_generate', 'New token for timnasu19', '2026-06-01 20:11:19'),
(149, 10, '406cff69785e6b4edcdfa0734802db6b7a315d1ada742bb9635094cfe3975dcb', '64.233.173.236', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'stream_access', 'Format: m3u | IP: 64.233.173.236', '2026-06-01 20:11:19'),
(150, 10, '76dc41300da5184beef01bad5b951136d433786a182af6386794c68338205c86', '182.5.136.169', 'Dart/3.10 (dart:io)', 'token_generate', 'New token for timnasu19', '2026-06-01 20:12:48'),
(151, 10, '76dc41300da5184beef01bad5b951136d433786a182af6386794c68338205c86', '182.5.136.169', 'Dart/3.10 (dart:io)', 'stream_access', 'Format: m3u | IP: 182.5.136.169', '2026-06-01 20:12:48'),
(152, 10, '1bff31badfa8a0fe7e1a4c67630f08c919fe08a2e3aff529163c36cfff3c220c', '157.20.207.171', 'TWF1TWFsaW5nS2FoS29udG9s==', 'stream_access', 'Format: m3u | IP: 157.20.207.171', '2026-06-01 20:12:50'),
(153, 10, 'dacb1ff60c350a8df5f5de7e183c84ed7aedfd284b3da9c1d041d5faaed5284d', '182.5.136.169', 'Mozilla/5.0 (Linux; Android 15; TECNO CM7 Build/AP3A.240905.015.A2; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/148.0.7778.178 Mobile Safari/537.36', 'token_generate', 'New token for timnasu19', '2026-06-01 20:12:53'),
(154, 10, 'dacb1ff60c350a8df5f5de7e183c84ed7aedfd284b3da9c1d041d5faaed5284d', '182.5.136.169', 'Mozilla/5.0 (Linux; Android 15; TECNO CM7 Build/AP3A.240905.015.A2; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/148.0.7778.178 Mobile Safari/537.36', 'stream_access', 'Format: m3u | IP: 182.5.136.169', '2026-06-01 20:12:53'),
(155, 10, '1bff31badfa8a0fe7e1a4c67630f08c919fe08a2e3aff529163c36cfff3c220c', '157.20.207.171', 'TWF1TWFsaW5nS2FoS29udG9s==', 'stream_access', 'Format: m3u | IP: 157.20.207.171', '2026-06-01 20:14:46'),
(156, 10, '1bff31badfa8a0fe7e1a4c67630f08c919fe08a2e3aff529163c36cfff3c220c', '157.20.207.171', 'TWF1TWFsaW5nS2FoS29udG9s==', 'stream_access', 'Format: m3u | IP: 157.20.207.171', '2026-06-01 20:14:50'),
(157, 10, 'dacb1ff60c350a8df5f5de7e183c84ed7aedfd284b3da9c1d041d5faaed5284d', '182.5.136.169', 'Mozilla/5.0 (Linux; Android 15; TECNO CM7 Build/AP3A.240905.015.A2; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/148.0.7778.178 Mobile Safari/537.36', 'stream_access', 'Format: m3u | IP: 182.5.136.169', '2026-06-01 20:15:39'),
(158, 10, '6dedaeb3d1f99b4b33dc23d1a8d0eb20ee1bbce4d88929e0df310152cac5613d', '103.133.61.171', 'OTT Navigator/1.7.3.3 (Linux;Android 16; in; xzugrx)', 'stream_access', 'Format: m3u | IP: 103.133.61.171', '2026-06-01 20:19:32'),
(159, 10, 'f57e06e44afaab6fc6ee5bc7b203f5475df7e029c512de5d2e0120dae17b1c48', '2404:c0:5b12:2413:1:0:121a:4f97', 'OTT Navigator/1.7.3.3 (Linux;Android 16; in; xzugrx)', 'token_generate', 'New token for timnasu19', '2026-06-01 20:30:58'),
(160, 10, 'f57e06e44afaab6fc6ee5bc7b203f5475df7e029c512de5d2e0120dae17b1c48', '2404:c0:5b12:2413:1:0:121a:4f97', 'OTT Navigator/1.7.3.3 (Linux;Android 16; in; xzugrx)', 'stream_access', 'Format: m3u | IP: 2404:c0:5b12:2413:1:0:121a:4f97', '2026-06-01 20:30:58'),
(161, 10, 'ed011cbf38b68bea61e5006a299e8ee4a0ae4a2e78c0e2ce2dc45c3962a2964d', '2404:c0:d001:2be9:55c8:64ae:64e2:efc1', 'OTT Navigator/1.7.3.2 (Linux;Android 13; in; 1ng6ygt)', 'token_generate', 'New token for timnasu19', '2026-06-01 20:31:39'),
(162, 10, 'ed011cbf38b68bea61e5006a299e8ee4a0ae4a2e78c0e2ce2dc45c3962a2964d', '2404:c0:d001:2be9:55c8:64ae:64e2:efc1', 'OTT Navigator/1.7.3.2 (Linux;Android 13; in; 1ng6ygt)', 'stream_access', 'Format: m3u | IP: 2404:c0:d001:2be9:55c8:64ae:64e2:efc1', '2026-06-01 20:31:39'),
(163, 12, NULL, '114.122.38.30', 'OTT Navigator/1.7.2.2 (Linux;Android 6.0.1; in; 1em86x2)', 'device_limit', 'Device limit exceeded: raihan (114.122.38.30)', '2026-06-01 20:37:39'),
(164, 12, NULL, '114.122.38.30', 'OTT Navigator/1.7.2.2 (Linux;Android 6.0.1; in; 1em86x2)', 'device_limit', 'Device limit exceeded: raihan (114.122.38.30)', '2026-06-01 20:42:38'),
(165, 1, NULL, '103.184.123.42', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36', 'login', 'Login berhasil', '2026-06-01 20:44:36'),
(166, 10, 'a7773cf6520d2c4d83cd8bf23d20c2294c4d28c1ef34a27431310d48763340b3', '103.184.123.42', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 103.184.123.42', '2026-06-01 20:47:45'),
(167, 10, 'a7773cf6520d2c4d83cd8bf23d20c2294c4d28c1ef34a27431310d48763340b3', '103.184.123.42', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 103.184.123.42', '2026-06-01 20:47:47'),
(168, 12, NULL, '114.122.38.30', 'OTT Navigator/1.7.2.2 (Linux;Android 6.0.1; in; 1em86x2)', 'device_limit', 'Device limit exceeded: raihan (114.122.38.30)', '2026-06-01 20:49:40'),
(169, 1, NULL, '103.184.123.42', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36', 'login', 'Login berhasil', '2026-06-01 20:50:03'),
(170, 10, '68174105d5af9edcd0ae5d1c1aa3fd9296bf26f24d0ec7d94ccb4730ab162607', '2404:8000:1055:7b8:8c6:9b7:170c:9802', 'OTT Navigator/1.7.4.1 (Linux;Android 16; id; 3r6195)', 'token_generate', 'New token for timnasu19', '2026-06-01 21:10:07'),
(171, 10, '68174105d5af9edcd0ae5d1c1aa3fd9296bf26f24d0ec7d94ccb4730ab162607', '2404:8000:1055:7b8:8c6:9b7:170c:9802', 'OTT Navigator/1.7.4.1 (Linux;Android 16; id; 3r6195)', 'stream_access', 'Format: m3u | IP: 2404:8000:1055:7b8:8c6:9b7:170c:9802', '2026-06-01 21:10:07'),
(172, NULL, NULL, '114.10.47.90', 'Mozilla/5.0 (QtEmbedded; U; Linux; C) AppleWebKit/533.3 (KHTML, like Gecko) MAG200 stbapp ver: 2 rev: 250 Safari/533.3', 'blocked', 'User tidak ditemukan: timnasu19/stalker_portal/server/load.php', '2026-06-01 21:11:09'),
(173, NULL, NULL, '114.10.47.90', 'Dalvik/2.1.0 (Linux; U; Android 9; ASUS_I001DA Build/PQ3A.190705.09121607)', 'blocked', 'User tidak ditemukan: timnasu19/', '2026-06-01 21:11:09'),
(174, NULL, NULL, '114.10.47.90', 'Mozilla/5.0 (QtEmbedded; U; Linux; C) AppleWebKit/533.3 (KHTML, like Gecko) MAG200 stbapp ver: 2 rev: 250 Safari/533.3', 'blocked', 'User tidak ditemukan: timnasu19/stalker_portal/server/load.php', '2026-06-01 21:11:10'),
(175, NULL, NULL, '114.10.47.90', 'Dalvik/2.1.0 (Linux; U; Android 9; ASUS_I001DA Build/PQ3A.190705.09121607)', 'blocked', 'User tidak ditemukan: timnasu19/', '2026-06-01 21:11:10'),
(176, NULL, NULL, '114.10.47.90', 'Mozilla/5.0 (QtEmbedded; U; Linux; C) AppleWebKit/533.3 (KHTML, like Gecko) MAG200 stbapp ver: 2 rev: 250 Safari/533.3', 'blocked', 'User tidak ditemukan: timnasu19/stalker_portal/server/load.php', '2026-06-01 21:11:11'),
(177, NULL, NULL, '114.10.47.90', 'Mozilla/5.0 (QtEmbedded; U; Linux; C) AppleWebKit/533.3 (KHTML, like Gecko) MAG200 stbapp ver: 2 rev: 250 Safari/533.3', 'blocked', 'User tidak ditemukan: timnasu19/stalker_portal/server/load.php', '2026-06-01 21:11:11'),
(178, NULL, NULL, '114.10.47.90', 'Dalvik/2.1.0 (Linux; U; Android 9; ASUS_I001DA Build/PQ3A.190705.09121607)', 'blocked', 'User tidak ditemukan: timnasu19/', '2026-06-01 21:11:11'),
(179, NULL, NULL, '114.10.47.90', 'Dalvik/2.1.0 (Linux; U; Android 9; ASUS_I001DA Build/PQ3A.190705.09121607)', 'blocked', 'User tidak ditemukan: timnasu19/', '2026-06-01 21:11:11'),
(180, NULL, NULL, '114.10.47.90', 'Mozilla/5.0 (QtEmbedded; U; Linux; C) AppleWebKit/533.3 (KHTML, like Gecko) MAG200 stbapp ver: 2 rev: 250 Safari/533.3', 'blocked', 'User tidak ditemukan: timnasu19/stalker_portal/server/load.php', '2026-06-01 21:11:11'),
(181, NULL, NULL, '114.10.47.90', 'Mozilla/5.0 (QtEmbedded; U; Linux; C) AppleWebKit/533.3 (KHTML, like Gecko) MAG200 stbapp ver: 2 rev: 250 Safari/533.3', 'blocked', 'User tidak ditemukan: timnasu19/stalker_portal/server/load.php', '2026-06-01 21:11:12'),
(182, NULL, NULL, '114.10.47.90', 'Dalvik/2.1.0 (Linux; U; Android 9; ASUS_I001DA Build/PQ3A.190705.09121607)', 'blocked', 'User tidak ditemukan: timnasu19/', '2026-06-01 21:11:12'),
(183, NULL, NULL, '114.10.47.90', 'Dalvik/2.1.0 (Linux; U; Android 9; ASUS_I001DA Build/PQ3A.190705.09121607)', 'blocked', 'User tidak ditemukan: timnasu19/', '2026-06-01 21:11:12'),
(184, NULL, NULL, '114.10.47.90', 'Mozilla/5.0 (QtEmbedded; U; Linux; C) AppleWebKit/533.3 (KHTML, like Gecko) MAG200 stbapp ver: 2 rev: 250 Safari/533.3', 'blocked', 'User tidak ditemukan: timnasu19/stalker_portal/server/load.php', '2026-06-01 21:11:12'),
(185, NULL, NULL, '114.10.47.90', 'Dalvik/2.1.0 (Linux; U; Android 9; ASUS_I001DA Build/PQ3A.190705.09121607)', 'blocked', 'User tidak ditemukan: timnasu19/', '2026-06-01 21:11:13'),
(186, NULL, NULL, '114.10.47.90', 'Mozilla/5.0 (QtEmbedded; U; Linux; C) AppleWebKit/533.3 (KHTML, like Gecko) MAG200 stbapp ver: 2 rev: 250 Safari/533.3', 'blocked', 'User tidak ditemukan: timnasu19/stalker_portal/server/load.php', '2026-06-01 21:11:14'),
(187, NULL, NULL, '114.10.47.90', 'Dalvik/2.1.0 (Linux; U; Android 9; ASUS_I001DA Build/PQ3A.190705.09121607)', 'blocked', 'User tidak ditemukan: timnasu19/', '2026-06-01 21:11:15'),
(188, 10, 'a7773cf6520d2c4d83cd8bf23d20c2294c4d28c1ef34a27431310d48763340b3', '103.184.123.42', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 103.184.123.42', '2026-06-01 21:15:11'),
(189, 10, 'a7773cf6520d2c4d83cd8bf23d20c2294c4d28c1ef34a27431310d48763340b3', '103.184.123.42', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 103.184.123.42', '2026-06-01 21:15:12'),
(190, 10, '20f9c0ffea9596877b5a0094f480b74270ce7a42c5b7467ce2e1e0a8fd3e11e6', '2404:c0:960a:48d0:bffd:cf23:16a7:7722', 'OTT Navigator/1.7.1.6 (Linux;Android 15; in; a8ca3l)', 'token_generate', 'New token for timnasu19', '2026-06-01 21:16:54'),
(191, 10, '20f9c0ffea9596877b5a0094f480b74270ce7a42c5b7467ce2e1e0a8fd3e11e6', '2404:c0:960a:48d0:bffd:cf23:16a7:7722', 'OTT Navigator/1.7.1.6 (Linux;Android 15; in; a8ca3l)', 'stream_access', 'Format: m3u | IP: 2404:c0:960a:48d0:bffd:cf23:16a7:7722', '2026-06-01 21:16:54'),
(192, 10, '8171b3e99f108e314300d67dcd5da838a3bcae73d6732e57fc813afcc337c4a6', '2402:8780:1063:b25:b1d5:7b2a:db8e:3bcc', 'OTT Navigator/1.7.0.2.4 (Linux;Android 10; in; hixduh)', 'token_generate', 'New token for timnasu19', '2026-06-01 21:19:43'),
(193, 10, '8171b3e99f108e314300d67dcd5da838a3bcae73d6732e57fc813afcc337c4a6', '2402:8780:1063:b25:b1d5:7b2a:db8e:3bcc', 'OTT Navigator/1.7.0.2.4 (Linux;Android 10; in; hixduh)', 'stream_access', 'Format: m3u | IP: 2402:8780:1063:b25:b1d5:7b2a:db8e:3bcc', '2026-06-01 21:19:43'),
(194, 10, 'a7773cf6520d2c4d83cd8bf23d20c2294c4d28c1ef34a27431310d48763340b3', '103.184.123.42', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 103.184.123.42', '2026-06-01 21:37:39'),
(195, 10, 'a7773cf6520d2c4d83cd8bf23d20c2294c4d28c1ef34a27431310d48763340b3', '103.184.123.42', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 103.184.123.42', '2026-06-01 21:37:53'),
(196, 10, 'a7773cf6520d2c4d83cd8bf23d20c2294c4d28c1ef34a27431310d48763340b3', '103.184.123.42', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 103.184.123.42', '2026-06-01 21:38:09'),
(197, 1, NULL, '202.67.44.5', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36', 'login', 'Login berhasil', '2026-06-01 22:20:25'),
(198, 10, '3984b5bf5037d2cc874ed1c048ddb83235cd80de09afe196d3292506820589f3', '149.102.133.54', 'OTT Navigator/1.7.5.1 (Linux;Android 14; en; cd5ff)', 'token_generate', 'New token for timnasu19', '2026-06-01 22:33:53'),
(199, 10, '3984b5bf5037d2cc874ed1c048ddb83235cd80de09afe196d3292506820589f3', '149.102.133.54', 'OTT Navigator/1.7.5.1 (Linux;Android 14; en; cd5ff)', 'stream_access', 'Format: m3u | IP: 149.102.133.54', '2026-06-01 22:33:53'),
(200, 10, 'd41a4ab2cadb66ee2609e5cb83293ebf00f1b7821bb3104e79daf6cbb64dd0c9', '202.65.225.230', 'OTT Player/1.7.4.1 (Linux;Android 16; id; 1sjeack)', 'token_generate', 'New token for timnasu19', '2026-06-01 22:34:47'),
(201, 10, 'd41a4ab2cadb66ee2609e5cb83293ebf00f1b7821bb3104e79daf6cbb64dd0c9', '202.65.225.230', 'OTT Player/1.7.4.1 (Linux;Android 16; id; 1sjeack)', 'stream_access', 'Format: m3u | IP: 202.65.225.230', '2026-06-01 22:34:47'),
(202, 10, '0f19039bbc606454ed0b86a2a93fe5be48143344fcc92583137a0273c393c65f', '192.178.6.100', 'Googlebot-Image/1.0', 'token_generate', 'New token for timnasu19', '2026-06-01 22:34:47'),
(203, 10, '0f19039bbc606454ed0b86a2a93fe5be48143344fcc92583137a0273c393c65f', '192.178.6.100', 'Googlebot-Image/1.0', 'stream_access', 'Format: m3u | IP: 192.178.6.100', '2026-06-01 22:34:47'),
(204, 10, 'e2227fefefc9a55bc42390a13a1e102aa459a3afb97d41f7d8f3528d21a676b3', '182.10.229.56', 'WhatsApp/2.23.20.0', 'token_generate', 'New token for timnasu19', '2026-06-01 23:10:09'),
(205, 10, 'e2227fefefc9a55bc42390a13a1e102aa459a3afb97d41f7d8f3528d21a676b3', '182.10.229.56', 'WhatsApp/2.23.20.0', 'stream_access', 'Format: m3u | IP: 182.10.229.56', '2026-06-01 23:10:09'),
(206, 10, 'e482af2cdb28ab22a6af4e74610f2161cbe8be61a7f346530f18ebf39239c147', '182.10.229.56', 'Reqable/3.0.38', 'token_generate', 'New token for timnasu19', '2026-06-01 23:10:26'),
(207, 10, 'e482af2cdb28ab22a6af4e74610f2161cbe8be61a7f346530f18ebf39239c147', '182.10.229.56', 'Reqable/3.0.38', 'stream_access', 'Format: m3u | IP: 182.10.229.56', '2026-06-01 23:10:26'),
(208, 10, 'f6cc3ff83183844a965f45e6ba956a061ac595dae16055020fe236b86765a305', '103.102.12.65', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36', 'token_generate', 'New token for timnasu19', '2026-06-02 01:59:14'),
(209, 10, 'f6cc3ff83183844a965f45e6ba956a061ac595dae16055020fe236b86765a305', '103.102.12.65', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36', 'stream_access', 'Format: m3u | IP: 103.102.12.65', '2026-06-02 01:59:14'),
(210, 10, 'ba4f2c9ad4f295358e8501d107c8e08f2403666c884d9c6a4b3f566a2886598a', '103.102.12.65', 'OTT Navigator/1.7.5.1 (Linux;Android 12; in; 1qo2t0m)', 'token_generate', 'New token for timnasu19', '2026-06-02 02:00:20'),
(211, 10, 'ba4f2c9ad4f295358e8501d107c8e08f2403666c884d9c6a4b3f566a2886598a', '103.102.12.65', 'OTT Navigator/1.7.5.1 (Linux;Android 12; in; 1qo2t0m)', 'stream_access', 'Format: m3u | IP: 103.102.12.65', '2026-06-02 02:00:20'),
(212, 10, 'ba4f2c9ad4f295358e8501d107c8e08f2403666c884d9c6a4b3f566a2886598a', '103.102.12.65', 'OTT Navigator/1.7.5.1 (Linux;Android 12; in; 1qo2t0m)', 'stream_access', 'Format: m3u | IP: 103.102.12.65', '2026-06-02 02:21:15'),
(213, 10, 'ba4f2c9ad4f295358e8501d107c8e08f2403666c884d9c6a4b3f566a2886598a', '103.102.12.65', 'OTT Navigator/1.7.5.1 (Linux;Android 12; in; 1qo2t0m)', 'stream_access', 'Format: m3u | IP: 103.102.12.65', '2026-06-02 02:22:26'),
(214, 10, 'ba4f2c9ad4f295358e8501d107c8e08f2403666c884d9c6a4b3f566a2886598a', '103.102.12.65', 'OTT Navigator/1.7.5.1 (Linux;Android 12; in; 1qo2t0m)', 'stream_access', 'Format: m3u | IP: 103.102.12.65', '2026-06-02 03:23:47'),
(215, 10, 'ba4f2c9ad4f295358e8501d107c8e08f2403666c884d9c6a4b3f566a2886598a', '103.102.12.65', 'OTT Navigator/1.7.5.1 (Linux;Android 12; in; 1qo2t0m)', 'stream_access', 'Format: m3u | IP: 103.102.12.65', '2026-06-02 03:47:40'),
(216, 10, '0d8339d0f00502e4b666c4385b58a05dbd631535e902f5194497a0c22f599a43', '81.177.173.135', 'Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.141 Mobile Safari/537.36', 'token_generate', 'New token for timnasu19', '2026-06-02 04:45:45'),
(217, 10, '0d8339d0f00502e4b666c4385b58a05dbd631535e902f5194497a0c22f599a43', '81.177.173.135', 'Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.141 Mobile Safari/537.36', 'stream_access', 'Format: m3u | IP: 81.177.173.135', '2026-06-02 04:45:45');
INSERT INTO `access_logs` (`id`, `user_id`, `token`, `ip_address`, `user_agent`, `action`, `detail`, `created_at`) VALUES
(218, 10, 'b9d952edf412d2d39612f52b6cfa4b761476fd748213c80391d77a85caf4425c', '114.10.16.42', 'OTT Navigator/1.7.0.2.4 (Linux;Android 12; en; zrihkw)', 'token_generate', 'New token for timnasu19', '2026-06-02 05:52:04'),
(219, 10, 'b9d952edf412d2d39612f52b6cfa4b761476fd748213c80391d77a85caf4425c', '114.10.16.42', 'OTT Navigator/1.7.0.2.4 (Linux;Android 12; en; zrihkw)', 'stream_access', 'Format: m3u | IP: 114.10.16.42', '2026-06-02 05:52:04'),
(220, 10, '0717c94fd4725c056a7d4af0fee4ed588799d82bedbe347bbac7f45da8fe125a', '157.20.207.171', 'TWF1TWFsaW5nS2FoS29udG9s==', 'token_generate', 'New token for timnasu19', '2026-06-02 09:25:22'),
(221, 10, '0717c94fd4725c056a7d4af0fee4ed588799d82bedbe347bbac7f45da8fe125a', '157.20.207.171', 'TWF1TWFsaW5nS2FoS29udG9s==', 'stream_access', 'Format: m3u | IP: 157.20.207.171', '2026-06-02 09:25:22'),
(222, 10, '49d5212b5745556f77fcebe403971e3e21bd174b7532f28c0bbb1e58a484ee09', '103.131.18.167', 'OTT Navigator/1.7.0.2.4 (Linux;Android 12; en; zrihkw)', 'token_generate', 'New token for timnasu19', '2026-06-02 09:33:25'),
(223, 10, '49d5212b5745556f77fcebe403971e3e21bd174b7532f28c0bbb1e58a484ee09', '103.131.18.167', 'OTT Navigator/1.7.0.2.4 (Linux;Android 12; en; zrihkw)', 'stream_access', 'Format: m3u | IP: 103.131.18.167', '2026-06-02 09:33:25'),
(224, 10, '1ddfb77f581ab544e4d4ca8f0a376c73b230c17a6518880708cbf5d88ef3a54c', '2402:8780:1063:b25:b1d5:7b2a:db8e:3bcc', 'OTT Navigator/1.7.0.2.4 (Linux;Android 10; in; hixduh)', 'token_generate', 'New token for timnasu19', '2026-06-02 11:25:13'),
(225, 10, '1ddfb77f581ab544e4d4ca8f0a376c73b230c17a6518880708cbf5d88ef3a54c', '2402:8780:1063:b25:b1d5:7b2a:db8e:3bcc', 'OTT Navigator/1.7.0.2.4 (Linux;Android 10; in; hixduh)', 'stream_access', 'Format: m3u | IP: 2402:8780:1063:b25:b1d5:7b2a:db8e:3bcc', '2026-06-02 11:25:13'),
(226, 10, 'f6f41fc69837ffc1f0cdb6ba6193901ff8b2ba00e0c5c628a39a17f666f81dca', '66.249.77.1', 'Googlebot-Image/1.0', 'token_generate', 'New token for timnasu19', '2026-06-02 12:05:25'),
(227, 10, 'f6f41fc69837ffc1f0cdb6ba6193901ff8b2ba00e0c5c628a39a17f666f81dca', '66.249.77.1', 'Googlebot-Image/1.0', 'stream_access', 'Format: m3u | IP: 66.249.77.1', '2026-06-02 12:05:25'),
(228, 10, 'ab1fe663fb677803036659d2054681f0af8a8dafbc81bd6305323ae4caf7abcf', '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'token_generate', 'New token for timnasu19', '2026-06-02 13:10:03'),
(229, 10, 'ab1fe663fb677803036659d2054681f0af8a8dafbc81bd6305323ae4caf7abcf', '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 64.120.92.26', '2026-06-02 13:10:03'),
(230, 10, 'ab1fe663fb677803036659d2054681f0af8a8dafbc81bd6305323ae4caf7abcf', '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 64.120.92.26', '2026-06-02 13:10:17'),
(231, 10, 'ab1fe663fb677803036659d2054681f0af8a8dafbc81bd6305323ae4caf7abcf', '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 64.120.92.26', '2026-06-02 13:17:10'),
(232, 10, 'ab1fe663fb677803036659d2054681f0af8a8dafbc81bd6305323ae4caf7abcf', '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 64.120.92.26', '2026-06-02 13:17:23'),
(233, 10, 'a7af329edd67413b7c0b898627ec3b78bffd114863243d9c14f70432d7551326', '2404:c0:7020:8f46:981e:faff:feb3:7544', 'TWF1TWFsaW5nS2FoS29udG9s==', 'token_generate', 'New token for timnasu19', '2026-06-02 13:17:58'),
(234, 10, 'a7af329edd67413b7c0b898627ec3b78bffd114863243d9c14f70432d7551326', '2404:c0:7020:8f46:981e:faff:feb3:7544', 'TWF1TWFsaW5nS2FoS29udG9s==', 'stream_access', 'Format: m3u | IP: 2404:c0:7020:8f46:981e:faff:feb3:7544', '2026-06-02 13:17:58'),
(235, 10, 'ab1fe663fb677803036659d2054681f0af8a8dafbc81bd6305323ae4caf7abcf', '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 64.120.92.26', '2026-06-02 13:19:52'),
(236, 1, NULL, '64.120.92.26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'login', 'Login berhasil', '2026-06-02 13:22:42'),
(237, 10, 'ab1fe663fb677803036659d2054681f0af8a8dafbc81bd6305323ae4caf7abcf', '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 64.120.92.26', '2026-06-02 13:22:58'),
(238, 10, 'a7af329edd67413b7c0b898627ec3b78bffd114863243d9c14f70432d7551326', '2404:c0:7020:8f46:981e:faff:feb3:7544', 'TWF1TWFsaW5nS2FoS29udG9s==', 'stream_access', 'Format: m3u | IP: 2404:c0:7020:8f46:981e:faff:feb3:7544', '2026-06-02 13:23:01'),
(239, 10, 'a7af329edd67413b7c0b898627ec3b78bffd114863243d9c14f70432d7551326', '2404:c0:7020:8f46:981e:faff:feb3:7544', 'TWF1TWFsaW5nS2FoS29udG9s==', 'stream_access', 'Format: m3u | IP: 2404:c0:7020:8f46:981e:faff:feb3:7544', '2026-06-02 13:23:06'),
(240, 10, 'a7af329edd67413b7c0b898627ec3b78bffd114863243d9c14f70432d7551326', '2404:c0:7020:8f46:981e:faff:feb3:7544', 'TWF1TWFsaW5nS2FoS29udG9s==', 'stream_access', 'Format: m3u | IP: 2404:c0:7020:8f46:981e:faff:feb3:7544', '2026-06-02 13:24:46'),
(241, 10, '12a60fee9ffd88abe393f5f7089b95e511edd86edfa3967abe9bdbff92c918a0', '64.120.92.26', 'VLC/3.0.23 LibVLC/3.0.23', 'token_generate', 'New token for timnasu19', '2026-06-02 13:26:02'),
(242, 10, '12a60fee9ffd88abe393f5f7089b95e511edd86edfa3967abe9bdbff92c918a0', '64.120.92.26', 'VLC/3.0.23 LibVLC/3.0.23', 'stream_access', 'Format: m3u | IP: 64.120.92.26', '2026-06-02 13:26:02'),
(243, 10, 'aa08995738ed32c5309ece4f0fc48d9a9fb4f315c0d3d4a9fd587d0c6b63b1ff', '2404:c0:7020:8f46:981e:faff:feb3:7544', 'Reqable/3.1.2', 'token_generate', 'New token for timnasu19', '2026-06-02 13:27:37'),
(244, 10, 'aa08995738ed32c5309ece4f0fc48d9a9fb4f315c0d3d4a9fd587d0c6b63b1ff', '2404:c0:7020:8f46:981e:faff:feb3:7544', 'Reqable/3.1.2', 'stream_access', 'Format: m3u | IP: 2404:c0:7020:8f46:981e:faff:feb3:7544', '2026-06-02 13:27:37'),
(245, 10, '5ba2da5395cc89bea12146a742c9fdf59c1bb735742f4dd13bf3ef381390296e', '64.120.92.26', 'TiviMate/5.2.0 (Android 13)', 'token_generate', 'New token for timnasu19', '2026-06-02 13:32:43'),
(246, 10, '5ba2da5395cc89bea12146a742c9fdf59c1bb735742f4dd13bf3ef381390296e', '64.120.92.26', 'TiviMate/5.2.0 (Android 13)', 'stream_access', 'Format: m3u | IP: 64.120.92.26', '2026-06-02 13:32:43'),
(247, 10, 'a7af329edd67413b7c0b898627ec3b78bffd114863243d9c14f70432d7551326', '2404:c0:7020:8f46:981e:faff:feb3:7544', 'TWF1TWFsaW5nS2FoS29udG9s==', 'stream_access', 'Format: m3u | IP: 2404:c0:7020:8f46:981e:faff:feb3:7544', '2026-06-02 13:34:55'),
(248, 10, 'a7af329edd67413b7c0b898627ec3b78bffd114863243d9c14f70432d7551326', '2404:c0:7020:8f46:981e:faff:feb3:7544', 'TWF1TWFsaW5nS2FoS29udG9s==', 'stream_access', 'Format: m3u | IP: 2404:c0:7020:8f46:981e:faff:feb3:7544', '2026-06-02 13:59:22'),
(249, 1, NULL, '64.120.92.26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'login', 'Login berhasil', '2026-06-02 14:05:40'),
(250, 10, '01222c373b4c10d63eb296dc151ed5bd50a0e4276c0f0e59007ab7d17e45b9e1', '157.20.207.171', 'TWF1TWFsaW5nS2FoS29udG9s==', 'token_generate', 'New token for timnasu19', '2026-06-02 15:27:37'),
(251, 10, '01222c373b4c10d63eb296dc151ed5bd50a0e4276c0f0e59007ab7d17e45b9e1', '157.20.207.171', 'TWF1TWFsaW5nS2FoS29udG9s==', 'stream_access', 'Format: m3u | IP: 157.20.207.171', '2026-06-02 15:27:37'),
(252, 10, 'f82f8f5d21600b127873ab72671b5556fe5f20e4c895b9ade1c40a4b5e4b1be8', '157.20.207.171', 'OTT Navigator/1.7.5.1 (Linux;Android 16; id; 1ok2h6w)', 'token_generate', 'New token for timnasu19', '2026-06-02 15:36:44'),
(253, 10, 'f82f8f5d21600b127873ab72671b5556fe5f20e4c895b9ade1c40a4b5e4b1be8', '157.20.207.171', 'OTT Navigator/1.7.5.1 (Linux;Android 16; id; 1ok2h6w)', 'stream_access', 'Format: m3u | IP: 157.20.207.171', '2026-06-02 15:36:44'),
(254, 10, '872dbad203feedc5143e0594fa0fd8a849b8ca9cdde75cb247c2686061017ea2', '157.20.207.171', 'Reqable/3.1.2', 'token_generate', 'New token for timnasu19', '2026-06-02 15:38:16'),
(255, 10, '872dbad203feedc5143e0594fa0fd8a849b8ca9cdde75cb247c2686061017ea2', '157.20.207.171', 'Reqable/3.1.2', 'stream_access', 'Format: m3u | IP: 157.20.207.171', '2026-06-02 15:38:16'),
(256, 10, 'f82f8f5d21600b127873ab72671b5556fe5f20e4c895b9ade1c40a4b5e4b1be8', '157.20.207.171', 'OTT Navigator/1.7.5.1 (Linux;Android 16; id; 1ok2h6w)', 'stream_access', 'Format: m3u | IP: 157.20.207.171', '2026-06-02 15:39:39'),
(257, 1, NULL, '64.120.92.26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'login', 'Login berhasil', '2026-06-02 15:46:47'),
(258, 10, '01222c373b4c10d63eb296dc151ed5bd50a0e4276c0f0e59007ab7d17e45b9e1', '157.20.207.171', 'TWF1TWFsaW5nS2FoS29udG9s==', 'stream_access', 'Format: m3u | IP: 157.20.207.171', '2026-06-02 15:50:37'),
(259, 10, 'ed12de679e4a1c877c6283b77d16f1211a46468c846124348fdf290dd369e74f', '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'token_generate', 'New token for timnasu19', '2026-06-02 15:51:12'),
(260, 10, 'ed12de679e4a1c877c6283b77d16f1211a46468c846124348fdf290dd369e74f', '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 64.120.92.26', '2026-06-02 15:51:12'),
(261, 10, 'ed12de679e4a1c877c6283b77d16f1211a46468c846124348fdf290dd369e74f', '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 64.120.92.26', '2026-06-02 15:51:14'),
(262, 10, 'ed12de679e4a1c877c6283b77d16f1211a46468c846124348fdf290dd369e74f', '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 64.120.92.26', '2026-06-02 15:51:34'),
(263, 10, '18d9305cb6f1e47008daba5bb066b42dc75b0944cb77b874e4e54e68a49ff5ab', '202.162.204.223', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'token_generate', 'New token for timnasu19', '2026-06-02 15:58:37'),
(264, 10, '18d9305cb6f1e47008daba5bb066b42dc75b0944cb77b874e4e54e68a49ff5ab', '202.162.204.223', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'Format: m3u | IP: 202.162.204.223', '2026-06-02 15:58:37'),
(265, 10, 'be6e4ed3fd8b47a406820e1c53394fd3127e774560cf7de4f3f51f3b0d6e639e', '202.162.204.223', 'TiviMate/5.2.0 (Android 13)', 'token_generate', 'New token for timnasu19', '2026-06-02 16:02:46'),
(266, 10, 'be6e4ed3fd8b47a406820e1c53394fd3127e774560cf7de4f3f51f3b0d6e639e', '202.162.204.223', 'TiviMate/5.2.0 (Android 13)', 'stream_access', 'Format: m3u | IP: 202.162.204.223', '2026-06-02 16:02:46'),
(267, 8, 'd083bb0cf82d601493120680e8e021347614ac075364fc0be5b80571bf1ddcd6', '64.120.92.26', 'vlf', 'token_generate', 'New token for tipistream', '2026-06-02 16:07:18'),
(268, 8, 'd083bb0cf82d601493120680e8e021347614ac075364fc0be5b80571bf1ddcd6', '64.120.92.26', 'vlf', 'stream_access', 'Format: m3u | IP: 64.120.92.26', '2026-06-02 16:07:19'),
(269, 8, 'd083bb0cf82d601493120680e8e021347614ac075364fc0be5b80571bf1ddcd6', '64.120.92.26', 'vlf', 'stream_access', 'Format: m3u | IP: 64.120.92.26', '2026-06-02 16:13:44'),
(270, 10, '44ec5e56168bf9a14baa80ef9b570c868525ef7a1c2f3d49ce724fbe4041b8e7', '182.3.100.64', 'OTT Navigator/1.7.3.3 (Linux;Android 16; in; xzugrx)', 'token_generate', 'New token for timnasu19', '2026-06-02 16:31:55'),
(271, 10, '44ec5e56168bf9a14baa80ef9b570c868525ef7a1c2f3d49ce724fbe4041b8e7', '182.3.100.64', 'OTT Navigator/1.7.3.3 (Linux;Android 16; in; xzugrx)', 'stream_access', 'Format: m3u | IP: 182.3.100.64', '2026-06-02 16:31:55'),
(272, 1, NULL, '64.120.92.26', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36', 'login', 'Login berhasil', '2026-06-02 16:34:54'),
(273, 10, 'b0c3b42f88bf33471036dd9a71e41e7977b7af0bba0e7da67618256144f8cbd4', '36.68.52.58', 'OTT Navigator/1.7.0.2.4 (Linux;Android 12; en; zrihkw)', 'token_generate', 'New token for timnasu19', '2026-06-02 18:30:28'),
(274, 10, 'b0c3b42f88bf33471036dd9a71e41e7977b7af0bba0e7da67618256144f8cbd4', '36.68.52.58', 'OTT Navigator/1.7.0.2.4 (Linux;Android 12; en; zrihkw)', 'stream_access', 'Format: m3u | IP: 36.68.52.58', '2026-06-02 18:30:28'),
(275, 10, 'b0c3b42f88bf33471036dd9a71e41e7977b7af0bba0e7da67618256144f8cbd4', '36.68.52.58', 'OTT Navigator/1.7.0.2.4 (Linux;Android 12; en; zrihkw)', 'stream_access', 'Format: m3u | IP: 36.68.52.58', '2026-06-02 19:45:45'),
(276, 10, '9f90733ced642c6f036dd48050e15c28d232560056abc0699669e78952998f87', '2404:c0:d001:7e74:55c8:64ae:64e2:efc1', 'OTT Navigator/1.7.3.2 (Linux;Android 13; in; 1ng6ygt)', 'token_generate', 'New token for timnasu19', '2026-06-02 19:53:11'),
(277, 10, '9f90733ced642c6f036dd48050e15c28d232560056abc0699669e78952998f87', '2404:c0:d001:7e74:55c8:64ae:64e2:efc1', 'OTT Navigator/1.7.3.2 (Linux;Android 13; in; 1ng6ygt)', 'stream_access', 'Format: m3u | IP: 2404:c0:d001:7e74:55c8:64ae:64e2:efc1', '2026-06-02 19:53:11'),
(278, 10, '27f8794ed190c06a731d9447e7528cbb22e9657cda7ad21bb5b9251e73586b33', '2404:c0:be01:4486:d8b8:4dda:41dd:79ad', 'OTT Navigator/1.7.0.2.4 (Linux;Android 14; in; aey067)', 'token_generate', 'New token for timnasu19', '2026-06-02 20:08:15'),
(279, 10, '27f8794ed190c06a731d9447e7528cbb22e9657cda7ad21bb5b9251e73586b33', '2404:c0:be01:4486:d8b8:4dda:41dd:79ad', 'OTT Navigator/1.7.0.2.4 (Linux;Android 14; in; aey067)', 'stream_access', 'Format: m3u | IP: 2404:c0:be01:4486:d8b8:4dda:41dd:79ad', '2026-06-02 20:08:15'),
(280, 10, '27f8794ed190c06a731d9447e7528cbb22e9657cda7ad21bb5b9251e73586b33', '2404:c0:be01:4486:d8b8:4dda:41dd:79ad', 'OTT Navigator/1.7.0.2.4 (Linux;Android 14; in; aey067)', 'stream_access', 'Format: m3u | IP: 2404:c0:be01:4486:d8b8:4dda:41dd:79ad', '2026-06-02 20:11:58'),
(281, 10, '92cc26251fc5c8fa8107ca37eab3203cacbe89a3b0068019adcf836e662f01a6', '2404:8000:1055:7b8:9bd0:279c:9750:fef1', 'OTT Navigator/1.7.4.1 (Linux;Android 16; id; 3r6195)', 'token_generate', 'New token for timnasu19', '2026-06-03 01:42:22'),
(282, 10, '92cc26251fc5c8fa8107ca37eab3203cacbe89a3b0068019adcf836e662f01a6', '2404:8000:1055:7b8:9bd0:279c:9750:fef1', 'OTT Navigator/1.7.4.1 (Linux;Android 16; id; 3r6195)', 'stream_access', 'Format: m3u | IP: 2404:8000:1055:7b8:9bd0:279c:9750:fef1', '2026-06-03 01:42:22'),
(283, 10, '657b80676b6bd306e225bd776331e0aa87a3559c4c50fc3c955b44420c697fb1', '103.131.18.167', 'OTT Navigator/1.7.0.2.4 (Linux;Android 12; en; zrihkw)', 'token_generate', 'New token for timnasu19', '2026-06-03 09:26:31'),
(284, 10, '657b80676b6bd306e225bd776331e0aa87a3559c4c50fc3c955b44420c697fb1', '103.131.18.167', 'OTT Navigator/1.7.0.2.4 (Linux;Android 12; en; zrihkw)', 'stream_access', 'Format: m3u | IP: 103.131.18.167', '2026-06-03 09:26:31'),
(285, 10, '42dfc183ed7036df3ae167144fd3131fc6e7ce8c425d7c0e502473ecbe8259e3', '2404:c0:d001:7e74:55c8:64ae:64e2:efc1', 'OTT Navigator/1.7.3.2 (Linux;Android 13; in; 1ng6ygt)', 'token_generate', 'New token for timnasu19', '2026-06-03 09:26:42'),
(286, 10, '42dfc183ed7036df3ae167144fd3131fc6e7ce8c425d7c0e502473ecbe8259e3', '2404:c0:d001:7e74:55c8:64ae:64e2:efc1', 'OTT Navigator/1.7.3.2 (Linux;Android 13; in; 1ng6ygt)', 'stream_access', 'Format: m3u | IP: 2404:c0:d001:7e74:55c8:64ae:64e2:efc1', '2026-06-03 09:26:42'),
(287, 10, '7788432c7d2ab2addc1c284644e9253c947263af6b7b96471d08c00057154e46', '2a03:2880:11ff:5b::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'token_generate', 'New token for timnasu19', '2026-06-03 10:20:33'),
(288, 10, '7788432c7d2ab2addc1c284644e9253c947263af6b7b96471d08c00057154e46', '2a03:2880:11ff:5b::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'stream_access', 'Format: m3u | IP: 2a03:2880:11ff:5b::', '2026-06-03 10:20:33'),
(289, 10, 'eb96798afd27ef30b1daa83816b5643e6e7fe3d8a77ae86873c95c97bf93c8a1', '162.19.116.19', 'Mozilla/5.0 (Windows NT 6.2; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1667.0 Safari/537.36', 'token_generate', 'New token for timnasu19', '2026-06-03 10:36:00'),
(290, 10, 'eb96798afd27ef30b1daa83816b5643e6e7fe3d8a77ae86873c95c97bf93c8a1', '162.19.116.19', 'Mozilla/5.0 (Windows NT 6.2; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1667.0 Safari/537.36', 'stream_access', 'Format: m3u | IP: 162.19.116.19', '2026-06-03 10:36:00'),
(291, 10, '42dfc183ed7036df3ae167144fd3131fc6e7ce8c425d7c0e502473ecbe8259e3', '2404:c0:d001:7e74:55c8:64ae:64e2:efc1', 'OTT Navigator/1.7.3.2 (Linux;Android 13; in; 1ng6ygt)', 'stream_access', 'Format: m3u | IP: 2404:c0:d001:7e74:55c8:64ae:64e2:efc1', '2026-06-03 13:55:25'),
(292, 10, '9a5a7bf187f9677d31dfe2b5fd56b2e5c953e8f01f44a0095e1cfa1831497d6c', '110.138.182.183', 'OTT Navigator/1.7.4.1 (Linux;Android 16; id; 3r6195)', 'token_generate', 'New token for timnasu19', '2026-06-03 14:31:22'),
(293, 10, '9a5a7bf187f9677d31dfe2b5fd56b2e5c953e8f01f44a0095e1cfa1831497d6c', '110.138.182.183', 'OTT Navigator/1.7.4.1 (Linux;Android 16; id; 3r6195)', 'stream_access', 'Format: m3u | IP: 110.138.182.183', '2026-06-03 14:31:22'),
(294, 10, '2ba0896f5a969d2fbec15a3dc1b3d59fe43e4b4597ca65f677e74094bd8dae74', '2404:c0:be02:1355:72ac:7ed7:deb6:1838', 'OTT Navigator/1.7.0.2.4 (Linux;Android 14; in; aey067)', 'token_generate', 'New token for timnasu19', '2026-06-03 19:30:30'),
(295, 10, '2ba0896f5a969d2fbec15a3dc1b3d59fe43e4b4597ca65f677e74094bd8dae74', '2404:c0:be02:1355:72ac:7ed7:deb6:1838', 'OTT Navigator/1.7.0.2.4 (Linux;Android 14; in; aey067)', 'stream_access', 'Format: m3u | IP: 2404:c0:be02:1355:72ac:7ed7:deb6:1838', '2026-06-03 19:30:30'),
(296, 10, '2ba0896f5a969d2fbec15a3dc1b3d59fe43e4b4597ca65f677e74094bd8dae74', '2404:c0:be02:1355:72ac:7ed7:deb6:1838', 'OTT Navigator/1.7.0.2.4 (Linux;Android 14; in; aey067)', 'stream_access', 'Format: m3u | IP: 2404:c0:be02:1355:72ac:7ed7:deb6:1838', '2026-06-03 19:30:36'),
(297, 10, '2ba0896f5a969d2fbec15a3dc1b3d59fe43e4b4597ca65f677e74094bd8dae74', '2404:c0:be02:1355:72ac:7ed7:deb6:1838', 'OTT Navigator/1.7.0.2.4 (Linux;Android 14; in; aey067)', 'stream_access', 'Format: m3u | IP: 2404:c0:be02:1355:72ac:7ed7:deb6:1838', '2026-06-03 19:30:41'),
(298, 10, '2ba0896f5a969d2fbec15a3dc1b3d59fe43e4b4597ca65f677e74094bd8dae74', '2404:c0:be02:1355:72ac:7ed7:deb6:1838', 'OTT Navigator/1.7.0.2.4 (Linux;Android 14; in; aey067)', 'stream_access', 'Format: m3u | IP: 2404:c0:be02:1355:72ac:7ed7:deb6:1838', '2026-06-03 20:01:27'),
(299, 10, 'ab6e973bb166516e903e0f24cfe0a62d8185ab4e58741107c7e1ce7d780458a7', '2402:8780:1063:b25:117e:2783:a7ba:7655', 'OTT Navigator/1.7.0.2.4 (Linux;Android 10; in; hixduh)', 'token_generate', 'New token for timnasu19', '2026-06-03 20:51:26'),
(300, 10, 'ab6e973bb166516e903e0f24cfe0a62d8185ab4e58741107c7e1ce7d780458a7', '2402:8780:1063:b25:117e:2783:a7ba:7655', 'OTT Navigator/1.7.0.2.4 (Linux;Android 10; in; hixduh)', 'stream_access', 'Format: m3u | IP: 2402:8780:1063:b25:117e:2783:a7ba:7655', '2026-06-03 20:51:26'),
(301, 10, '124995122e1537c0bec23ae2d8c8591e013cffa37e37850c8cce8ec146fd53fb', '2404:c0:d001:f265:55c8:64ae:64e2:efc1', 'OTT Navigator/1.7.3.2 (Linux;Android 13; in; 1ng6ygt)', 'token_generate', 'New token for timnasu19', '2026-06-04 09:06:56'),
(302, 10, '124995122e1537c0bec23ae2d8c8591e013cffa37e37850c8cce8ec146fd53fb', '2404:c0:d001:f265:55c8:64ae:64e2:efc1', 'OTT Navigator/1.7.3.2 (Linux;Android 13; in; 1ng6ygt)', 'stream_access', 'Format: m3u | IP: 2404:c0:d001:f265:55c8:64ae:64e2:efc1', '2026-06-04 09:06:56'),
(303, 10, '124995122e1537c0bec23ae2d8c8591e013cffa37e37850c8cce8ec146fd53fb', '2404:c0:d001:f265:55c8:64ae:64e2:efc1', 'OTT Navigator/1.7.3.2 (Linux;Android 13; in; 1ng6ygt)', 'stream_access', 'Format: m3u | IP: 2404:c0:d001:f265:55c8:64ae:64e2:efc1', '2026-06-04 09:53:54'),
(304, 1, NULL, '64.120.92.26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'login', 'Login berhasil', '2026-06-04 13:49:35'),
(305, 10, 'd00817e951f48cbfdd238e937188605f2fc8cd9dbb7aa260ae544b48773ec4ac', '64.120.92.26', 'ngasal aja', 'token_generate', 'New token for timnasu19', '2026-06-04 13:52:01'),
(306, 10, 'd00817e951f48cbfdd238e937188605f2fc8cd9dbb7aa260ae544b48773ec4ac', '64.120.92.26', 'ngasal aja', 'stream_access', 'Format: m3u | IP: 64.120.92.26', '2026-06-04 13:52:01'),
(307, 1, NULL, '64.120.92.26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'login', 'Login berhasil', '2026-06-04 14:03:22'),
(308, NULL, NULL, '64.120.92.26', 'ngasal aja', 'blocked', 'Browser blocked | Score:160 | UA:ngasal aja | Reasons:Accept:text/html,Accept:complex,Sec-Fetch-Mode present,Sec-Fetch-Dest present,Sec-Fetch-Site present,Upgrade-Insecure-Requests present,UA suspicious short', '2026-06-04 14:03:52'),
(309, 10, 'ac06a6e56c237554986b9418d565e9d84e9f8955ad2be1e57ad8c2aa7745bf5b', '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'token_generate', 'New token for timnasu19 | Score:-80', '2026-06-04 14:04:06'),
(310, 10, 'ac06a6e56c237554986b9418d565e9d84e9f8955ad2be1e57ad8c2aa7745bf5b', '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'IP:64.120.92.26 | UA:OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', '2026-06-04 14:04:06'),
(311, 10, 'ac06a6e56c237554986b9418d565e9d84e9f8955ad2be1e57ad8c2aa7745bf5b', '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'IP:64.120.92.26 | UA:OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', '2026-06-04 14:04:19'),
(312, 10, 'ac06a6e56c237554986b9418d565e9d84e9f8955ad2be1e57ad8c2aa7745bf5b', '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'IP:64.120.92.26 | UA:OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', '2026-06-04 14:04:38'),
(313, NULL, NULL, '64.120.92.26', 'ngasal aja', 'blocked', 'Browser blocked | Score:160 | UA:ngasal aja | Reasons:Accept:text/html,Accept:complex,Sec-Fetch-Mode present,Sec-Fetch-Dest present,Sec-Fetch-Site present,Upgrade-Insecure-Requests present,UA suspicious short', '2026-06-04 14:08:04'),
(314, NULL, NULL, '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'blocked', 'Browser blocked | Score:65 | UA:OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7) | Reasons:Accept:text/html,Accept:complex,Sec-Fetch-Mode present,Sec-Fetch-Dest present,Sec-Fetch-Site present,Upgrade-Insecure-Requests present,Known player: ott navigator', '2026-06-04 14:08:21'),
(315, NULL, NULL, '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'blocked', 'Browser blocked | Score:65 | UA:OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7) | Reasons:Accept:text/html,Accept:complex,Sec-Fetch-Mode present,Sec-Fetch-Dest present,Sec-Fetch-Site present,Upgrade-Insecure-Requests present,Known player: ott navigator', '2026-06-04 14:09:41'),
(316, NULL, NULL, '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'blocked', 'Browser blocked | Score:65 | UA:OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7) | Reasons:Accept:text/html,Accept:complex,Sec-Fetch-Mode present,Sec-Fetch-Dest present,Sec-Fetch-Site present,Upgrade-Insecure-Requests present,Known player: ott navigator', '2026-06-04 14:10:10'),
(317, NULL, NULL, '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'blocked', 'Browser blocked | Score:65 | UA:OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7) | Reasons:Accept:text/html,Accept:complex,Sec-Fetch-Mode present,Sec-Fetch-Dest present,Sec-Fetch-Site present,Upgrade-Insecure-Requests present,Known player: ott navigator', '2026-06-04 14:10:15'),
(318, 10, 'ac06a6e56c237554986b9418d565e9d84e9f8955ad2be1e57ad8c2aa7745bf5b', '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'IP:64.120.92.26 | UA:OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', '2026-06-04 14:10:44'),
(319, 10, 'ac06a6e56c237554986b9418d565e9d84e9f8955ad2be1e57ad8c2aa7745bf5b', '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'IP:64.120.92.26 | UA:OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', '2026-06-04 14:10:46'),
(320, NULL, NULL, '157.20.207.171', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36', 'blocked', 'Browser blocked | Score:225 | UA:Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome | Reasons:Accept:text/html,Accept:complex,Sec-Fetch-Mode present,Sec-Fetch-Dest present,Sec-Fetch-Site present,Upgrade-Insecure-Requests present,Sec-CH-UA present (Chrome hint),Sec-CH-UA-Mobile present,Sec-CH-UA-Platform present,UA sig: Mozilla/5.0,UA sig: AppleWebKit,UA sig: like Gecko,UA sig: KHTML', '2026-06-04 14:37:07'),
(321, 10, '1e6416b2068773a6066601469624715591aeb26961080af7f7d1d2a16eb926a0', '103.181.254.196', 'OTT Navigator/1.7.4.1 (OPPO CPH2669;Android 16; c634bd1)', 'token_generate', 'New token for timnasu19 | Score:-80', '2026-06-04 14:38:32'),
(322, 10, '1e6416b2068773a6066601469624715591aeb26961080af7f7d1d2a16eb926a0', '103.181.254.196', 'OTT Navigator/1.7.4.1 (OPPO CPH2669;Android 16; c634bd1)', 'stream_access', 'IP:103.181.254.196 | UA:OTT Navigator/1.7.4.1 (OPPO CPH2669;Android 16; c634bd1)', '2026-06-04 14:38:32'),
(323, 10, '932e40f5fe85cc6fcfb06879f4b069712a0a97f5e92012e3aaf694f97520e490', '103.181.254.196', 'Reqable/3.1.2', 'token_generate', 'New token for timnasu19 | Score:0', '2026-06-04 14:38:54'),
(324, 10, '932e40f5fe85cc6fcfb06879f4b069712a0a97f5e92012e3aaf694f97520e490', '103.181.254.196', 'Reqable/3.1.2', 'stream_access', 'IP:103.181.254.196 | UA:Reqable/3.1.2', '2026-06-04 14:38:54'),
(325, 10, '8c831faa30729755f41455a0be03525414c84d626176ed7277baf1ebf1de22f4', '103.181.254.196', 'TWF1TWFsaW5nS2FoS29udG9s==', 'token_generate', 'New token for timnasu19 | Score:15', '2026-06-04 15:39:00'),
(326, 10, '8c831faa30729755f41455a0be03525414c84d626176ed7277baf1ebf1de22f4', '103.181.254.196', 'TWF1TWFsaW5nS2FoS29udG9s==', 'stream_access', 'IP:103.181.254.196 | UA:TWF1TWFsaW5nS2FoS29udG9s==', '2026-06-04 15:39:00'),
(327, 10, '8c831faa30729755f41455a0be03525414c84d626176ed7277baf1ebf1de22f4', '103.181.254.196', 'TWF1TWFsaW5nS2FoS29udG9s==', 'stream_access', 'IP:103.181.254.196 | UA:TWF1TWFsaW5nS2FoS29udG9s==', '2026-06-04 15:39:02'),
(328, 10, 'd7514ea5ed9b08ac83c4d1f3503017f1bd563df3502255f7c5b9e10453dfbf41', '103.181.254.196', 'OTT Navigator/1.7.5.1 (Linux;Android 16; id; 1ok2h6w)', 'token_generate', 'New token for timnasu19 | Score:-80', '2026-06-04 16:02:19'),
(329, 10, 'd7514ea5ed9b08ac83c4d1f3503017f1bd563df3502255f7c5b9e10453dfbf41', '103.181.254.196', 'OTT Navigator/1.7.5.1 (Linux;Android 16; id; 1ok2h6w)', 'stream_access', 'IP:103.181.254.196 | UA:OTT Navigator/1.7.5.1 (Linux;Android 16; id; 1ok2h6w)', '2026-06-04 16:02:20'),
(330, 10, 'd7514ea5ed9b08ac83c4d1f3503017f1bd563df3502255f7c5b9e10453dfbf41', '103.181.254.196', 'OTT Navigator/1.7.5.1 (Linux;Android 16; id; 1ok2h6w)', 'stream_access', 'IP:103.181.254.196 | UA:OTT Navigator/1.7.5.1 (Linux;Android 16; id; 1ok2h6w)', '2026-06-04 16:29:57'),
(331, 10, NULL, '103.181.254.196', 'OTT Navigator/1.7.5.1 (Linux;Android 16; id; 1ok2h6w)', 'expired', 'User expired: timnasu19', '2026-06-04 17:13:57'),
(332, 10, NULL, '103.181.254.196', 'OTT Navigator/1.7.5.1 (Linux;Android 16; id; 1ok2h6w)', 'expired', 'User expired: timnasu19', '2026-06-04 17:14:04'),
(333, 10, NULL, '103.181.254.196', 'Reqable/3.1.2', 'expired', 'User expired: timnasu19', '2026-06-04 17:14:17'),
(334, 10, NULL, '103.181.254.196', 'Reqable/3.1.2', 'expired', 'User expired: timnasu19', '2026-06-04 17:14:21'),
(335, 1, NULL, '64.120.92.26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'login', 'Login berhasil', '2026-06-04 18:32:17'),
(336, NULL, NULL, '64.120.92.26', 'TWF1TWFsaW5nS2FoS29udG9s==', 'blocked', 'Browser blocked | Score:160 | UA:TWF1TWFsaW5nS2FoS29udG9s== | Reasons:Accept:text/html,Accept:complex,Sec-Fetch-Mode present,Sec-Fetch-Dest present,Sec-Fetch-Site present,Upgrade-Insecure-Requests present,UA suspicious short', '2026-06-04 18:35:54'),
(337, NULL, NULL, '64.120.92.26', 'Reqable/3.1.2', 'blocked', 'Browser blocked | Score:145 | UA:Reqable/3.1.2 | Reasons:Accept:text/html,Accept:complex,Sec-Fetch-Mode present,Sec-Fetch-Dest present,Sec-Fetch-Site present,Upgrade-Insecure-Requests present', '2026-06-04 18:36:30'),
(338, 10, '95273d23124669929d808ffb082f49f0c2156cd2fd5b56ba3d2c4a22e4d77245', '2a03:2880:15ff:40::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'token_generate', 'New token for timnasu19 | Score:0', '2026-06-04 18:40:18'),
(339, 10, '1781027317e8802317b14356b68c6b07c6cd56d828dfc391e8140b010b3c0cd9', '2a03:2880:9ff:60::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'token_generate', 'New token for timnasu19 | Score:0', '2026-06-04 18:40:18'),
(340, 10, 'd32c27a7218417a9f536dd051b3585b5840c319d1e80cfda5f731a67eb932205', '2a03:2880:15ff:4c::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'token_generate', 'New token for timnasu19 | Score:0', '2026-06-04 18:40:18'),
(341, 10, '95273d23124669929d808ffb082f49f0c2156cd2fd5b56ba3d2c4a22e4d77245', '2a03:2880:15ff:40::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'stream_access', 'IP:2a03:2880:15ff:40:: | UA:facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '2026-06-04 18:40:18'),
(342, 10, '1781027317e8802317b14356b68c6b07c6cd56d828dfc391e8140b010b3c0cd9', '2a03:2880:9ff:60::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'stream_access', 'IP:2a03:2880:9ff:60:: | UA:facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '2026-06-04 18:40:18'),
(343, 10, 'd32c27a7218417a9f536dd051b3585b5840c319d1e80cfda5f731a67eb932205', '2a03:2880:15ff:4c::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'stream_access', 'IP:2a03:2880:15ff:4c:: | UA:facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '2026-06-04 18:40:18'),
(344, NULL, NULL, '64.120.92.26', 'Mozilla/5.0 (Linux; Android 13; 21061110AG Build/TP1A.220624.014) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/149.0.7827.83 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/564.0.0.38.74;IABMV/1;]', 'blocked', 'Browser blocked | Score:225 | UA:Mozilla/5.0 (Linux; Android 13; 21061110AG Build/TP1A.220624.014) AppleWebKit/53 | Reasons:Accept:text/html,Accept:complex,Sec-Fetch-Mode present,Sec-Fetch-Dest present,Sec-Fetch-Site present,Upgrade-Insecure-Requests present,Sec-CH-UA present (Chrome hint),Sec-CH-UA-Mobile present,Sec-CH-UA-Platform present,UA sig: Mozilla/5.0,UA sig: AppleWebKit,UA sig: like Gecko,UA sig: KHTML', '2026-06-04 18:40:25'),
(345, NULL, NULL, '2404:8000:101c:8ff:21da:55e3:7c:3559', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/22H352 Safari/604.1 [FBAN/FBIOS;FBAV/564.0.0.57.71;FBBV/985438427;FBDV/iPhone14,5;FBMD/iPhone;FBSN/iOS;FBSV/18.7.8;FBSS/3;FBID/phone;FBLC/id_ID;FBOP/5;FBRV/0;IABMV/1]', 'blocked', 'Browser blocked | Score:145 | UA:Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHT | Reasons:Accept:text/html,Accept:complex,Sec-Fetch-Mode present,Sec-Fetch-Dest present,Sec-Fetch-Site present,UA sig: Mozilla/5.0,UA sig: AppleWebKit,UA sig: like Gecko,UA sig: KHTML', '2026-06-04 18:42:21'),
(346, NULL, NULL, '31.59.96.7', 'Mozilla/5.0 (Linux; Android 15; CPH2565 Build/AP3A.240617.008; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/148.0.7778.211 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/563.1.0.50.73;IABMV/1;]', 'blocked', 'Browser blocked | Score:225 | UA:Mozilla/5.0 (Linux; Android 15; CPH2565 Build/AP3A.240617.008; wv) AppleWebKit/5 | Reasons:Accept:text/html,Accept:complex,Sec-Fetch-Mode present,Sec-Fetch-Dest present,Sec-Fetch-Site present,Upgrade-Insecure-Requests present,Sec-CH-UA present (Chrome hint),Sec-CH-UA-Mobile present,Sec-CH-UA-Platform present,UA sig: Mozilla/5.0,UA sig: AppleWebKit,UA sig: like Gecko,UA sig: KHTML', '2026-06-04 18:44:24'),
(347, NULL, NULL, '43.229.254.80', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36', 'blocked', 'Browser blocked | Score:225 | UA:Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome | Reasons:Accept:text/html,Accept:complex,Sec-Fetch-Mode present,Sec-Fetch-Dest present,Sec-Fetch-Site present,Upgrade-Insecure-Requests present,Sec-CH-UA present (Chrome hint),Sec-CH-UA-Mobile present,Sec-CH-UA-Platform present,UA sig: Mozilla/5.0,UA sig: AppleWebKit,UA sig: like Gecko,UA sig: KHTML', '2026-06-04 18:45:39'),
(348, NULL, NULL, '43.229.254.80', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36', 'blocked', 'Browser blocked | Score:225 | UA:Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome | Reasons:Accept:text/html,Accept:complex,Sec-Fetch-Mode present,Sec-Fetch-Dest present,Sec-Fetch-Site present,Upgrade-Insecure-Requests present,Sec-CH-UA present (Chrome hint),Sec-CH-UA-Mobile present,Sec-CH-UA-Platform present,UA sig: Mozilla/5.0,UA sig: AppleWebKit,UA sig: like Gecko,UA sig: KHTML', '2026-06-04 18:45:56'),
(349, 10, 'd7514ea5ed9b08ac83c4d1f3503017f1bd563df3502255f7c5b9e10453dfbf41', '103.181.254.196', 'OTT Navigator/1.7.5.1 (Linux;Android 16; id; 1ok2h6w)', 'stream_access', 'IP:103.181.254.196 | UA:OTT Navigator/1.7.5.1 (Linux;Android 16; id; 1ok2h6w)', '2026-06-04 18:49:04'),
(350, 10, '258b7af9a4b8e3161d6799eb49deed021ca1b5a5505c612bf48b8e7da18e2603', '43.229.254.80', 'VLC/3.0.23 LibVLC/3.0.23', 'token_generate', 'New token for timnasu19 | Score:-80', '2026-06-04 18:49:06'),
(351, 10, '258b7af9a4b8e3161d6799eb49deed021ca1b5a5505c612bf48b8e7da18e2603', '43.229.254.80', 'VLC/3.0.23 LibVLC/3.0.23', 'stream_access', 'IP:43.229.254.80 | UA:VLC/3.0.23 LibVLC/3.0.23', '2026-06-04 18:49:06'),
(352, 10, '258b7af9a4b8e3161d6799eb49deed021ca1b5a5505c612bf48b8e7da18e2603', '43.229.254.80', 'VLC/3.0.23 LibVLC/3.0.23', 'stream_access', 'IP:43.229.254.80 | UA:VLC/3.0.23 LibVLC/3.0.23', '2026-06-04 18:49:10'),
(353, 10, '258b7af9a4b8e3161d6799eb49deed021ca1b5a5505c612bf48b8e7da18e2603', '43.229.254.80', 'VLC/3.0.23 LibVLC/3.0.23', 'stream_access', 'IP:43.229.254.80 | UA:VLC/3.0.23 LibVLC/3.0.23', '2026-06-04 18:49:19'),
(354, 10, 'e234031f556efb2e9def758767744dd8299d4dfa848866983bccd19895b4da6a', '157.20.207.171', 'Reqable/3.1.2', 'token_generate', 'New token for timnasu19 | Score:0', '2026-06-04 18:49:35'),
(355, 10, 'e234031f556efb2e9def758767744dd8299d4dfa848866983bccd19895b4da6a', '157.20.207.171', 'Reqable/3.1.2', 'stream_access', 'IP:157.20.207.171 | UA:Reqable/3.1.2', '2026-06-04 18:49:35'),
(356, 10, '258b7af9a4b8e3161d6799eb49deed021ca1b5a5505c612bf48b8e7da18e2603', '43.229.254.80', 'VLC/3.0.23 LibVLC/3.0.23', 'stream_access', 'IP:43.229.254.80 | UA:VLC/3.0.23 LibVLC/3.0.23', '2026-06-04 18:50:22'),
(357, 10, '90bfba5557f8abb989d4ff1c296637d2c8cb43c22df45f800e8ab802d942f077', '43.229.254.80', 'OTT Navigator/1.7.0.2.4 (Linux;Android 13; in; 1cvk7b7)', 'token_generate', 'New token for timnasu19 | Score:-80', '2026-06-04 18:51:45'),
(358, 10, '90bfba5557f8abb989d4ff1c296637d2c8cb43c22df45f800e8ab802d942f077', '43.229.254.80', 'OTT Navigator/1.7.0.2.4 (Linux;Android 13; in; 1cvk7b7)', 'stream_access', 'IP:43.229.254.80 | UA:OTT Navigator/1.7.0.2.4 (Linux;Android 13; in; 1cvk7b7)', '2026-06-04 18:51:45'),
(359, NULL, NULL, '202.125.100.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'blocked', 'Browser blocked | Score:228 | UA:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) | Reasons:Accept:text/html,Accept:complex,Sec-Fetch-Mode present,Sec-Fetch-Dest present,Sec-Fetch-Site present,Upgrade-Insecure-Requests present,Sec-CH-UA present (Chrome hint),Sec-CH-UA-Mobile present,Sec-CH-UA-Platform present,UA sig: Mozilla/5.0,UA sig: AppleWebKit,UA sig: like Gecko,UA sig: KHTML,UA sig: Windows NT', '2026-06-04 18:54:39'),
(360, NULL, NULL, '36.50.157.21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'blocked', 'Browser blocked | Score:228 | UA:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) | Reasons:Accept:text/html,Accept:complex,Sec-Fetch-Mode present,Sec-Fetch-Dest present,Sec-Fetch-Site present,Upgrade-Insecure-Requests present,Sec-CH-UA present (Chrome hint),Sec-CH-UA-Mobile present,Sec-CH-UA-Platform present,UA sig: Mozilla/5.0,UA sig: AppleWebKit,UA sig: like Gecko,UA sig: KHTML,UA sig: Windows NT', '2026-06-04 18:54:45'),
(361, 10, 'da23272a16cc4c187ac66a072f84a489682749ce13ba820dbfed5cca91725f48', '202.125.100.63', 'VLC/3.0.21 LibVLC/3.0.21', 'token_generate', 'New token for timnasu19 | Score:-80', '2026-06-04 18:59:36'),
(362, 10, 'da23272a16cc4c187ac66a072f84a489682749ce13ba820dbfed5cca91725f48', '202.125.100.63', 'VLC/3.0.21 LibVLC/3.0.21', 'stream_access', 'IP:202.125.100.63 | UA:VLC/3.0.21 LibVLC/3.0.21', '2026-06-04 18:59:36'),
(363, 10, '70e5db88f9659537dbf4a181ae2ca6a189019dfd25629cdb41b0fc6ea14504f0', '31.186.87.211', 'Unknown', 'token_generate', 'New token for timnasu19 | Score:25', '2026-06-04 18:59:50'),
(364, 10, '70e5db88f9659537dbf4a181ae2ca6a189019dfd25629cdb41b0fc6ea14504f0', '31.186.87.211', 'Unknown', 'stream_access', 'IP:31.186.87.211 | UA:Unknown', '2026-06-04 18:59:50'),
(365, 10, '52a359076fabc3029fd2e288829db560304ed8202397e039566d15b4290dab16', '2402:8780:1063:b25:117e:2783:a7ba:7655', 'OTT Navigator/1.7.0.2.4 (Linux;Android 10; in; hixduh)', 'token_generate', 'New token for timnasu19 | Score:-80', '2026-06-04 19:00:01'),
(366, 10, '52a359076fabc3029fd2e288829db560304ed8202397e039566d15b4290dab16', '2402:8780:1063:b25:117e:2783:a7ba:7655', 'OTT Navigator/1.7.0.2.4 (Linux;Android 10; in; hixduh)', 'stream_access', 'IP:2402:8780:1063:b25:117e:2783:a7ba:7655 | UA:OTT Navigator/1.7.0.2.4 (Linux;Android 10; in; hixduh)', '2026-06-04 19:00:01'),
(367, 10, '54dba89b6b398e988c8cb59ede800b7c3780d70679fe24cf19e2e3068b801459', '39.194.4.20', 'WhatsApp/2.23.20.0', 'token_generate', 'New token for timnasu19 | Score:0', '2026-06-04 19:00:54'),
(368, 10, '54dba89b6b398e988c8cb59ede800b7c3780d70679fe24cf19e2e3068b801459', '39.194.4.20', 'WhatsApp/2.23.20.0', 'stream_access', 'IP:39.194.4.20 | UA:WhatsApp/2.23.20.0', '2026-06-04 19:00:55'),
(369, 10, 'da23272a16cc4c187ac66a072f84a489682749ce13ba820dbfed5cca91725f48', '202.125.100.63', 'VLC/3.0.21 LibVLC/3.0.21', 'stream_access', 'IP:202.125.100.63 | UA:VLC/3.0.21 LibVLC/3.0.21', '2026-06-04 19:01:17'),
(370, 10, '1dfc652b7ccaee75feec38e167ad0ed18908bf037df2ab6d765372efd68c7dc6', '39.194.4.20', 'WAKHAJI/3.1.559 (Linux; Android; access-denied-403)', 'token_generate', 'New token for timnasu19 | Score:0', '2026-06-04 19:01:40'),
(371, 10, '1dfc652b7ccaee75feec38e167ad0ed18908bf037df2ab6d765372efd68c7dc6', '39.194.4.20', 'WAKHAJI/3.1.559 (Linux; Android; access-denied-403)', 'stream_access', 'IP:39.194.4.20 | UA:WAKHAJI/3.1.559 (Linux; Android; access-denied-403)', '2026-06-04 19:01:41'),
(372, NULL, NULL, '103.13.204.86', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36', 'blocked', 'Browser blocked | Score:225 | UA:Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome | Reasons:Accept:text/html,Accept:complex,Sec-Fetch-Mode present,Sec-Fetch-Dest present,Sec-Fetch-Site present,Upgrade-Insecure-Requests present,Sec-CH-UA present (Chrome hint),Sec-CH-UA-Mobile present,Sec-CH-UA-Platform present,UA sig: Mozilla/5.0,UA sig: AppleWebKit,UA sig: like Gecko,UA sig: KHTML', '2026-06-04 19:04:01'),
(373, NULL, NULL, '2a03:2880:10ff:52::', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.6780.64 Safari/537.36', 'blocked', 'Browser blocked | Score:228 | UA:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) | Reasons:Accept:text/html,Accept:complex,Sec-Fetch-Mode present,Sec-Fetch-Dest present,Sec-Fetch-Site present,Upgrade-Insecure-Requests present,Sec-CH-UA present (Chrome hint),Sec-CH-UA-Mobile present,Sec-CH-UA-Platform present,UA sig: Mozilla/5.0,UA sig: AppleWebKit,UA sig: like Gecko,UA sig: KHTML,UA sig: Windows NT', '2026-06-04 19:04:13'),
(374, 10, 'e9e7e7625709dba312baa9dc15d7a347c87f417d3674edcbd3743aca496554f5', '2a03:2880:9ff:61::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'token_generate', 'New token for timnasu19 | Score:0', '2026-06-04 19:04:49'),
(375, 10, 'e9e7e7625709dba312baa9dc15d7a347c87f417d3674edcbd3743aca496554f5', '2a03:2880:9ff:61::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'stream_access', 'IP:2a03:2880:9ff:61:: | UA:facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '2026-06-04 19:04:49'),
(376, 10, '005b7331503f83318114ec5282ebc2bfcdf7edc6ba5f99a8bb3aa2bce3fea235', '2a03:2880:11ff:7::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'token_generate', 'New token for timnasu19 | Score:0', '2026-06-04 19:04:57'),
(377, 10, '005b7331503f83318114ec5282ebc2bfcdf7edc6ba5f99a8bb3aa2bce3fea235', '2a03:2880:11ff:7::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'stream_access', 'IP:2a03:2880:11ff:7:: | UA:facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '2026-06-04 19:04:57'),
(378, NULL, NULL, '2404:c0:a302:d638:88e3:fc6:dc41:bb77', 'Mozilla/5.0 (Linux; Android 14; Infinix X6882 Build/UP1A.231005.007) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/148.0.7778.211 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/563.1.0.50.73;IABMV/1;]', 'blocked', 'Browser blocked | Score:225 | UA:Mozilla/5.0 (Linux; Android 14; Infinix X6882 Build/UP1A.231005.007) AppleWebKit | Reasons:Accept:text/html,Accept:complex,Sec-Fetch-Mode present,Sec-Fetch-Dest present,Sec-Fetch-Site present,Upgrade-Insecure-Requests present,Sec-CH-UA present (Chrome hint),Sec-CH-UA-Mobile present,Sec-CH-UA-Platform present,UA sig: Mozilla/5.0,UA sig: AppleWebKit,UA sig: like Gecko,UA sig: KHTML', '2026-06-04 19:05:09'),
(379, NULL, NULL, '202.125.100.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'blocked', 'Browser blocked | Score:228 | UA:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) | Reasons:Accept:text/html,Accept:complex,Sec-Fetch-Mode present,Sec-Fetch-Dest present,Sec-Fetch-Site present,Upgrade-Insecure-Requests present,Sec-CH-UA present (Chrome hint),Sec-CH-UA-Mobile present,Sec-CH-UA-Platform present,UA sig: Mozilla/5.0,UA sig: AppleWebKit,UA sig: like Gecko,UA sig: KHTML,UA sig: Windows NT', '2026-06-04 19:05:57'),
(380, 10, 'f7fa483704db8df04251884092064f0b8901dd30693c937b8d9f25158e97a8d0', '103.13.204.86', 'OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', 'token_generate', 'New token for timnasu19 | Score:-80', '2026-06-04 19:08:24'),
(381, 10, 'f7fa483704db8df04251884092064f0b8901dd30693c937b8d9f25158e97a8d0', '103.13.204.86', 'OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', 'stream_access', 'IP:103.13.204.86 | UA:OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', '2026-06-04 19:08:24'),
(382, 10, '4fc4ef418bb64ce1f5ddd08d6f52da8a1ba3a2a396579411fc09912fb18abd90', '2402:8780:1063:b25:73b9:29ec:8aa6:6fad', 'OTT Navigator/1.7.0.2.4 (Linux;Android 10; in; hixduh)', 'token_generate', 'New token for timnasu19 | Score:-80', '2026-06-04 19:12:12'),
(383, 10, '4fc4ef418bb64ce1f5ddd08d6f52da8a1ba3a2a396579411fc09912fb18abd90', '2402:8780:1063:b25:73b9:29ec:8aa6:6fad', 'OTT Navigator/1.7.0.2.4 (Linux;Android 10; in; hixduh)', 'stream_access', 'IP:2402:8780:1063:b25:73b9:29ec:8aa6:6fad | UA:OTT Navigator/1.7.0.2.4 (Linux;Android 10; in; hixduh)', '2026-06-04 19:12:12'),
(384, NULL, NULL, '149.154.161.215', 'TelegramBot (like TwitterBot)', 'blocked', 'Browser blocked | Score:65 | UA:TelegramBot (like TwitterBot) | Reasons:Accept:text/html,Accept:complex,UA suspicious short', '2026-06-04 19:12:43'),
(385, 10, 'f7fa483704db8df04251884092064f0b8901dd30693c937b8d9f25158e97a8d0', '103.13.204.86', 'OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', 'stream_access', 'IP:103.13.204.86 | UA:OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', '2026-06-04 19:12:54'),
(386, NULL, NULL, '202.125.100.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'blocked', 'Browser blocked | Score:228 | UA:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) | Reasons:Accept:text/html,Accept:complex,Sec-Fetch-Mode present,Sec-Fetch-Dest present,Sec-Fetch-Site present,Upgrade-Insecure-Requests present,Sec-CH-UA present (Chrome hint),Sec-CH-UA-Mobile present,Sec-CH-UA-Platform present,UA sig: Mozilla/5.0,UA sig: AppleWebKit,UA sig: like Gecko,UA sig: KHTML,UA sig: Windows NT', '2026-06-04 19:14:04'),
(387, 10, 'c3181fef73294df7ad66e6191d5e09185e428963ad7882d1313c055f58fdb475', '202.125.100.63', 'OTT Navigator/1.7.0.2.4 (Linux;Android 9; in; 1etx4g7)', 'token_generate', 'New token for timnasu19 | Score:-80', '2026-06-04 19:14:15'),
(388, 10, 'c3181fef73294df7ad66e6191d5e09185e428963ad7882d1313c055f58fdb475', '202.125.100.63', 'OTT Navigator/1.7.0.2.4 (Linux;Android 9; in; 1etx4g7)', 'stream_access', 'IP:202.125.100.63 | UA:OTT Navigator/1.7.0.2.4 (Linux;Android 9; in; 1etx4g7)', '2026-06-04 19:14:15'),
(389, NULL, NULL, '103.181.254.196', 'Reqable/3.1.2', 'blocked', 'Blocked | Reason:Hard block: reqable | IP:103.181.254.196', '2026-06-04 19:14:33'),
(390, NULL, NULL, '103.181.254.196', 'Reqable/3.1.2', 'blocked', 'Blocked | Reason:Hard block: reqable | IP:103.181.254.196', '2026-06-04 19:14:36'),
(391, NULL, NULL, '103.181.254.196', 'Reqable/3.1.2', 'blocked', 'Blocked | Reason:Hard block: reqable | IP:103.181.254.196', '2026-06-04 19:15:41'),
(392, NULL, NULL, '157.20.207.171', 'Reqable/3.1.2', 'blocked', 'Blocked | Reason:Hard block: reqable | IP:157.20.207.171', '2026-06-04 19:16:03'),
(393, NULL, NULL, '157.20.207.171', 'Reqable/3.1.2', 'blocked', 'Blocked | Reason:Hard block: reqable | IP:157.20.207.171', '2026-06-04 19:16:04'),
(394, NULL, NULL, '149.154.161.200', 'TelegramBot (like TwitterBot)', 'blocked', 'Blocked | Reason:Accept: text/html (browser) | IP:149.154.161.200', '2026-06-04 19:18:38'),
(395, NULL, NULL, '2a03:2880:16ff:5b::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'blocked', 'Blocked | Reason:UA not in whitelist: facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php) | IP:2a03:2880:16ff:5b::', '2026-06-04 19:19:00'),
(396, NULL, NULL, '149.154.161.196', 'TelegramBot (like TwitterBot)', 'blocked', 'Blocked | Reason:Accept: text/html (browser) | IP:149.154.161.196', '2026-06-04 19:21:29'),
(397, 10, 'c3181fef73294df7ad66e6191d5e09185e428963ad7882d1313c055f58fdb475', '202.125.100.63', 'OTT Navigator/1.7.0.2.4 (Linux;Android 9; in; 1etx4g7)', 'stream_access', 'IP:202.125.100.63 | UA:OTT Navigator/1.7.0.2.4 (Linux;Android 9; in; 1etx4g7)', '2026-06-04 19:21:38'),
(398, 10, 'ac06a6e56c237554986b9418d565e9d84e9f8955ad2be1e57ad8c2aa7745bf5b', '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'IP:64.120.92.26 | UA:OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', '2026-06-04 19:24:54'),
(399, 10, 'ac06a6e56c237554986b9418d565e9d84e9f8955ad2be1e57ad8c2aa7745bf5b', '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'IP:64.120.92.26 | UA:OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', '2026-06-04 19:24:55'),
(400, NULL, NULL, '157.20.207.171', 'gbscell_aipitv_app', 'blocked', 'Blocked | Reason:UA not in whitelist: gbscell_aipitv_app | IP:157.20.207.171', '2026-06-04 19:25:10'),
(401, 10, NULL, '64.120.92.26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'blocked', 'UA blocked | Browser headers (Sec-Fetch/CH-UA) | IP:64.120.92.26', '2026-06-04 19:29:11'),
(402, 10, NULL, '64.120.92.26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'blocked', 'UA blocked | Browser headers (Sec-Fetch/CH-UA) | IP:64.120.92.26', '2026-06-04 19:29:33'),
(403, 10, NULL, '149.154.161.214', 'TelegramBot (like TwitterBot)', 'blocked', 'UA blocked | Accept: text/html | IP:149.154.161.214', '2026-06-04 19:29:54'),
(404, 10, 'ac06a6e56c237554986b9418d565e9d84e9f8955ad2be1e57ad8c2aa7745bf5b', '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'IP:64.120.92.26 | UA:OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', '2026-06-04 19:30:26'),
(405, 10, NULL, '103.13.204.86', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36', 'blocked', 'UA blocked | Browser headers (Sec-Fetch/CH-UA) | IP:103.13.204.86', '2026-06-04 19:30:31'),
(406, 10, 'f7fa483704db8df04251884092064f0b8901dd30693c937b8d9f25158e97a8d0', '103.13.204.86', 'OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', 'stream_access', 'IP:103.13.204.86 | UA:OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', '2026-06-04 19:31:26'),
(407, 10, 'f7fa483704db8df04251884092064f0b8901dd30693c937b8d9f25158e97a8d0', '103.13.204.86', 'OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', 'stream_access', 'IP:103.13.204.86 | UA:OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', '2026-06-04 19:31:40');
INSERT INTO `access_logs` (`id`, `user_id`, `token`, `ip_address`, `user_agent`, `action`, `detail`, `created_at`) VALUES
(408, 10, 'f7fa483704db8df04251884092064f0b8901dd30693c937b8d9f25158e97a8d0', '103.13.204.86', 'OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', 'stream_access', 'IP:103.13.204.86 | UA:OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', '2026-06-04 19:31:43'),
(409, 10, 'f7fa483704db8df04251884092064f0b8901dd30693c937b8d9f25158e97a8d0', '103.13.204.86', 'OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', 'stream_access', 'IP:103.13.204.86 | UA:OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', '2026-06-04 19:31:52'),
(410, 10, 'f7fa483704db8df04251884092064f0b8901dd30693c937b8d9f25158e97a8d0', '103.13.204.86', 'OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', 'stream_access', 'IP:103.13.204.86 | UA:OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', '2026-06-04 19:31:52'),
(411, 10, 'f7fa483704db8df04251884092064f0b8901dd30693c937b8d9f25158e97a8d0', '103.13.204.86', 'OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', 'stream_access', 'IP:103.13.204.86 | UA:OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', '2026-06-04 19:31:52'),
(412, 10, 'f7fa483704db8df04251884092064f0b8901dd30693c937b8d9f25158e97a8d0', '103.13.204.86', 'OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', 'stream_access', 'IP:103.13.204.86 | UA:OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', '2026-06-04 19:31:52'),
(413, 10, 'f7fa483704db8df04251884092064f0b8901dd30693c937b8d9f25158e97a8d0', '103.13.204.86', 'OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', 'stream_access', 'IP:103.13.204.86 | UA:OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', '2026-06-04 19:31:52'),
(414, 10, 'f7fa483704db8df04251884092064f0b8901dd30693c937b8d9f25158e97a8d0', '103.13.204.86', 'OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', 'stream_access', 'IP:103.13.204.86 | UA:OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', '2026-06-04 19:31:53'),
(415, 10, 'f7fa483704db8df04251884092064f0b8901dd30693c937b8d9f25158e97a8d0', '103.13.204.86', 'OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', 'stream_access', 'IP:103.13.204.86 | UA:OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', '2026-06-04 19:31:53'),
(416, 10, 'f7fa483704db8df04251884092064f0b8901dd30693c937b8d9f25158e97a8d0', '103.13.204.86', 'OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', 'stream_access', 'IP:103.13.204.86 | UA:OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', '2026-06-04 19:31:53'),
(417, 10, 'f7fa483704db8df04251884092064f0b8901dd30693c937b8d9f25158e97a8d0', '103.13.204.86', 'OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', 'stream_access', 'IP:103.13.204.86 | UA:OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', '2026-06-04 19:31:53'),
(418, 10, 'f7fa483704db8df04251884092064f0b8901dd30693c937b8d9f25158e97a8d0', '103.13.204.86', 'OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', 'stream_access', 'IP:103.13.204.86 | UA:OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', '2026-06-04 19:31:53'),
(419, 10, 'f7fa483704db8df04251884092064f0b8901dd30693c937b8d9f25158e97a8d0', '103.13.204.86', 'OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', 'stream_access', 'IP:103.13.204.86 | UA:OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', '2026-06-04 19:31:53'),
(420, 10, 'f7fa483704db8df04251884092064f0b8901dd30693c937b8d9f25158e97a8d0', '103.13.204.86', 'OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', 'stream_access', 'IP:103.13.204.86 | UA:OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', '2026-06-04 19:31:53'),
(421, 10, 'f7fa483704db8df04251884092064f0b8901dd30693c937b8d9f25158e97a8d0', '103.13.204.86', 'OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', 'stream_access', 'IP:103.13.204.86 | UA:OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', '2026-06-04 19:31:53'),
(422, 10, 'f7fa483704db8df04251884092064f0b8901dd30693c937b8d9f25158e97a8d0', '103.13.204.86', 'OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', 'stream_access', 'IP:103.13.204.86 | UA:OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', '2026-06-04 19:31:53'),
(423, 10, 'f7fa483704db8df04251884092064f0b8901dd30693c937b8d9f25158e97a8d0', '103.13.204.86', 'OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', 'stream_access', 'IP:103.13.204.86 | UA:OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', '2026-06-04 19:31:53'),
(424, 10, 'f7fa483704db8df04251884092064f0b8901dd30693c937b8d9f25158e97a8d0', '103.13.204.86', 'OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', 'stream_access', 'IP:103.13.204.86 | UA:OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', '2026-06-04 19:31:53'),
(425, 10, 'f7fa483704db8df04251884092064f0b8901dd30693c937b8d9f25158e97a8d0', '103.13.204.86', 'OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', 'stream_access', 'IP:103.13.204.86 | UA:OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', '2026-06-04 19:31:53'),
(426, 10, 'f7fa483704db8df04251884092064f0b8901dd30693c937b8d9f25158e97a8d0', '103.13.204.86', 'OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', 'stream_access', 'IP:103.13.204.86 | UA:OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', '2026-06-04 19:31:53'),
(427, 10, 'f7fa483704db8df04251884092064f0b8901dd30693c937b8d9f25158e97a8d0', '103.13.204.86', 'OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', 'stream_access', 'IP:103.13.204.86 | UA:OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', '2026-06-04 19:31:53'),
(428, 10, 'f7fa483704db8df04251884092064f0b8901dd30693c937b8d9f25158e97a8d0', '103.13.204.86', 'OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', 'stream_access', 'IP:103.13.204.86 | UA:OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', '2026-06-04 19:31:53'),
(429, 10, 'f7fa483704db8df04251884092064f0b8901dd30693c937b8d9f25158e97a8d0', '103.13.204.86', 'OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', 'stream_access', 'IP:103.13.204.86 | UA:OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', '2026-06-04 19:34:28'),
(430, 10, NULL, '103.13.204.86', 'OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', 'blocked', 'Key salah | IP:103.13.204.86 | UA:OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', '2026-06-04 19:35:07'),
(431, 10, NULL, '2a03:2880:11ff:4a::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'blocked', 'UA blocked | UA not in whitelist: facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php) | IP:2a03:2880:11ff:4a::', '2026-06-04 19:39:05'),
(432, 10, NULL, '2a03:2880:7ff:46::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'blocked', 'UA blocked | UA not in whitelist: facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php) | IP:2a03:2880:7ff:46::', '2026-06-04 19:39:06'),
(433, 10, NULL, '2a03:2880:15ff:43::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'blocked', 'UA blocked | UA not in whitelist: facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php) | IP:2a03:2880:15ff:43::', '2026-06-04 19:39:07'),
(434, 10, NULL, '2a03:2880:10ff:9::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'blocked', 'UA blocked | UA not in whitelist: facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php) | IP:2a03:2880:10ff:9::', '2026-06-04 19:39:07'),
(435, 10, NULL, '2a03:2880:18ff:50::', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'blocked', 'UA blocked | Accept: text/html | IP:2a03:2880:18ff:50::', '2026-06-04 19:39:07'),
(436, 10, NULL, '2a03:2880:22ff:44::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'blocked', 'UA blocked | UA not in whitelist: facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php) | IP:2a03:2880:22ff:44::', '2026-06-04 19:39:41'),
(437, 10, NULL, '2a03:2880:10ff:7::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'blocked', 'UA blocked | UA not in whitelist: facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php) | IP:2a03:2880:10ff:7::', '2026-06-04 19:39:49'),
(438, 10, '1b971f8b4f234c412055c2b21e14603fee7850cbca26002f35851edea6390095', '202.162.204.214', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'token_generate', 'New token: timnasu19', '2026-06-04 19:39:51'),
(439, 10, '1b971f8b4f234c412055c2b21e14603fee7850cbca26002f35851edea6390095', '202.162.204.214', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'IP:202.162.204.214 | UA:OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', '2026-06-04 19:39:52'),
(440, 10, '1b971f8b4f234c412055c2b21e14603fee7850cbca26002f35851edea6390095', '202.162.204.214', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'IP:202.162.204.214 | UA:OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', '2026-06-04 19:39:53'),
(441, 10, NULL, '182.9.161.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'blocked', 'UA blocked | Browser headers (Sec-Fetch/CH-UA) | IP:182.9.161.248', '2026-06-04 19:40:24'),
(442, 10, NULL, '182.9.161.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'blocked', 'UA blocked | Accept: text/html | IP:182.9.161.248', '2026-06-04 19:40:26'),
(443, 10, NULL, '182.9.161.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'blocked', 'UA blocked | Accept: text/html | IP:182.9.161.248', '2026-06-04 19:40:26'),
(444, 10, NULL, '182.9.161.248', 'Reqable/3.0.38', 'blocked', 'UA blocked | Hard block: reqable | IP:182.9.161.248', '2026-06-04 19:40:45'),
(445, 10, NULL, '182.9.161.248', 'Reqable/3.0.38', 'blocked', 'UA blocked | Hard block: reqable | IP:182.9.161.248', '2026-06-04 19:41:00'),
(446, 10, NULL, '64.227.21.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'blocked', 'UA blocked | UA not in whitelist: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) | IP:64.227.21.251', '2026-06-04 19:41:09'),
(447, 10, NULL, '64.227.21.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'blocked', 'UA blocked | UA not in whitelist: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) | IP:64.227.21.251', '2026-06-04 19:41:13'),
(448, 10, NULL, '64.227.21.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'blocked', 'UA blocked | UA not in whitelist: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) | IP:64.227.21.251', '2026-06-04 19:41:16'),
(449, 10, '83e3dbff500437ba1e8ca6039a321c6b353946eb6d53cacdb9197db417b5154c', '2400:9800:660:36ca:1:0:71fd:de60', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'token_generate', 'New token: timnasu19', '2026-06-04 19:46:21'),
(450, 10, '83e3dbff500437ba1e8ca6039a321c6b353946eb6d53cacdb9197db417b5154c', '2400:9800:660:36ca:1:0:71fd:de60', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'IP:2400:9800:660:36ca:1:0:71fd:de60 | UA:OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', '2026-06-04 19:46:21'),
(451, 10, '83e3dbff500437ba1e8ca6039a321c6b353946eb6d53cacdb9197db417b5154c', '2400:9800:660:36ca:1:0:71fd:de60', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'IP:2400:9800:660:36ca:1:0:71fd:de60 | UA:OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', '2026-06-04 19:46:25'),
(452, 10, '83e3dbff500437ba1e8ca6039a321c6b353946eb6d53cacdb9197db417b5154c', '2400:9800:660:36ca:1:0:71fd:de60', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'IP:2400:9800:660:36ca:1:0:71fd:de60 | UA:OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', '2026-06-04 19:46:27'),
(453, 10, NULL, '2400:9800:660:36ca:1:0:71fd:de60', 'WhatsApp/2.23.20.0', 'blocked', 'UA blocked | UA not in whitelist: WhatsApp/2.23.20.0 | IP:2400:9800:660:36ca:1:0:71fd:de60', '2026-06-04 19:49:31'),
(454, 10, NULL, '2400:9800:660:36ca:1:0:71fd:de60', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Mobile Safari/537.36', 'blocked', 'UA blocked | Browser headers (Sec-Fetch/CH-UA) | IP:2400:9800:660:36ca:1:0:71fd:de60', '2026-06-04 19:49:35'),
(455, 10, NULL, '125.162.216.112', 'Mozilla/5.0 (Linux; Android 16; I2505 Build/BP2A.250605.031.A3_T1_V000L1) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/148.0.7778.211 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/563.1.0.50.73;IABMV/1;]', 'blocked', 'UA blocked | Accept: text/html | IP:125.162.216.112', '2026-06-04 19:55:58'),
(456, 10, 'b3c5e381fd1cb07c3fef064f2824c573081ba0e98f4c9e90518115c006c6f24c', '125.162.216.112', 'Dalvik/2.1.0 (Linux; U; Android 16; I2505 Build/BP2A.250605.031.A3_T1_V000L1)', 'token_generate', 'New token: timnasu19', '2026-06-04 19:58:12'),
(457, 10, 'b3c5e381fd1cb07c3fef064f2824c573081ba0e98f4c9e90518115c006c6f24c', '125.162.216.112', 'Dalvik/2.1.0 (Linux; U; Android 16; I2505 Build/BP2A.250605.031.A3_T1_V000L1)', 'stream_access', 'IP:125.162.216.112 | UA:Dalvik/2.1.0 (Linux; U; Android 16; I2505 Build/BP2A.250605.031.A3_T1_V000L1)', '2026-06-04 19:58:12'),
(458, 10, 'ac06a6e56c237554986b9418d565e9d84e9f8955ad2be1e57ad8c2aa7745bf5b', '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'IP:64.120.92.26 | UA:OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', '2026-06-04 20:00:02'),
(459, 10, 'ac06a6e56c237554986b9418d565e9d84e9f8955ad2be1e57ad8c2aa7745bf5b', '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', 'stream_access', 'IP:64.120.92.26 | UA:OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', '2026-06-04 20:00:03'),
(460, 10, NULL, '114.125.248.28', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Mobile Safari/537.36', 'blocked', 'UA blocked | Browser headers (Sec-Fetch/CH-UA) | IP:114.125.248.28', '2026-06-04 20:07:53'),
(461, 10, 'aed4cb7b1881fc842d8384f758c74af56bc7a735b519b7967f4f98d8fb962322', '2404:8000:1055:7b8:6725:2ad:b8ab:d188', 'OTT Navigator/1.7.4.1 (Linux;Android 16; id; 3r6195)', 'token_generate', 'New token: timnasu19', '2026-06-04 20:10:47'),
(462, 10, 'aed4cb7b1881fc842d8384f758c74af56bc7a735b519b7967f4f98d8fb962322', '2404:8000:1055:7b8:6725:2ad:b8ab:d188', 'OTT Navigator/1.7.4.1 (Linux;Android 16; id; 3r6195)', 'stream_access', 'IP:2404:8000:1055:7b8:6725:2ad:b8ab:d188 | UA:OTT Navigator/1.7.4.1 (Linux;Android 16; id; 3r6195)', '2026-06-04 20:10:48'),
(463, 10, NULL, '114.125.244.180', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Mobile Safari/537.36', 'blocked', 'UA blocked | Browser headers (Sec-Fetch/CH-UA) | IP:114.125.244.180', '2026-06-04 20:11:19'),
(464, 10, NULL, '114.125.244.180', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Mobile Safari/537.36', 'blocked', 'UA blocked | Browser headers (Sec-Fetch/CH-UA) | IP:114.125.244.180', '2026-06-04 20:11:25'),
(465, 10, '8dbcf44025efca014b31c03793c15bb75c8970c438ac313744f14df18894499f', '125.162.216.112', 'OTT Navigator/1.7.5.1 (Linux;Android 16; id; ery7dq)', 'token_generate', 'New token: timnasu19', '2026-06-04 20:16:23'),
(466, 10, '8dbcf44025efca014b31c03793c15bb75c8970c438ac313744f14df18894499f', '125.162.216.112', 'OTT Navigator/1.7.5.1 (Linux;Android 16; id; ery7dq)', 'stream_access', 'IP:125.162.216.112 | UA:OTT Navigator/1.7.5.1 (Linux;Android 16; id; ery7dq)', '2026-06-04 20:16:23'),
(467, 10, '8dbcf44025efca014b31c03793c15bb75c8970c438ac313744f14df18894499f', '125.162.216.112', 'OTT Navigator/1.7.5.1 (Linux;Android 16; id; ery7dq)', 'stream_access', 'IP:125.162.216.112 | UA:OTT Navigator/1.7.5.1 (Linux;Android 16; id; ery7dq)', '2026-06-04 20:16:30'),
(468, 10, '8dbcf44025efca014b31c03793c15bb75c8970c438ac313744f14df18894499f', '125.162.216.112', 'OTT Navigator/1.7.5.1 (Linux;Android 16; id; ery7dq)', 'stream_access', 'IP:125.162.216.112 | UA:OTT Navigator/1.7.5.1 (Linux;Android 16; id; ery7dq)', '2026-06-04 20:16:48'),
(469, 10, '8dbcf44025efca014b31c03793c15bb75c8970c438ac313744f14df18894499f', '125.162.216.112', 'OTT Navigator/1.7.5.1 (Linux;Android 16; id; ery7dq)', 'stream_access', 'IP:125.162.216.112 | UA:OTT Navigator/1.7.5.1 (Linux;Android 16; id; ery7dq)', '2026-06-04 20:16:58'),
(470, 10, '8dbcf44025efca014b31c03793c15bb75c8970c438ac313744f14df18894499f', '125.162.216.112', 'OTT Navigator/1.7.5.1 (Linux;Android 16; id; ery7dq)', 'stream_access', 'IP:125.162.216.112 | UA:OTT Navigator/1.7.5.1 (Linux;Android 16; id; ery7dq)', '2026-06-04 20:17:23'),
(471, 10, '8dbcf44025efca014b31c03793c15bb75c8970c438ac313744f14df18894499f', '125.162.216.112', 'OTT Navigator/1.7.5.1 (Linux;Android 16; id; ery7dq)', 'stream_access', 'IP:125.162.216.112 | UA:OTT Navigator/1.7.5.1 (Linux;Android 16; id; ery7dq)', '2026-06-04 20:17:29'),
(472, 10, '8dbcf44025efca014b31c03793c15bb75c8970c438ac313744f14df18894499f', '125.162.216.112', 'OTT Navigator/1.7.5.1 (Linux;Android 16; id; ery7dq)', 'stream_access', 'IP:125.162.216.112 | UA:OTT Navigator/1.7.5.1 (Linux;Android 16; id; ery7dq)', '2026-06-04 20:17:51'),
(473, 10, '49fe5475413312f843a4d013c0cfab4b94fb9544ea04ebe6b0867a1154513dd5', '125.162.216.112', 'OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 1noq7h4)', 'token_generate', 'New token: timnasu19', '2026-06-04 20:19:38'),
(474, 10, '49fe5475413312f843a4d013c0cfab4b94fb9544ea04ebe6b0867a1154513dd5', '125.162.216.112', 'OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 1noq7h4)', 'stream_access', 'IP:125.162.216.112 | UA:OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 1noq7h4)', '2026-06-04 20:19:38'),
(475, 10, NULL, '2404:c0:c204:fe5e:c09e:4a40:bdb3:7bec', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0', 'blocked', 'UA blocked | Browser headers (Sec-Fetch/CH-UA) | IP:2404:c0:c204:fe5e:c09e:4a40:bdb3:7bec', '2026-06-04 20:28:32'),
(476, 10, NULL, '114.10.10.65', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36', 'blocked', 'UA blocked | Browser headers (Sec-Fetch/CH-UA) | IP:114.10.10.65', '2026-06-04 20:48:02'),
(477, 10, 'a4bdeb81bbcbda709c0afb2c60fc5b7101efd6c7ad2523a60811b98a4369afc7', '114.10.10.65', 'okhttp/4.12.0', 'token_generate', 'New token: timnasu19', '2026-06-04 20:49:19'),
(478, 10, 'a4bdeb81bbcbda709c0afb2c60fc5b7101efd6c7ad2523a60811b98a4369afc7', '114.10.10.65', 'okhttp/4.12.0', 'stream_access', 'IP:114.10.10.65 | UA:okhttp/4.12.0', '2026-06-04 20:49:19'),
(479, 10, 'a4bdeb81bbcbda709c0afb2c60fc5b7101efd6c7ad2523a60811b98a4369afc7', '114.10.10.65', 'okhttp/4.12.0', 'stream_access', 'IP:114.10.10.65 | UA:okhttp/4.12.0', '2026-06-04 20:49:20'),
(480, 10, NULL, '2404:c0:1470::6c7e:6ccd', 'OTT Player/1.2 (Linux;Android 13; in; hqv9mc)', 'blocked', 'UA blocked | UA not in whitelist: OTT Player/1.2 (Linux;Android 13; in; hqv9mc) | IP:2404:c0:1470::6c7e:6ccd', '2026-06-04 20:53:15'),
(481, 10, '4f6fdc6180e01f1afa2a78723b2edd23b3da6da073a3744dbed72ca18e2d917f', '2404:c0:1470::6c7e:6ccd', 'MXPlayer/1.94.4 (Linux; Android 13; in-ID; Infinix X6528B Build/X6528B-F069ZAaAbAcAdAeBgBhBi-T-OP-240201V383)', 'token_generate', 'New token: timnasu19', '2026-06-04 20:53:37'),
(482, 10, '4f6fdc6180e01f1afa2a78723b2edd23b3da6da073a3744dbed72ca18e2d917f', '2404:c0:1470::6c7e:6ccd', 'MXPlayer/1.94.4 (Linux; Android 13; in-ID; Infinix X6528B Build/X6528B-F069ZAaAbAcAdAeBgBhBi-T-OP-240201V383)', 'stream_access', 'IP:2404:c0:1470::6c7e:6ccd | UA:MXPlayer/1.94.4 (Linux; Android 13; in-ID; Infinix X6528B Build/X6528B-F069ZAaAb', '2026-06-04 20:53:37'),
(483, 10, '4f6fdc6180e01f1afa2a78723b2edd23b3da6da073a3744dbed72ca18e2d917f', '2404:c0:1470::6c7e:6ccd', 'MXPlayer/1.94.4 (Linux; Android 13; in-ID; Infinix X6528B Build/X6528B-F069ZAaAbAcAdAeBgBhBi-T-OP-240201V383)', 'stream_access', 'IP:2404:c0:1470::6c7e:6ccd | UA:MXPlayer/1.94.4 (Linux; Android 13; in-ID; Infinix X6528B Build/X6528B-F069ZAaAb', '2026-06-04 20:53:37'),
(484, 10, '4f6fdc6180e01f1afa2a78723b2edd23b3da6da073a3744dbed72ca18e2d917f', '2404:c0:1470::6c7e:6ccd', 'MXPlayer/1.94.4 (Linux; Android 13; in-ID; Infinix X6528B Build/X6528B-F069ZAaAbAcAdAeBgBhBi-T-OP-240201V383)', 'stream_access', 'IP:2404:c0:1470::6c7e:6ccd | UA:MXPlayer/1.94.4 (Linux; Android 13; in-ID; Infinix X6528B Build/X6528B-F069ZAaAb', '2026-06-04 20:53:38'),
(485, 10, NULL, '2a03:2880:10ff:52::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'blocked', 'UA blocked | UA not in whitelist: facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php) | IP:2a03:2880:10ff:52::', '2026-06-04 21:00:41'),
(486, 10, NULL, '2402:5680:99e9:66f4::1', 'Mozilla/5.0 (Linux; Android 14; TECNO KL5n Build/UP1A.231005.007) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/148.0.7778.175 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/562.0.0.51.73;IABMV/1;]', 'blocked', 'UA blocked | Accept: text/html | IP:2402:5680:99e9:66f4::1', '2026-06-04 21:12:18'),
(487, 10, NULL, '203.17.81.118', 'Mozilla/5.0 (Linux; Android 12; SM-A125F Build/SP1A.210812.016; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/148.0.7778.211 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/563.1.0.50.73;IABMV/1;]', 'blocked', 'UA blocked | Accept: text/html | IP:203.17.81.118', '2026-06-04 21:21:08');

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `role` enum('superadmin','admin','reseller') DEFAULT 'admin',
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `username`, `password`, `email`, `role`, `created_at`) VALUES
(1, 'admin', '$2y$10$XySXkSDTw2ZCTBSfx5dlSuDenQhOspEeP3X1jiIfC7wPgy.6smW/.', 'admin@localhost', 'superadmin', '2026-05-31 16:05:02'),
(2, 'Mimin', '$2y$10$XySXkSDTw2ZCTBSfx5dlSuDenQhOspEeP3X1jiIfC7wPgy.6smW/.', 'admin@localhost', 'superadmin', '2026-05-31 16:05:02');

-- --------------------------------------------------------

--
-- Table structure for table `blocked_ips`
--

CREATE TABLE `blocked_ips` (
  `id` int(11) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `blocked_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `blocked_ips`
--

INSERT INTO `blocked_ips` (`id`, `ip_address`, `reason`, `blocked_at`) VALUES
(7, '157.20.207.171', '', '2026-06-04 18:52:50'),
(8, '103.181.254.196', '', '2026-06-04 18:56:25');

-- --------------------------------------------------------

--
-- Table structure for table `device_sessions`
--

CREATE TABLE `device_sessions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `device_fingerprint` varchar(255) NOT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `last_seen` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `device_sessions`
--

INSERT INTO `device_sessions` (`id`, `user_id`, `device_fingerprint`, `ip_address`, `user_agent`, `last_seen`) VALUES
(8, 8, '6abeb24012fadcc2954c35babf63f0f0', '2402:a7c0:3003:104:1c00:5fff:fe00:f5', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', '2026-05-31 17:42:03'),
(9, 8, '558c7132fdb939616b526e69556cefaf', '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', '2026-06-01 16:56:25'),
(10, 10, '558c7132fdb939616b526e69556cefaf', '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', '2026-06-04 20:00:03'),
(11, 10, '7cd6a3e19714ae4205db6c22ed3d4a7e', '36.68.52.58', 'OTT Navigator/1.7.0.2.4 (Linux;Android 12; en; zrihkw)', '2026-06-02 19:45:45'),
(12, 10, '23dc0bbe897343721f9eb2d7595bcbef', '2402:8780:1063:b25:d9ca:2dd8:982e:e5e0', 'OTT Navigator/1.7.0.2.4 (Linux;Android 10; in; hixduh)', '2026-06-01 18:48:47'),
(13, 10, 'eba4560821ed90ae52fe6f3bb09c5e67', '182.9.49.127', 'OTT Navigator/1.7.3.1 (Linux;Android 11; in; 1mao2sq)', '2026-06-01 19:39:55'),
(14, 10, '7a3daf18ee1560ed93072035e945a443', '2a03:2880:24ff:43::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '2026-06-01 19:15:52'),
(15, 10, '938687704eff902a3621811b3c5523ac', '2a03:2880:18ff:47::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '2026-06-01 19:15:52'),
(16, 10, '007601ad3efbf1d8be7726232b97372c', '2a03:2880:10ff:5d::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '2026-06-01 19:15:52'),
(17, 10, '8b7c440c9a2cc34f243495aad015420e', '2a03:2880:10ff:46::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '2026-06-01 19:15:52'),
(18, 10, '40021bbc80c075fd207ed75fc34a33d9', '2a03:2880:15ff:44::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '2026-06-01 19:15:52'),
(19, 10, 'fe9049ddd1bc53eb3580821f611eb190', '2a03:2880:18ff:71::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '2026-06-01 19:15:52'),
(20, 10, '3056619c976b31b4919efe998cc81f8e', '2a03:2880:13ff:2::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '2026-06-01 19:15:53'),
(21, 10, '30ca2a42aaa8acd8b80982b4b284125b', '2a03:2880:2ff:5a::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '2026-06-01 19:16:21'),
(22, 10, '78f2806b3f00277e067a5f067333d09b', '2a03:2880:7ff:17::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '2026-06-01 19:16:21'),
(23, 10, 'e1fdb0a64015212bc33beed10b9ccdc0', '2a03:2880:11ff:5b::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '2026-06-03 10:20:32'),
(24, 10, '65752fbb16e12cbf847f400b20ab1d8e', '2a03:2880:25ff:46::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '2026-06-01 19:16:23'),
(25, 10, 'd4f74dd4f9ec584aa0c84ecd79677d6a', '2a03:2880:24ff:4a::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '2026-06-01 19:35:31'),
(26, 12, '4848dcc3708c35a3cbfa8f3429f5d2e1', '149.154.161.233', 'TelegramBot (like TwitterBot)', '2026-06-01 19:17:56'),
(27, 10, '011bbc2d10fe823684325997e7f11b48', '2404:c0:5b12:2413:5c6b:c7ff:c78b:b6cc', 'OTT Navigator/1.7.3.3 (Linux;Android 16; in; xzugrx)', '2026-06-01 19:22:31'),
(28, 12, '47a5b0010cdb4fbcad1e0ebd8fb8a104', '202.65.239.1', 'OTT Navigator/1.7.2.2 (Linux;Android 6.0.1; in; 1em86x2)', '2026-06-01 19:37:38'),
(29, 10, '2cc727e7c2c4a46be3741feb2723b01b', '31.186.87.211', 'Unknown', '2026-06-04 18:59:50'),
(30, 10, '5e8c1321f809fbcbacddace5e5b3f0ec', '182.2.205.160', 'WhatsApp/2.23.20.0', '2026-06-01 20:07:47'),
(31, 10, 'b1ef7b51e19544c42d8d9779d850224b', '182.9.49.127', 'OTT Navigator/1.7.1.6 (Linux;Android 11; in; 7bhc31)', '2026-06-01 19:42:42'),
(32, 10, '8580d11078f3c2c55b8b1078a35713b2', '103.126.87.176', 'WhatsApp/2.23.20.0', '2026-06-01 19:45:04'),
(33, 10, '7454ce5c236478542fb706665df30b17', '103.126.87.176', 'OTT TV/1.7.4.1 (Linux;Android 12; in; bezwvi)', '2026-06-01 19:48:22'),
(34, 10, '90ee3f53b9cd96b52c744570dbfe261d', '103.184.123.42', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', '2026-06-01 21:38:09'),
(35, 10, 'c0519d2a7b59e6a5c80a8a29dfc6941a', '2a03:2880:16ff:8::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '2026-06-01 19:52:42'),
(36, 10, '9c0ceb1deda08511b8ed03fd3caddf40', '114.125.238.125', 'OTT Navigator/1.7.3.3 (Linux;Android 15; id; 1c5wme0)', '2026-06-01 19:53:36'),
(37, 10, '586c8697d9d76b197252b26536cf8c61', '103.133.61.171', 'OTT Navigator/1.7.3.3 (Linux;Android 16; in; xzugrx)', '2026-06-01 20:19:32'),
(38, 10, '7f9435293c77551bd8cf942951f382e3', '2404:c0:701f:6699:d4f2:ddff:feb4:e423', 'Reqable/3.1.2', '2026-06-01 20:06:00'),
(39, 10, '28e963e98ba3f39a515cc596d17b8bd3', '182.5.136.169', 'VLC/3.0.22-rc1 LibVLC/3.0.22-rc1', '2026-06-01 20:10:55'),
(40, 10, 'a9fa0083136b5d621135675fe1a321f3', '2404:c0:701f:6699:d4f2:ddff:feb4:e423', 'TWF1TWFsaW5nS2FoS29udG9s==', '2026-06-01 20:10:24'),
(41, 10, '978096bce037ff71cefc9d1966597ee7', '157.20.207.171', 'TWF1TWFsaW5nS2FoS29udG9s==', '2026-06-02 15:50:37'),
(42, 10, '22d1c9c327b7ca2e34300b164a887c05', '64.233.173.236', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', '2026-06-01 20:11:19'),
(43, 10, 'e4e2547a9e9894fcb52996cb496b7743', '182.5.136.169', 'Dart/3.10 (dart:io)', '2026-06-01 20:12:48'),
(44, 10, '0d8cb895ca23cf3eaa61bae48b857a03', '182.5.136.169', 'Mozilla/5.0 (Linux; Android 15; TECNO CM7 Build/AP3A.240905.015.A2; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/148.0.7778.178 Mobile Safari/537.36', '2026-06-01 20:15:39'),
(45, 10, '186fb433c48434a066e616ceb62cc2d9', '2404:c0:5b12:2413:1:0:121a:4f97', 'OTT Navigator/1.7.3.3 (Linux;Android 16; in; xzugrx)', '2026-06-01 20:30:58'),
(46, 10, '698aef672c6d89dc08b7acf87f71766d', '2404:c0:d001:2be9:55c8:64ae:64e2:efc1', 'OTT Navigator/1.7.3.2 (Linux;Android 13; in; 1ng6ygt)', '2026-06-01 20:31:39'),
(47, 10, 'b367a5f23e388894cc48587ae2c9b82e', '2404:8000:1055:7b8:8c6:9b7:170c:9802', 'OTT Navigator/1.7.4.1 (Linux;Android 16; id; 3r6195)', '2026-06-01 21:10:07'),
(48, 10, '8e21f852989b715465749cb6738eb6b3', '2404:c0:960a:48d0:bffd:cf23:16a7:7722', 'OTT Navigator/1.7.1.6 (Linux;Android 15; in; a8ca3l)', '2026-06-01 21:16:54'),
(49, 10, '7371f69c16b89714519cd6f20f403795', '2402:8780:1063:b25:b1d5:7b2a:db8e:3bcc', 'OTT Navigator/1.7.0.2.4 (Linux;Android 10; in; hixduh)', '2026-06-02 11:25:13'),
(50, 10, 'f7c31681d671b040ba5a8f9b98a555e7', '149.102.133.54', 'OTT Navigator/1.7.5.1 (Linux;Android 14; en; cd5ff)', '2026-06-01 22:33:53'),
(51, 10, '69c9514a4eeb0e6904610c12abd4f50c', '202.65.225.230', 'OTT Player/1.7.4.1 (Linux;Android 16; id; 1sjeack)', '2026-06-01 22:34:47'),
(52, 10, '7a708017d8bf9eb2f626fe3a4f0cf5c5', '192.178.6.100', 'Googlebot-Image/1.0', '2026-06-01 22:34:47'),
(53, 10, '32f5f0cdcb7b7296341172d70f380f3d', '182.10.229.56', 'WhatsApp/2.23.20.0', '2026-06-01 23:10:09'),
(54, 10, 'dcf435894f1050482dd6976d6178acc3', '182.10.229.56', 'Reqable/3.0.38', '2026-06-01 23:10:26'),
(55, 10, 'a896a71e97879da11c91373971cba653', '103.102.12.65', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36', '2026-06-02 01:59:14'),
(56, 10, 'd40c5f521cc457313454d7bd189208f5', '103.102.12.65', 'OTT Navigator/1.7.5.1 (Linux;Android 12; in; 1qo2t0m)', '2026-06-02 03:47:40'),
(57, 10, '8c167a17b722fe28e417223412d41885', '81.177.173.135', 'Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.141 Mobile Safari/537.36', '2026-06-02 04:45:45'),
(58, 10, '3ff9313301c280877b3ad528c4114de0', '114.10.16.42', 'OTT Navigator/1.7.0.2.4 (Linux;Android 12; en; zrihkw)', '2026-06-02 05:52:04'),
(59, 10, 'f87a538a9b1c297b45167b4e853d4e9a', '103.131.18.167', 'OTT Navigator/1.7.0.2.4 (Linux;Android 12; en; zrihkw)', '2026-06-03 09:26:31'),
(60, 10, '6accc35d2bf0ef1a22b609966ee9bc3d', '66.249.77.1', 'Googlebot-Image/1.0', '2026-06-02 12:05:25'),
(61, 10, 'bb7455b5edfaa5b03209fc3f4990dd41', '2404:c0:7020:8f46:981e:faff:feb3:7544', 'TWF1TWFsaW5nS2FoS29udG9s==', '2026-06-02 13:59:22'),
(62, 10, '516e3b699f1819e0844f283cd9ccc83a', '64.120.92.26', 'VLC/3.0.23 LibVLC/3.0.23', '2026-06-02 13:26:02'),
(63, 10, '7d99445b6721eceaa466f367d9a80c80', '2404:c0:7020:8f46:981e:faff:feb3:7544', 'Reqable/3.1.2', '2026-06-02 13:27:37'),
(64, 10, 'c88e4031f51048c79bd2da1edc11e099', '64.120.92.26', 'TiviMate/5.2.0 (Android 13)', '2026-06-02 13:32:43'),
(65, 10, '4299c21380b8de5d871609ae1a00fe91', '157.20.207.171', 'OTT Navigator/1.7.5.1 (Linux;Android 16; id; 1ok2h6w)', '2026-06-02 15:39:39'),
(66, 10, '23a778cede84a248c70225ea57228e3e', '157.20.207.171', 'Reqable/3.1.2', '2026-06-04 18:49:35'),
(67, 10, '525937e63cf210c83eb5ac1a46f1ff18', '202.162.204.223', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', '2026-06-02 15:58:37'),
(68, 10, '157f289dc8a289fa3f53b8599b1edb6b', '202.162.204.223', 'TiviMate/5.2.0 (Android 13)', '2026-06-02 16:02:46'),
(69, 8, 'f5bea7ab7ea962a4d3b3d4b7a7106480', '64.120.92.26', 'vlf', '2026-06-02 16:13:44'),
(70, 10, '357bdd72c9e0420a375f7363aa3f3fe5', '182.3.100.64', 'OTT Navigator/1.7.3.3 (Linux;Android 16; in; xzugrx)', '2026-06-02 16:31:55'),
(71, 10, 'a20bae37af10aba1ea6175f73fbbc3de', '2404:c0:d001:7e74:55c8:64ae:64e2:efc1', 'OTT Navigator/1.7.3.2 (Linux;Android 13; in; 1ng6ygt)', '2026-06-03 13:55:25'),
(72, 10, 'e4bfab23894c422d2797249d4c61ff23', '2404:c0:be01:4486:d8b8:4dda:41dd:79ad', 'OTT Navigator/1.7.0.2.4 (Linux;Android 14; in; aey067)', '2026-06-02 20:11:58'),
(73, 10, '2d7cdcfa20f401d4595337de84ee4eab', '2404:8000:1055:7b8:9bd0:279c:9750:fef1', 'OTT Navigator/1.7.4.1 (Linux;Android 16; id; 3r6195)', '2026-06-03 01:42:22'),
(74, 10, '408578a3f1380a00e5b30bf4f30dd448', '162.19.116.19', 'Mozilla/5.0 (Windows NT 6.2; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1667.0 Safari/537.36', '2026-06-03 10:36:00'),
(75, 10, '69b775afc8ecef4725c198b1ba33f7af', '110.138.182.183', 'OTT Navigator/1.7.4.1 (Linux;Android 16; id; 3r6195)', '2026-06-03 14:31:22'),
(76, 10, '1741415b550fbad193d53dfb29e94657', '2404:c0:be02:1355:72ac:7ed7:deb6:1838', 'OTT Navigator/1.7.0.2.4 (Linux;Android 14; in; aey067)', '2026-06-03 20:01:27'),
(77, 10, 'fa56b5357f43aed758cc91eb40b112e5', '2402:8780:1063:b25:117e:2783:a7ba:7655', 'OTT Navigator/1.7.0.2.4 (Linux;Android 10; in; hixduh)', '2026-06-04 19:00:01'),
(78, 10, '7cfcd3a9e06edae250c99877d1b0351b', '2404:c0:d001:f265:55c8:64ae:64e2:efc1', 'OTT Navigator/1.7.3.2 (Linux;Android 13; in; 1ng6ygt)', '2026-06-04 09:53:54'),
(79, 10, 'e8324cfe7c24730d194a8ea7650d9215', '64.120.92.26', 'ngasal aja', '2026-06-04 13:52:01'),
(80, 10, '8ca5f793ec05a2cde92235029b63df71', '103.181.254.196', 'OTT Navigator/1.7.4.1 (OPPO CPH2669;Android 16; c634bd1)', '2026-06-04 14:38:32'),
(81, 10, 'aec04b64c8d2bbb2d54a285b2d4619c6', '103.181.254.196', 'Reqable/3.1.2', '2026-06-04 14:38:54'),
(82, 10, '342b571c597112de29eeff191b600fe7', '103.181.254.196', 'TWF1TWFsaW5nS2FoS29udG9s==', '2026-06-04 15:39:02'),
(83, 10, '93520b1a7a5db6f290391d6b95a11221', '103.181.254.196', 'OTT Navigator/1.7.5.1 (Linux;Android 16; id; 1ok2h6w)', '2026-06-04 18:49:04'),
(84, 10, '5be011878ca9c665a09aa0b170bc7a0f', '2a03:2880:15ff:4c::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '2026-06-04 18:40:18'),
(85, 10, '4c50034692d3ffbbad4b285f7588eef8', '2a03:2880:15ff:40::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '2026-06-04 18:40:18'),
(86, 10, 'c23b4a9cf77506b9c740a4820714c763', '2a03:2880:9ff:60::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '2026-06-04 18:40:18'),
(87, 10, '2310d9a945e516e24c9de8e91f9b17f8', '43.229.254.80', 'VLC/3.0.23 LibVLC/3.0.23', '2026-06-04 18:50:22'),
(88, 10, '266b9c4820bd45ece8a4cd31689f3e90', '43.229.254.80', 'OTT Navigator/1.7.0.2.4 (Linux;Android 13; in; 1cvk7b7)', '2026-06-04 18:51:44'),
(89, 10, '944621f07f27021b5471328640cdb9de', '202.125.100.63', 'VLC/3.0.21 LibVLC/3.0.21', '2026-06-04 19:01:16'),
(90, 10, '60fe4f30f5e4669d388a7da8226ae8ff', '39.194.4.20', 'WhatsApp/2.23.20.0', '2026-06-04 19:00:44'),
(91, 10, 'aa53ce505ca9bdb4a19da04fc691feb9', '39.194.4.20', 'WAKHAJI/3.1.559 (Linux; Android; access-denied-403)', '2026-06-04 19:01:40'),
(92, 10, '9fedf4b169e5a02a0864d71f699df29f', '2a03:2880:9ff:61::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '2026-06-04 19:04:49'),
(93, 10, '75fb08fe5eb8d25ed71fecab8aaccd90', '2a03:2880:11ff:7::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '2026-06-04 19:04:57'),
(94, 10, '6030e65da96b83e8ffda2d39865f588b', '103.13.204.86', 'OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', '2026-06-04 19:34:28'),
(95, 10, '1ba46a98fa24806c25f0efd87344390d', '2402:8780:1063:b25:73b9:29ec:8aa6:6fad', 'OTT Navigator/1.7.0.2.4 (Linux;Android 10; in; hixduh)', '2026-06-04 19:12:12'),
(96, 10, '0b1fb1f09421f9551582d77bdd4d3c6c', '202.125.100.63', 'OTT Navigator/1.7.0.2.4 (Linux;Android 9; in; 1etx4g7)', '2026-06-04 19:21:38'),
(97, 10, '98fb534299137809055dd976db5d610c', '202.162.204.214', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', '2026-06-04 19:39:53'),
(98, 10, '8c0d0220a26a416d61f85e72fad2a500', '2400:9800:660:36ca:1:0:71fd:de60', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', '2026-06-04 19:46:27'),
(99, 10, '3d17eadb0ce4404b3454832b93960246', '125.162.216.112', 'Dalvik/2.1.0 (Linux; U; Android 16; I2505 Build/BP2A.250605.031.A3_T1_V000L1)', '2026-06-04 19:58:12'),
(100, 10, 'cba28faacdaf2c6bee486751c8cb338d', '2404:8000:1055:7b8:6725:2ad:b8ab:d188', 'OTT Navigator/1.7.4.1 (Linux;Android 16; id; 3r6195)', '2026-06-04 20:10:47'),
(101, 10, '72c53f7831a853aa7aad24866311a05a', '125.162.216.112', 'OTT Navigator/1.7.5.1 (Linux;Android 16; id; ery7dq)', '2026-06-04 20:17:51'),
(102, 10, 'cd4a3a4a5968eb6f63f9872b3f07eae7', '125.162.216.112', 'OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 1noq7h4)', '2026-06-04 20:19:38'),
(103, 10, '3a96df03bdd2fd89d6ac9aa8a10a42e4', '114.10.10.65', 'okhttp/4.12.0', '2026-06-04 20:49:20'),
(104, 10, '5d2a16e6b19f710e2eb53da7777f557c', '2404:c0:1470::6c7e:6ccd', 'MXPlayer/1.94.4 (Linux; Android 13; in-ID; Infinix X6528B Build/X6528B-F069ZAaAbAcAdAeBgBhBi-T-OP-240201V383)', '2026-06-04 20:53:38');

-- --------------------------------------------------------

--
-- Table structure for table `playlists`
--

CREATE TABLE `playlists` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `source_url` text NOT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `playlists`
--

INSERT INTO `playlists` (`id`, `admin_id`, `name`, `source_url`, `description`, `is_active`, `created_at`) VALUES
(4, 1, 'test 2', 'https://iptv.tipime.my.id/data/playlists/free.m3u', '', 1, '2026-05-31 17:01:19'),
(5, 1, 'Tipistream', 'https://go.tipime.my.id/user/tipistream', '', 1, '2026-05-31 17:33:58'),
(7, 1, 'TIMNAS', 'https://iptv.tipime.my.id/data/playlists/timnas.m3u8', 'free', 1, '2026-06-01 16:30:29');

-- --------------------------------------------------------

--
-- Table structure for table `tokens`
--

CREATE TABLE `tokens` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(128) NOT NULL,
  `playlist_id` int(11) NOT NULL,
  `device_fingerprint` varchar(255) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tokens`
--

INSERT INTO `tokens` (`id`, `user_id`, `token`, `playlist_id`, `device_fingerprint`, `ip_address`, `user_agent`, `expires_at`, `created_at`) VALUES
(91, 10, 'd00817e951f48cbfdd238e937188605f2fc8cd9dbb7aa260ae544b48773ec4ac', 7, 'e8324cfe7c24730d194a8ea7650d9215', '64.120.92.26', 'ngasal aja', '2026-06-04 19:52:01', '2026-06-04 13:52:01'),
(92, 10, 'ac06a6e56c237554986b9418d565e9d84e9f8955ad2be1e57ad8c2aa7745bf5b', 7, '558c7132fdb939616b526e69556cefaf', '64.120.92.26', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', '2026-06-04 20:04:06', '2026-06-04 14:04:06'),
(93, 10, '1e6416b2068773a6066601469624715591aeb26961080af7f7d1d2a16eb926a0', 7, '8ca5f793ec05a2cde92235029b63df71', '103.181.254.196', 'OTT Navigator/1.7.4.1 (OPPO CPH2669;Android 16; c634bd1)', '2026-06-04 20:38:32', '2026-06-04 14:38:32'),
(94, 10, '932e40f5fe85cc6fcfb06879f4b069712a0a97f5e92012e3aaf694f97520e490', 7, 'aec04b64c8d2bbb2d54a285b2d4619c6', '103.181.254.196', 'Reqable/3.1.2', '2026-06-04 20:38:54', '2026-06-04 14:38:54'),
(95, 10, '8c831faa30729755f41455a0be03525414c84d626176ed7277baf1ebf1de22f4', 7, '342b571c597112de29eeff191b600fe7', '103.181.254.196', 'TWF1TWFsaW5nS2FoS29udG9s==', '2026-06-04 21:39:00', '2026-06-04 15:39:00'),
(96, 10, 'd7514ea5ed9b08ac83c4d1f3503017f1bd563df3502255f7c5b9e10453dfbf41', 7, '93520b1a7a5db6f290391d6b95a11221', '103.181.254.196', 'OTT Navigator/1.7.5.1 (Linux;Android 16; id; 1ok2h6w)', '2026-06-04 22:02:18', '2026-06-04 16:02:19'),
(97, 10, '95273d23124669929d808ffb082f49f0c2156cd2fd5b56ba3d2c4a22e4d77245', 7, '4c50034692d3ffbbad4b285f7588eef8', '2a03:2880:15ff:40::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '2026-06-05 00:40:18', '2026-06-04 18:40:18'),
(98, 10, 'd32c27a7218417a9f536dd051b3585b5840c319d1e80cfda5f731a67eb932205', 7, '5be011878ca9c665a09aa0b170bc7a0f', '2a03:2880:15ff:4c::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '2026-06-05 00:40:18', '2026-06-04 18:40:18'),
(99, 10, '1781027317e8802317b14356b68c6b07c6cd56d828dfc391e8140b010b3c0cd9', 7, 'c23b4a9cf77506b9c740a4820714c763', '2a03:2880:9ff:60::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '2026-06-05 00:40:18', '2026-06-04 18:40:18'),
(100, 10, '258b7af9a4b8e3161d6799eb49deed021ca1b5a5505c612bf48b8e7da18e2603', 7, '2310d9a945e516e24c9de8e91f9b17f8', '43.229.254.80', 'VLC/3.0.23 LibVLC/3.0.23', '2026-06-05 00:49:06', '2026-06-04 18:49:06'),
(102, 10, '90bfba5557f8abb989d4ff1c296637d2c8cb43c22df45f800e8ab802d942f077', 7, '266b9c4820bd45ece8a4cd31689f3e90', '43.229.254.80', 'OTT Navigator/1.7.0.2.4 (Linux;Android 13; in; 1cvk7b7)', '2026-06-05 00:51:44', '2026-06-04 18:51:44'),
(103, 10, 'da23272a16cc4c187ac66a072f84a489682749ce13ba820dbfed5cca91725f48', 7, '944621f07f27021b5471328640cdb9de', '202.125.100.63', 'VLC/3.0.21 LibVLC/3.0.21', '2026-06-05 00:59:36', '2026-06-04 18:59:36'),
(104, 10, '70e5db88f9659537dbf4a181ae2ca6a189019dfd25629cdb41b0fc6ea14504f0', 7, '2cc727e7c2c4a46be3741feb2723b01b', '31.186.87.211', 'Unknown', '2026-06-05 00:59:50', '2026-06-04 18:59:50'),
(105, 10, '52a359076fabc3029fd2e288829db560304ed8202397e039566d15b4290dab16', 7, 'fa56b5357f43aed758cc91eb40b112e5', '2402:8780:1063:b25:117e:2783:a7ba:7655', 'OTT Navigator/1.7.0.2.4 (Linux;Android 10; in; hixduh)', '2026-06-05 01:00:01', '2026-06-04 19:00:01'),
(106, 10, '54dba89b6b398e988c8cb59ede800b7c3780d70679fe24cf19e2e3068b801459', 7, '60fe4f30f5e4669d388a7da8226ae8ff', '39.194.4.20', 'WhatsApp/2.23.20.0', '2026-06-05 01:00:45', '2026-06-04 19:00:51'),
(107, 10, '1dfc652b7ccaee75feec38e167ad0ed18908bf037df2ab6d765372efd68c7dc6', 7, 'aa53ce505ca9bdb4a19da04fc691feb9', '39.194.4.20', 'WAKHAJI/3.1.559 (Linux; Android; access-denied-403)', '2026-06-05 01:01:40', '2026-06-04 19:01:40'),
(108, 10, 'e9e7e7625709dba312baa9dc15d7a347c87f417d3674edcbd3743aca496554f5', 7, '9fedf4b169e5a02a0864d71f699df29f', '2a03:2880:9ff:61::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '2026-06-05 01:04:49', '2026-06-04 19:04:49'),
(109, 10, '005b7331503f83318114ec5282ebc2bfcdf7edc6ba5f99a8bb3aa2bce3fea235', 7, '75fb08fe5eb8d25ed71fecab8aaccd90', '2a03:2880:11ff:7::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', '2026-06-05 01:04:57', '2026-06-04 19:04:57'),
(110, 10, 'f7fa483704db8df04251884092064f0b8901dd30693c937b8d9f25158e97a8d0', 7, '6030e65da96b83e8ffda2d39865f588b', '103.13.204.86', 'OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 182kfzz)', '2026-06-05 01:08:24', '2026-06-04 19:08:24'),
(111, 10, '4fc4ef418bb64ce1f5ddd08d6f52da8a1ba3a2a396579411fc09912fb18abd90', 7, '1ba46a98fa24806c25f0efd87344390d', '2402:8780:1063:b25:73b9:29ec:8aa6:6fad', 'OTT Navigator/1.7.0.2.4 (Linux;Android 10; in; hixduh)', '2026-06-05 01:12:12', '2026-06-04 19:12:12'),
(112, 10, 'c3181fef73294df7ad66e6191d5e09185e428963ad7882d1313c055f58fdb475', 7, '0b1fb1f09421f9551582d77bdd4d3c6c', '202.125.100.63', 'OTT Navigator/1.7.0.2.4 (Linux;Android 9; in; 1etx4g7)', '2026-06-05 01:14:15', '2026-06-04 19:14:15'),
(113, 10, '1b971f8b4f234c412055c2b21e14603fee7850cbca26002f35851edea6390095', 7, '98fb534299137809055dd976db5d610c', '202.162.204.214', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', '2026-06-05 01:39:51', '2026-06-04 19:39:51'),
(114, 10, '83e3dbff500437ba1e8ca6039a321c6b353946eb6d53cacdb9197db417b5154c', 7, '8c0d0220a26a416d61f85e72fad2a500', '2400:9800:660:36ca:1:0:71fd:de60', 'OTT Navigator/1.7.4.1 (Linux;Android 13; in; 1rrwjv7)', '2026-06-05 01:46:21', '2026-06-04 19:46:21'),
(115, 10, 'b3c5e381fd1cb07c3fef064f2824c573081ba0e98f4c9e90518115c006c6f24c', 7, '3d17eadb0ce4404b3454832b93960246', '125.162.216.112', 'Dalvik/2.1.0 (Linux; U; Android 16; I2505 Build/BP2A.250605.031.A3_T1_V000L1)', '2026-06-05 01:58:12', '2026-06-04 19:58:12'),
(116, 10, 'aed4cb7b1881fc842d8384f758c74af56bc7a735b519b7967f4f98d8fb962322', 7, 'cba28faacdaf2c6bee486751c8cb338d', '2404:8000:1055:7b8:6725:2ad:b8ab:d188', 'OTT Navigator/1.7.4.1 (Linux;Android 16; id; 3r6195)', '2026-06-05 02:10:47', '2026-06-04 20:10:47'),
(117, 10, '8dbcf44025efca014b31c03793c15bb75c8970c438ac313744f14df18894499f', 7, '72c53f7831a853aa7aad24866311a05a', '125.162.216.112', 'OTT Navigator/1.7.5.1 (Linux;Android 16; id; ery7dq)', '2026-06-05 02:16:23', '2026-06-04 20:16:23'),
(118, 10, '49fe5475413312f843a4d013c0cfab4b94fb9544ea04ebe6b0867a1154513dd5', 7, 'cd4a3a4a5968eb6f63f9872b3f07eae7', '125.162.216.112', 'OTT Navigator/1.7.0.2.4 (Linux;Android 16; in; 1noq7h4)', '2026-06-05 02:19:38', '2026-06-04 20:19:38'),
(119, 10, 'a4bdeb81bbcbda709c0afb2c60fc5b7101efd6c7ad2523a60811b98a4369afc7', 7, '3a96df03bdd2fd89d6ac9aa8a10a42e4', '114.10.10.65', 'okhttp/4.12.0', '2026-06-05 02:49:19', '2026-06-04 20:49:19'),
(120, 10, '4f6fdc6180e01f1afa2a78723b2edd23b3da6da073a3744dbed72ca18e2d917f', 7, '5d2a16e6b19f710e2eb53da7777f557c', '2404:c0:1470::6c7e:6ccd', 'MXPlayer/1.94.4 (Linux; Android 13; in-ID; Infinix X6528B Build/X6528B-F069ZAaAbAcAdAeBgBhBi-T-OP-240201V383)', '2026-06-05 02:53:37', '2026-06-04 20:53:37');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `stream_key` varchar(64) NOT NULL DEFAULT '',
  `playlist_id` int(11) NOT NULL,
  `max_devices` int(11) DEFAULT 1,
  `expired_at` datetime NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `notes` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `admin_id`, `username`, `password`, `stream_key`, `playlist_id`, `max_devices`, `expired_at`, `is_active`, `notes`, `created_at`) VALUES
(8, 1, 'tipistream', '$2y$10$uLAgmPyOWf7PFFSeO8qSW.xGwa/NXLzYrvo4OmGAHi/EOL4yhEVjW', '1f98dd72a98f81e7e34b4260ad697d26', 5, 10, '2026-07-30 17:41:30', 1, '', '2026-05-31 17:41:30'),
(10, 1, 'timnasu19', '$2y$10$rnPWKyM4E95Y/vNx5cR0luQViDY/opKHJxM27ENIVi1T/3eNuJ8c6', '6080d92737383203339969373d2ba853', 7, 100, '2026-06-08 16:35:00', 1, 'GRATIS', '2026-06-01 16:35:33'),
(12, 1, 'raihan', '$2y$10$sBUQ8bPTnw/76Yb0NUKgm.TR8pmp5AVNLUuS3NkniT3kYHZ3OO5XO', 'ffdc7e123f4d17b7a2adaf04b7e8e088', 5, 2, '2026-07-01 19:17:38', 1, 'Tester', '2026-06-01 19:17:38');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `access_logs`
--
ALTER TABLE `access_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_created_at` (`created_at`),
  ADD KEY `idx_action` (`action`);

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `blocked_ips`
--
ALTER TABLE `blocked_ips`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ip_address` (`ip_address`);

--
-- Indexes for table `device_sessions`
--
ALTER TABLE `device_sessions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_device` (`user_id`,`device_fingerprint`);

--
-- Indexes for table `playlists`
--
ALTER TABLE `playlists`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admin_id` (`admin_id`);

--
-- Indexes for table `tokens`
--
ALTER TABLE `tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_per_admin` (`admin_id`,`username`),
  ADD KEY `playlist_id` (`playlist_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `access_logs`
--
ALTER TABLE `access_logs`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=488;

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `blocked_ips`
--
ALTER TABLE `blocked_ips`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `device_sessions`
--
ALTER TABLE `device_sessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

--
-- AUTO_INCREMENT for table `playlists`
--
ALTER TABLE `playlists`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tokens`
--
ALTER TABLE `tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `device_sessions`
--
ALTER TABLE `device_sessions`
  ADD CONSTRAINT `device_sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `playlists`
--
ALTER TABLE `playlists`
  ADD CONSTRAINT `playlists_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tokens`
--
ALTER TABLE `tokens`
  ADD CONSTRAINT `tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `users_ibfk_2` FOREIGN KEY (`playlist_id`) REFERENCES `playlists` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
