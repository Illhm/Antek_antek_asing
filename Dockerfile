FROM php:8.2-apache

ENV APACHE_DOCUMENT_ROOT=/var/www/html \
    PHP_MEMORY_LIMIT=256M \
    PHP_UPLOAD_MAX_FILESIZE=64M \
    PHP_POST_MAX_SIZE=64M

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    unzip \
    libzip-dev \
    libcurl4-openssl-dev \
    ffmpeg \
    && docker-php-ext-install -j"$(nproc)" mysqli pdo_mysql zip \
    && a2enmod rewrite headers expires remoteip \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer

WORKDIR /var/www/html
COPY . /var/www/html/

RUN if [ -f composer.json ]; then \
      composer install --no-dev --no-interaction --prefer-dist --optimize-autoloader; \
    fi \
    && chown -R www-data:www-data /var/www/html \
    && find /var/www/html -type d -exec chmod 755 {} \; \
    && find /var/www/html -type f -exec chmod 644 {} \;

RUN cat > /usr/local/bin/railway-start <<'EOF_START'
#!/bin/sh
set -e

PORT="${PORT:-8080}"

# Railway mewajibkan service listen ke port yang dikasih lewat env PORT.
sed -ri "s/^Listen .*/Listen ${PORT}/" /etc/apache2/ports.conf
sed -ri "s/<VirtualHost \*:[0-9]+>/<VirtualHost *:${PORT}>/" /etc/apache2/sites-available/000-default.conf

cat > /etc/apache2/conf-available/iptv-security.conf <<'EOF_CONF'
ServerTokens Prod
ServerSignature Off
TraceEnable Off

<Directory /var/www/html>
    Options -Indexes +FollowSymLinks
    AllowOverride All
    Require all granted
</Directory>

# Jangan expose file rahasia / source control / dependency manifest.
<FilesMatch "(^\.env|^\.git|composer\.(json|lock)|package(-lock)?\.json|yarn\.lock|Dockerfile|railway\.json)$">
    Require all denied
</FilesMatch>

# Basic hardening header. Streaming tetap jalan karena tidak mengubah Content-Type HLS/MP4.
Header always set X-Content-Type-Options "nosniff"
Header always set X-Frame-Options "SAMEORIGIN"
Header always set Referrer-Policy "no-referrer"
Header always set Permissions-Policy "geolocation=(), microphone=(), camera=()"
EOF_CONF

a2enconf iptv-security >/dev/null 2>&1 || true

php_ini="$PHP_INI_DIR/conf.d/railway.ini"
{
  echo "memory_limit=${PHP_MEMORY_LIMIT:-256M}"
  echo "upload_max_filesize=${PHP_UPLOAD_MAX_FILESIZE:-64M}"
  echo "post_max_size=${PHP_POST_MAX_SIZE:-64M}"
  echo "max_execution_time=0"
  echo "max_input_time=120"
  echo "expose_php=Off"
} > "$php_ini"

exec apache2-foreground
EOF_START

RUN chmod +x /usr/local/bin/railway-start

EXPOSE 8080
CMD ["railway-start"]
