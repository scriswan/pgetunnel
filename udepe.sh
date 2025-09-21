#!/bin/bash
# ==========================================
# Installer UDP-Custom Auto Start (By Lite)
# ==========================================

BIWhite='\033[1;97m'
BIYellow='\033[1;93m'
NC='\033[0m'
clear

function loading() {
  local pid=$1
  local delay=0.1
  local spin='-\|/'
  while ps -p $pid > /dev/null; do
    local temp=${spin#?}
    printf " [%c]  " "$spin"
    local spin=$temp${spin%"$temp"}
    sleep $delay
    printf "\b\b\b\b\b\b"
  done
}

# Hentikan service lama jika ada
systemctl stop udp-custom &>/dev/null
systemctl disable udp-custom &>/dev/null
rm -f /etc/systemd/system/udp-custom.service
systemctl daemon-reload

# Hapus folder lama
rm -rf /root/udp &>/dev/null
mkdir -p /root/udp
cd /root || exit 1

# Ganti timezone
echo -e "${BIWhite}Mengganti timezone ke GMT+7...${NC}"
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# Download binary & config
echo -e "${BIWhite}Mengunduh udp-custom...${NC}"
wget -q -O udp.zip "https://raw.githubusercontent.com/scriswan/pgetunnel/main/udp.zip" || {
  echo -e "${BIYellow}Gagal mengunduh udp.zip!${NC}"
  exit 1
}

unzip -o udp.zip -d /root/udp/ &>/dev/null
rm -f udp.zip
chmod +x /root/udp/udp-custom
chmod 644 /root/udp/config.json

# Buat service systemd
if [ -z "$1" ]; then
cat > /etc/systemd/system/udp-custom.service <<EOF
[Unit]
Description=UDP Custom By Lite
After=network.target

[Service]
User=root
Type=simple
ExecStart=/root/udp/udp-custom server
WorkingDirectory=/root/udp/
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF
else
cat > /etc/systemd/system/udp-custom.service <<EOF
[Unit]
Description=UDP Custom By Lite
After=network.target

[Service]
User=root
Type=simple
ExecStart=/root/udp/udp-custom server -exclude $1
WorkingDirectory=/root/udp/
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF
fi

# Reload & enable service
echo -e "${BIWhite}Mengaktifkan service udp-custom...${NC}"
systemctl daemon-reload
systemctl enable udp-custom &>/dev/null
systemctl restart udp-custom &>/dev/null

sleep 3 & loading $!

# Status
if systemctl is-active --quiet udp-custom; then
  echo -e "\n${BIWhite}✅ UDP Custom berhasil diinstall & berjalan.${NC}"
else
  echo -e "\n${BIYellow}⚠️ UDP Custom gagal dijalankan. Cek log dengan:${NC} journalctl -u udp-custom -f"
fi

# Langsung ke menu (kalau ada fungsi menu di script kamu)
sleep 1
clear
if command -v menu >/dev/null 2>&1; then
  menu
else
  echo -e "${BIWhite}Ketik 'menu' untuk masuk panel utama.${NC}"
fi