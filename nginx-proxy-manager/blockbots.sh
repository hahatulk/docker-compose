#!/bin/bash
# ==================== Установка nginx-ultimate-bad-bot-blocker для NPM ====================

set -e

BASE_DIR=$(pwd)
CONF_DIR="$BASE_DIR/conf.d"
BOTS_DIR="$BASE_DIR/bots.d"
CUSTOM_DIR="$BASE_DIR/data/nginx/custom"

echo "🔧 Установка nginx-ultimate-bad-bot-blocker..."

mkdir -p "$CONF_DIR" "$BOTS_DIR" "$CUSTOM_DIR"

sudo wget -q https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/install-ngxblocker -O /usr/local/sbin/install-ngxblocker
sudo chmod +x /usr/local/sbin/install-ngxblocker

install-ngxblocker -b "$BOTS_DIR/" -c "$CONF_DIR/" -x

echo "🛠 Исправляем конфликты с NPM..."

# Rate limiting
sed -i 's/^\s*limit_conn_zone/#limit_conn_zone/' "$CONF_DIR/botblocker-nginx-settings.conf" 2>/dev/null || true
sed -i 's/^\s*limit_req_zone/#limit_req_zone/' "$CONF_DIR/botblocker-nginx-settings.conf" 2>/dev/null || true
sed -i 's/^\s*limit_conn addr/#limit_conn addr/' "$BOTS_DIR/ddos.conf" 2>/dev/null || true
sed -i 's/^\s*limit_req zone=flood/#limit_req zone=flood/' "$BOTS_DIR/ddos.conf" 2>/dev/null || true
sed -i 's/^\s*limit_conn /#limit_conn /' "$BOTS_DIR/blockbots.conf" 2>/dev/null || true
sed -i 's/^\s*limit_req /#limit_req /' "$BOTS_DIR/blockbots.conf" 2>/dev/null || true

sed -i 's/^\s*server_names_hash_bucket_size/#server_names_hash_bucket_size/' "$CONF_DIR/botblocker-nginx-settings.conf" 2>/dev/null || true
sed -i 's/^\s*server_names_hash_max_size/#server_names_hash_max_size/' "$CONF_DIR/botblocker-nginx-settings.conf" 2>/dev/null || true
sed -i 's/^\s*variables_hash_bucket_size/#variables_hash_bucket_size/' "$CONF_DIR/botblocker-nginx-settings.conf" 2>/dev/null || true

# === server_proxy.conf ===
CUSTOM_FILE="$CUSTOM_DIR/server_proxy.conf"
if [ ! -f "$CUSTOM_FILE" ]; then
    cat > "$CUSTOM_FILE" << 'EOF'
# nginx-ultimate-bad-bot-blocker
include /etc/nginx/bots.d/ddos.conf;
include /etc/nginx/bots.d/blockbots.conf;

client_max_body_size 100G;
client_body_timeout 12h;
proxy_connect_timeout 12h;
proxy_send_timeout 12h;
proxy_read_timeout 12h;
send_timeout 12h;

proxy_set_header Host $host;
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
proxy_set_header X-Forwarded-Proto $scheme;
proxy_set_header X-Forwarded-Host $host;

real_ip_header X-Forwarded-For;
real_ip_recursive on;
EOF
else
    if ! grep -q "blockbots.conf" "$CUSTOM_FILE"; then
        cat >> "$CUSTOM_FILE" << 'EOF'

# nginx-ultimate-bad-bot-blocker
include /etc/nginx/bots.d/ddos.conf;
include /etc/nginx/bots.d/blockbots.conf;

client_max_body_size 100G;
client_body_timeout 12h;
proxy_connect_timeout 12h;
proxy_send_timeout 12h;
proxy_read_timeout 12h;
send_timeout 12h;

proxy_set_header Host $host;
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
proxy_set_header X-Forwarded-Proto $scheme;
proxy_set_header X-Forwarded-Host $host;

real_ip_header X-Forwarded-For;
real_ip_recursive on;
EOF
    fi
fi

echo "✅ Готово. Перезапускаем..."
docker compose restart

echo "🎉 Готово!"
echo "docker compose logs --tail=50"
