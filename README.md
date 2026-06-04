# IPTV Panel - Panduan Instalasi

## Persyaratan
- PHP 7.4+ (direkomendasikan PHP 8.0+)
- MySQL 5.7+ atau MariaDB 10.3+
- Web server Apache/LiteSpeed (shared hosting OK)
- Ekstensi PHP: PDO, PDO_MySQL, openssl

---

## Langkah Instalasi

### 1. Upload File
Upload seluruh isi folder ke **public_html** atau subfolder hosting kamu via FTP/File Manager.

### 2. Buat Database
- Login ke **cPanel → phpMyAdmin**
- Buat database baru (misal: `iptv_panel`)
- Import file `database.sql`

### 3. Konfigurasi
Edit file `includes/config.php`:
```php
define('DB_HOST', 'localhost');
define('DB_NAME', 'iptv_panel');       // nama database
define('DB_USER', 'user_mysql');       // username MySQL dari cPanel
define('DB_PASS', 'password_mysql');   // password MySQL
define('PANEL_URL', 'https://domain.com/iptv-panel'); // URL lengkap panel
define('SECRET_KEY', 'GANTI_RANDOM_STRING_32_KARAKTER_ANDA');
```

### 4. Login Pertama
- Buka: `https://domain.com/iptv-panel/`
- Username: `admin`
- Password: `password`
- **⚠️ Segera ganti password setelah login pertama!**

---

## Cara Penggunaan

### Tambah Playlist
1. Dashboard → **Playlist M3U** → Tambah Playlist
2. Masukkan nama dan URL sumber M3U asli kamu
3. URL sumber tersembunyi dari user

### Buat User
1. Dashboard → **Kelola User** → Tambah User
2. Set username, password, pilih playlist, max device, dan durasi
3. Copy **Token URL** yang dihasilkan → berikan ke pelanggan

### Format URL untuk Pelanggan
```
https://domain.com/iptv-panel/proxy/stream.php?user=USERNAME
```
URL ini yang disebarkan ke pelanggan. Tidak mengekspos source asli.

### Monitoring
- **Live Log** → pantau akses real-time, IP, player
- **Token Aktif** → lihat & cabut token yang aktif
- **Blokir IP** → tambah IP ke blacklist

---

## Keamanan
- Token expired otomatis setiap 2 jam (bisa diubah di config)
- IP checker aktif di setiap request
- Device limit mencegah sharing akun
- Source URL tidak pernah terekspos ke user

---

## Struktur Folder
```
iptv-panel/
├── index.php
├── login.php
├── logout.php
├── database.sql
├── .htaccess
├── includes/
│   └── config.php
├── admin/
│   ├── dashboard.php
│   ├── playlists.php
│   ├── users.php
│   ├── tokens.php
│   ├── logs.php
│   ├── blocked.php
│   └── partials/
│       ├── sidebar.php
│       └── topbar.php
├── proxy/
│   └── stream.php
└── assets/
    ├── css/style.css
    └── js/app.js
```
