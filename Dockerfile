FROM php:8.2-apache

ENV DEBIAN_FRONTEND=noninteractive \
    APACHE_DOCUMENT_ROOT=/var/www/html \
    SQLITE_DB_PATH=/data/database.sqlite \
    PHP_MEMORY_LIMIT=256M \
    PHP_UPLOAD_MAX_FILESIZE=64M \
    PHP_POST_MAX_SIZE=64M \
    ADMIN_USERNAME=admin \
    ADMIN_PASSWORD=1 \
    ADMIN_ROLE=superadmin \
    TIMEZONE=Asia/Jakarta \
    MAX_CONCURRENT_STREAMS_PER_USER=1 \
    STREAM_SESSION_POLICY=block_new \
    STREAM_IDLE_TIMEOUT=90 \
    STREAM_SESSION_MAX_AGE=21600 \
    PLAYLIST_SIGNED_TTL=120 \
    SEGMENT_SIGNED_TTL=60 \
    IP_BIND_MODE=soft \
    STRICT_CLIENT_BINDING=false

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    unzip \
    libsqlite3-dev \
    libzip-dev \
    libcurl4-openssl-dev \
    libonig-dev \
    ffmpeg \
    && docker-php-ext-install -j"$(nproc)" pdo_sqlite sqlite3 curl mbstring zip \
    && a2dismod -f mpm_event mpm_worker >/dev/null 2>&1 || true

RUN a2enmod mpm_prefork rewrite headers expires remoteip >/dev/null 2>&1 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

COPY . /var/www/html/

RUN mkdir -p /data /var/www/html/db \
    && rm -f /var/www/html/includes/.env /var/www/html/.env || true \
    && chown -R www-data:www-data /data /var/www/html \
    && find /var/www/html -type d -exec chmod 755 {} \; \
    && find /var/www/html -type f -exec chmod 644 {} \; \
    && chmod 775 /data /var/www/html/db

RUN cat > /usr/local/bin/railway-start <<'START_EOF'
#!/bin/sh
set -e

PORT="${PORT:-8080}"

a2dismod -f mpm_event mpm_worker >/dev/null 2>&1 || true
a2enmod mpm_prefork rewrite headers expires remoteip >/dev/null 2>&1 || true

sed -ri "s/^Listen .*/Listen ${PORT}/" /etc/apache2/ports.conf
sed -ri "s/<VirtualHost \*:[0-9]+>/<VirtualHost *:${PORT}>/" /etc/apache2/sites-available/000-default.conf

cat > /etc/apache2/conf-available/railway-security.conf <<'EOF_CONF'
ServerName localhost
ServerTokens Prod
ServerSignature Off
TraceEnable Off

<Directory /var/www/html>
    Options -Indexes +FollowSymLinks
    AllowOverride All
    Require all granted
</Directory>

<FilesMatch "(^\.env|^\.git|composer\.(json|lock)|package(-lock)?\.json|yarn\.lock|Dockerfile|railway\.json|.*\.sql|.*\.sqlite|.*\.db|.*\.log|.*\.md)$">
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
  echo "date.timezone=${TIMEZONE:-Asia/Jakarta}"
} > "$php_ini"

if [ -n "$RAILWAY_PUBLIC_DOMAIN" ] && [ -z "$PANEL_URL" ]; then
  export PANEL_URL="https://${RAILWAY_PUBLIC_DOMAIN}"
fi

export SQLITE_DB_PATH="${SQLITE_DB_PATH:-/data/database.sqlite}"

mkdir -p /data /var/www/html/db
chown -R www-data:www-data /data /var/www/html/db || true
chmod 775 /data /var/www/html/db || true

php -m | grep -qi '^pdo_sqlite$'
php -m | grep -qi '^sqlite3$'
php -m | grep -qi '^curl$'
php -m | grep -qi '^mbstring$'

apache2ctl configtest

exec apache2-foreground
START_EOF

RUN chmod +x /usr/local/bin/railway-start

EXPOSE 8080

CMD ["railway-start"]
