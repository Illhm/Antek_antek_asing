# IPTV Panel - Panduan Instalasi

## Persyaratan
- PHP 7.4+ (direkomendasikan PHP 8.0+)
- SQLite3
- Web server Apache/LiteSpeed (shared hosting OK)
- Ekstensi PHP: PDO, PDO_SQLite, openssl

---

## Langkah Instalasi

### 1. Upload File
Upload seluruh isi folder ke **public_html** atau subfolder hosting kamu via FTP/File Manager.
Pastikan folder `db/` dapat ditulis (writable) oleh web server (CHMOD 755/777).

Sistem akan menggunakan SQLite sebagai database:
- Pada environment container (Docker/Railway), database disimpan di `/data/database.sqlite`.
- Pada hosting biasa, database disimpan di `db/database.sqlite`.

**Catatan untuk Railway:** Jika kamu menggunakan Railway, pastikan untuk menambahkan **Volume** pada dashboard Railway dan pasang (mount) ke path `/data` agar data database tidak terhapus saat redeploy.

### 2. Konfigurasi
Sistem konfigurasi kini menggunakan file `.env` di folder `includes` untuk keamanan tambahan.

1. Salin `includes/.env.example` menjadi `includes/.env`.
2. Edit file `includes/.env`:
```env
PANEL_URL=https://domain.com/iptv-panel
SECRET_KEY=GANTI_RANDOM_STRING_32_KARAKTER_ANDA
PROXY_EXPIRE_SECONDS=7200
RATE_LIMIT_REQUESTS=300
RATE_LIMIT_WINDOW=60
```
Tidak perlu mengonfigurasi `DB_HOST`, `DB_USER`, `DB_PASS`, atau database eksternal karena sekarang menggunakan SQLite.

### 3. Login Pertama
- Buka: `https://domain.com/iptv-panel/`
- Username: `admin`
- Password: `1`
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
https://domain.com/iptv-panel/proxy/stream.php?user=USERNAME&key=STREAM_KEY
```
URL ini yang disebarkan ke pelanggan. Tidak mengekspos source asli.

### Alur Keamanan Baru
Sistem proxy telah diperbarui secara signifikan untuk mengamankan konten M3U/M3U8:
1. URL sumber tidak akan pernah muncul di output playlist atau dapat di-sniff menggunakan tools seperti HTTP Canary atau Python.
2. Setiap item dalam playlist (segment, key, child playlist) akan ditulis ulang dan diarahkan ke `proxy/asset.php`.
3. URL proksi ini diamankan menggunakan **HMAC Signature** yang divalidasi per-permintaan dengan durasi kedaluwarsa singkat (default: 2 jam).
4. Signature mengikat data: Username, Hash Device, Prefix IP (/24 untuk IPv4), dan Waktu Kedaluwarsa. URL tidak bisa digunakan di luar lingkungan tersebut.
5. Tersedia proteksi Rate Limiting di level database untuk menangkal eksploitasi brute-force download segmen.
6. Memvalidasi `X-Forwarded-For` secara aman, khususnya hanya untuk IP resmi Cloudflare.

### Monitoring
- **Live Log** → pantau akses real-time, IP, player
- **Token Aktif** → lihat & cabut token yang aktif
- **Blokir IP** → tambah IP ke blacklist

---

## Struktur Folder
```
iptv-panel/
├── index.php
├── login.php
├── logout.php
├── db/
│   ├── schema.sqlite.sql
│   └── database.sqlite (terbuat otomatis)
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
