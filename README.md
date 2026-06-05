# Antek_antek_asing

A high-performance PHP IPTV proxy panel leveraging SQLite as its primary database. Ideal for self-hosting on Railway or any environment supporting PHP 8.2 and Apache.

## Deployment

Deploy this project on [Railway](https://railway.app/).

Set the following Environment Variables during deployment:

```env
PANEL_NAME=Tipistream Panel
PANEL_URL=
TIMEZONE=Asia/Jakarta
SQLITE_DB_PATH=/data/database.sqlite
ADMIN_USERNAME=admin
ADMIN_PASSWORD=1
ADMIN_ROLE=superadmin
SECRET_KEY=PUT_RANDOM_SECRET_HERE
MAX_CONCURRENT_STREAMS_PER_USER=1
STREAM_SESSION_POLICY=block_new
STREAM_IDLE_TIMEOUT=90
STREAM_SESSION_MAX_AGE=21600
PLAYLIST_SIGNED_TTL=120
SEGMENT_SIGNED_TTL=60
IP_BIND_MODE=soft
STRICT_CLIENT_BINDING=false
FREE_PLAYLIST_URL=https://iptv.tipime.my.id/data/playlists/free.m3u
```

Note: If `PANEL_URL` is empty, it will default to your `RAILWAY_PUBLIC_DOMAIN`.
Ensure that you change `SECRET_KEY` to a robust string in production environments.

## Features

- Lightweight, relying on a robust SQLite database configuration (no MySQL database needed).
- Deep security implementations mapping and binding user agents and signatures for maximum IPTV Stream control.
- Integrated Web Dashboard with authentication.
- Automatically handles new database schemas and a default admin credentials generation mechanism.
