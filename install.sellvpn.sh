#!/bin/bash

# ==========================
# --- Warna & Garis ---
# ==========================
GREEN='\033[1;92m'
RED='\033[1;91m'
YELLOW='\033[1;33m'
BLUE='\033[1;94m'
NC='\033[0m'
LINE="━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# ==========================
# --- Hapus Bot Lama ---
# ==========================
hapus_bot_lama() {
    echo -e "${YELLOW}Menghapus bot lama...${NC}"
    systemctl stop sellvpn.service 2>/dev/null
    systemctl disable sellvpn.service 2>/dev/null
    rm -f /etc/systemd/system/sellvpn.service
    rm -f /usr/bin/sellvpn /usr/bin/server_sellvpn /etc/cron.d/server_sellvpn
    rm -rf /root/BotVPN4

    if command -v pm2 &> /dev/null; then
        pm2 delete sellvpn &> /dev/null
        pm2 save &> /dev/null
    fi

    systemctl daemon-reload
    echo -e "${GREEN}Bot lama berhasil dihapus.${NC}"
}

# ==========================
# --- Pasang Dependensi ---
# ==========================
pasang_package() {
    echo -e "${BLUE}Memeriksa dependensi...${NC}"
    if ! command -v node >/dev/null 2>&1 || ! node -v | grep -q 'v20'; then
        curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
        apt-get install -y nodejs
    fi
    npm install -g npm@10
    apt update
    apt install -y build-essential libcairo2-dev libpango1.0-dev \
        libjpeg-dev libgif-dev librsvg2-dev pkg-config libpixman-1-dev git curl cron
}

# ==========================
# --- Setup Bot ---
# ==========================
setup_bot() {
    timedatectl set-timezone Asia/Jakarta
    if [ ! -d /root/BotVPN4 ]; then
        git clone https://github.com/script-vpn-premium/BotVPN4.git /root/BotVPN4
    fi
    cd /root/BotVPN4
    npm install sqlite3 express crypto telegraf axios dotenv canvas node-fetch form-data
    npm rebuild canvas
    rm -rf node_modules
    npm install
    npm uninstall node-fetch
    npm install node-fetch@2
    chmod +x /root/BotVPN4/*
}

# ==========================
# --- Konfigurasi Bot ---
# ==========================
server_app() {
    echo -e "$LINE"
    echo -e "${GREEN}- BOT SELLVPN TELEGRAM PGETUNNEL${NC}"
    echo -e "$LINE"

    read -p "Masukkan token bot: " token
    read -p "Masukkan admin ID: " adminid
    read -p "Masukkan nama store: " namastore
    read -p "Masukkan DATA QRIS: " dataqris
    read -p "Masukkan MERCHANT ID: " merchantid
    read -p "Masukkan API KEY: " apikey
    read -p "Masukkan Chat ID Group Telegram: " chatid_group
    read -p "Masukkan Username Saweria: " username_saweria
    read -p "Masukkan Email Saweria: " saweria_email

    cat >/root/BotVPN4/.vars.json <<EOF
{
  "BOT_TOKEN": "$token",
  "USER_ID": "$adminid",
  "NAMA_STORE": "$namastore",
  "PORT": "50123",
  "DATA_QRIS": "$dataqris",
  "MERCHANT_ID": "$merchantid",
  "API_KEY": "$apikey",
  "GROUP_CHAT_ID": "$chatid_group",
  "SAWERIA_USERNAME": "$username_saweria",
  "SAWERIA_EMAIL": "$saweria_email"
}
EOF

    NODE_PATH=$(which node)
    cat >/usr/bin/sellvpn <<EOF
#!/bin/bash
cd /root/BotVPN4 || exit 1
$NODE_PATH app.js
EOF
    chmod +x /usr/bin/sellvpn

    cat >/etc/systemd/system/sellvpn.service <<EOF
[Unit]
Description=App Bot sellvpn Service
After=network.target

[Service]
ExecStart=$NODE_PATH /root/BotVPN4/app.js
WorkingDirectory=/root/BotVPN4
Restart=always
RestartSec=3
User=root
Environment=NODE_ENV=production
Environment=TZ=Asia/Jakarta
StandardOutput=append:/var/log/sellvpn.log
StandardError=append:/var/log/sellvpn-error.log
LimitNOFILE=10000

[Install]
WantedBy=multi-user.target
EOF

    systemctl daemon-reload
    systemctl enable sellvpn
    systemctl start sellvpn
    service cron restart

    echo -e "Status Server: $(systemctl is-active sellvpn)"
    echo -e "${GREEN}Bot berhasil diinstal dan sedang berjalan.${NC}"
}

# ==========================
# --- Proses Instalasi ---
# ==========================
hapus_bot_lama
pasang_package
setup_bot
server_app

echo -e "$LINE"
echo -e "${GREEN}✅ Instalasi Bot Sellvpn selesai!${NC}"
echo -e "$LINE"