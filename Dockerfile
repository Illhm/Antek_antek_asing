FROM php:8.2-apache

ENV APACHE_DOCUMENT_ROOT=/var/www/html \
    PHP_MEMORY_LIMIT=256M \
    PHP_UPLOAD_MAX_FILESIZE=64M \
    PHP_POST_MAX_SIZE=64M \
    ADMIN_USERNAME=admin \
    ADMIN_PASSWORD=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    unzip \
    default-mysql-client \
    libzip-dev \
    libcurl4-openssl-dev \
    libonig-dev \
    ffmpeg \
    && docker-php-ext-install -j"$(nproc)" pdo_mysql mysqli curl mbstring zip \
    && { a2dismod -f mpm_event mpm_worker >/dev/null 2>&1 || true; } \
    && a2enmod mpm_prefork rewrite headers expires remoteip \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

COPY . /var/www/html/

RUN rm -f /var/www/html/includes/.env /var/www/html/.env || true \
    && chown -R www-data:www-data /var/www/html \
    && find /var/www/html -type d -exec chmod 755 {} \; \
    && find /var/www/html -type f -exec chmod 644 {} \;

RUN cat > /usr/local/bin/railway-start <<'EOF'
#!/bin/sh
set -e

PORT="${PORT:-8080}"

a2dismod -f mpm_event mpm_worker >/dev/null 2>&1 || true
a2enmod mpm_prefork rewrite headers expires remoteip >/dev/null 2>&1 || true

sed -ri "s/^Listen .*/Listen ${PORT}/" /etc/apache2/ports.conf
sed -ri "s/<VirtualHost \*:[0-9]+>/<VirtualHost *:${PORT}>/" /etc/apache2/sites-available/000-default.conf

cat > /etc/apache2/conf-available/railway-security.conf <<'EOF_CONF'
ServerTokens Prod
ServerSignature Off
TraceEnable Off

<Directory /var/www/html>
    Options -Indexes +FollowSymLinks
    AllowOverride All
    Require all granted
</Directory>

<FilesMatch "(^\.env|^\.git|composer\.(json|lock)|package(-lock)?\.json|yarn\.lock|Dockerfile|railway\.json|.*\.sql|.*\.log|.*\.md)$">
    Require all denied
</FilesMatch>

Header always set X-Content-Type-Options "nosniff"
Header always set X-Frame-Options "SAMEORIGIN"
Header always set Referrer-Policy "no-referrer"
Header always set Permissions-Policy "geolocation=(), microphone=(), camera=()"
EOF_CONF

a2enconf railway-security >/dev/null 2>&1 || true

php_ini="$PHP_INI_DIR/conf.d/railway.ini"
{
  echo "memory_limit=${PHP_MEMORY_LIMIT:-256M}"
  echo "upload_max_filesize=${PHP_UPLOAD_MAX_FILESIZE:-64M}"
  echo "post_max_size=${PHP_POST_MAX_SIZE:-64M}"
  echo "max_execution_time=0"
  echo "max_input_time=120"
  echo "expose_php=Off"
} > "$php_ini"

# Mapping variable Railway MySQL ke variable app
if [ -n "$MYSQLHOST" ] && [ -z "$DB_HOST" ]; then
  export DB_HOST="$MYSQLHOST"
fi

if [ -n "$MYSQLPORT" ] && [ -z "$DB_PORT" ]; then
  export DB_PORT="$MYSQLPORT"
fi

if [ -n "$MYSQLDATABASE" ] && [ -z "$DB_NAME" ]; then
  export DB_NAME="$MYSQLDATABASE"
fi

if [ -n "$MYSQLUSER" ] && [ -z "$DB_USER" ]; then
  export DB_USER="$MYSQLUSER"
fi

if [ -n "$MYSQLPASSWORD" ] && [ -z "$DB_PASS" ]; then
  export DB_PASS="$MYSQLPASSWORD"
fi

# Auto PANEL_URL dari Railway domain
if [ -n "$RAILWAY_PUBLIC_DOMAIN" ] && [ -z "$PANEL_URL" ]; then
  export PANEL_URL="https://${RAILWAY_PUBLIC_DOMAIN}"
fi

cat > /tmp/railway-admin-bootstrap.php <<'PHP_BOOTSTRAP'
<?php

function env_first(array $keys, $default = null) {
    foreach ($keys as $key) {
        $value = getenv($key);
        if ($value !== false && $value !== '') {
            return $value;
        }
    }
    return $default;
}

$host = env_first(['DB_HOST', 'MYSQLHOST']);
$port = env_first(['DB_PORT', 'MYSQLPORT'], '3306');
$db   = env_first(['DB_NAME', 'MYSQLDATABASE']);
$user = env_first(['DB_USER', 'MYSQLUSER']);
$pass = env_first(['DB_PASS', 'MYSQLPASSWORD'], '');

$databaseUrl = getenv('DATABASE_URL');
if ($databaseUrl && (!$host || !$db || !$user)) {
    $url = parse_url($databaseUrl);
    if ($url) {
        $host = $host ?: ($url['host'] ?? null);
        $port = $port ?: ($url['port'] ?? '3306');
        $db   = $db ?: ltrim($url['path'] ?? '', '/');
        $user = $user ?: ($url['user'] ?? null);
        $pass = $pass ?: ($url['pass'] ?? '');
    }
}

if (!$host || !$db || !$user) {
    echo "[bootstrap] DB env belum lengkap, skip setup admin.\n";
    exit(0);
}

$adminUsername = getenv('ADMIN_USERNAME') ?: 'admin';
$adminPassword = getenv('ADMIN_PASSWORD') ?: '1';

$dsn = "mysql:host={$host};port={$port};dbname={$db};charset=utf8mb4";

for ($i = 1; $i <= 30; $i++) {
    try {
        $pdo = new PDO($dsn, $user, $pass, [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::MYSQL_ATTR_MULTI_STATEMENTS => true,
        ]);
        break;
    } catch (Throwable $e) {
        echo "[bootstrap] Menunggu database... percobaan {$i}/30\n";
        sleep(2);
    }
}

if (!isset($pdo)) {
    echo "[bootstrap] Gagal konek database, skip setup admin.\n";
    exit(0);
}

function admins_table_exists(PDO $pdo): bool {
    try {
        $pdo->query("SELECT 1 FROM admins LIMIT 1");
        return true;
    } catch (Throwable $e) {
        return false;
    }
}

if (!admins_table_exists($pdo)) {
    $sqlFile = '/var/www/html/tipimemy_iptv_panel.sql';

    if (is_file($sqlFile)) {
        echo "[bootstrap] Tabel belum ada, import tipimemy_iptv_panel.sql...\n";
        $sql = file_get_contents($sqlFile);

        try {
            $pdo->exec($sql);
            echo "[bootstrap] Import SQL selesai.\n";
        } catch (Throwable $e) {
            echo "[bootstrap] Import SQL gagal: " . $e->getMessage() . "\n";
        }
    }
}

if (!admins_table_exists($pdo)) {
    echo "[bootstrap] Tabel admins belum tersedia, skip reset admin.\n";
    exit(0);
}

$hash = password_hash($adminPassword, PASSWORD_BCRYPT);

$stmt = $pdo->prepare("SELECT id FROM admins WHERE username = ? LIMIT 1");
$stmt->execute([$adminUsername]);
$existing = $stmt->fetch();

if ($existing) {
    $update = $pdo->prepare("UPDATE admins SET password = ?, role = 'superadmin' WHERE id = ?");
    $update->execute([$hash, $existing['id']]);
} else {
    $insert = $pdo->prepare("
        INSERT INTO admins (id, username, password, email, role, created_at)
        VALUES (1, ?, ?, 'admin@localhost', 'superadmin', NOW())
        ON DUPLICATE KEY UPDATE
            username = VALUES(username),
            password = VALUES(password),
            email = VALUES(email),
            role = VALUES(role)
    ");
    $insert->execute([$adminUsername, $hash]);
}

echo "[bootstrap] Admin siap. Username: {$adminUsername}, Password: {$adminPassword}\n";
PHP_BOOTSTRAP

php /tmp/railway-admin-bootstrap.php || true

apache2ctl configtest

exec apache2-foreground
EOF

RUN chmod +x /usr/local/bin/railway-start

EXPOSE 8080

CMD ["railway-start"]
