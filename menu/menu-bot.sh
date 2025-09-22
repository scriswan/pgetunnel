#!/bin/bash
# Script: Bot Manager - gabungan lengkap dengan opsi ganti nama bot
# Usage: buat executable lalu jalankan: chmod +x script.sh && ./script.sh

dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=$(date +"%Y-%m-%d" -d "$dateFromServer")

###########- COLOR CODE -##############
NC="\e[0m"
RED="\033[0;31m"

# Color names used later
BIBlack='\033[1;90m'
BIRed='\033[1;91m'
BIGreen='\033[1;92m'
BIYellow='\033[1;93m'
BIBlue='\033[1;94m'
BIPurple='\033[1;95m'
BICyan='\033[1;96m'
BIWhite='\033[1;97m'
UWhite='\033[4;37m'
On_IPurple='\033[0;105m'
On_IRed='\033[0;101m'
ORANGE='\033[0;33m'

# small helpers used in menu
grenbo="\033[1;32m"
COLOR1="${grenbo}"

# === PERMISSION CHECK ===
PERMISSION () {
    MYIP=$(curl -sS ipv4.icanhazip.com)
    IZIN=$(curl -sS https://raw.githubusercontent.com/scriswan/pgetunnel/main/register | awk '{print $4}' | grep -w "$MYIP")
    if [ -n "$IZIN" ] && [ "$MYIP" = "$IZIN" ]; then
        echo "Permission Accepted"
        res="Permission Accepted"
    else
        res="Permission Denied!"
    fi
}

PERMISSION

if [ -f /home/needupdate ]; then
    echo -e "${RED}Your script needs to be updated first!${NC}"
    exit 0
elif [ "$res" != "Permission Accepted" ]; then
    echo -e "${RED}Permission Denied!${NC}"
    exit 0
fi

# Exporting Language to UTF-8
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'

MYIP=$(wget -qO- ipinfo.io/ip || curl -sS ipinfo.io/ip)
echo "Checking VPS: $MYIP"
sleep 1
clear

# === Fungsi Bot (placeholder) ===
bot2() {
    echo ">>> Instalasi BOT CYBERVPN - tambahkan perintah instal di sini"
    # contoh:
    # mkdir -p /root/cybervpn
    # cd /root/cybervpn
    # git clone ... .
    # npm install
    # pm2 start index.js --name cybervpn
}

restart-bot2() {
    echo ">>> Restart BOT CYBERVPN"
    # contoh: pm2 restart cybervpn || systemctl restart cybervpn
}

stop-bot2() {
    echo ">>> Stop BOT CYBERVPN"
    # contoh: pm2 stop cybervpn || systemctl stop cybervpn
}

del-bot2() {
    echo ">>> Hapus BOT CYBERVPN"
    # contoh:
    # pm2 delete cybervpn
    # rm -rf /root/cybervpn
}

add-bot() {
    echo ">>> Install Bot KYT - tambahkan perintah instal di sini"
    # contoh:
    # cd /usr/bin/kyt
    # npm install
    # pm2 start index.js --name kyt
}

hapus-bot() {
    echo ">>> Hapus Bot KYT"
    # contoh:
    # systemctl stop kyt
    # systemctl disable kyt
    # rm -rf /usr/bin/kyt
}

stop-bot() {
    echo ">>> Stop Bot KYT"
    # contoh: systemctl stop kyt || pm2 stop kyt
}

restart-bot() {
    echo ">>> Restart Bot KYT"
    # contoh: systemctl restart kyt || pm2 restart kyt
}

# === Tambahan Fungsi Ganti Nama Bot ===
ganti_nama_bot() {
    echo -e "${grenbo}Ini digunakan jika Mau memakai 1bot saja tanpa perlu ${NC}"
    echo -e "${grenbo}memakai banyak bot create ini digunakan untuk create akun ${NC}"
    echo -e "${COLOR1}╰═════════════════════════════════════════════════╯${NC}"
    echo -e ""
    read -e -p "[*] Input Nama Panggilan Botnya : " namabot
    # validate non-empty
    if [ -z "$namabot" ]; then
        echo -e "${RED}Nama bot kosong. Batal.${NC}"
        sleep 1
        return
    fi

    # Backup files before replace (safe-guard)
    timestamp=$(date +%s)
    backup_dir="/root/kyt_backup_${timestamp}"
    mkdir -p "$backup_dir"

    files=(
        "/usr/bin/kyt/modules/menu.py"
        "/usr/bin/kyt/modules/start.py"
        "/usr/bin/kyt/modules/admin.py"
        "/usr/bin/kyt/modules/vmess.py"
        "/usr/bin/kyt/modules/vless.py"
        "/usr/bin/kyt/modules/trojan.py"
        "/usr/bin/kyt/modules/ssh.py"
    )

    for f in "${files[@]}"; do
        if [ -f "$f" ]; then
            cp -a "$f" "${backup_dir}/$(basename "$f")"
        fi
    done

    # Run sed replacements (careful with quoting; we interpolate $namabot)
    # Replace literal 77 -> namabot
    sed -i "s/77/${namabot}/g" /usr/bin/kyt/modules/menu.py 2>/dev/null || true
    sed -i "s/77/${namabot}/g" /usr/bin/kyt/modules/start.py 2>/dev/null || true

    # replace quoted tokens like "sshovpn" -> "sshovpn${namabot}"
    sed -i "s/\"sshovpn\"/\"sshovpn${namabot}\"/g" /usr/bin/kyt/modules/menu.py 2>/dev/null || true
    sed -i "s/\"vmess\"/\"vmess${namabot}\"/g" /usr/bin/kyt/modules/menu.py 2>/dev/null || true
    sed -i "s/\"vless\"/\"vless${namabot}\"/g" /usr/bin/kyt/modules/menu.py 2>/dev/null || true
    sed -i "s/\"trojan\"/\"trojan${namabot}\"/g" /usr/bin/kyt/modules/menu.py 2>/dev/null || true

    # replace dot commands and slashes patterns (.menu|/menu -> .<namabot>|/<namabot>)
    sed -i "s&\\.menu|/menu&.${namabot}|/${namabot}&g" /usr/bin/kyt/modules/menu.py 2>/dev/null || true
    sed -i "s&\\.start|/start&.start${namabot}|/start${namabot}&g" /usr/bin/kyt/modules/start.py 2>/dev/null || true
    sed -i "s&\\.admin|/admin&.admin${namabot}|/admin${namabot}&g" /usr/bin/kyt/modules/admin.py 2>/dev/null || true

    # byte-string patterns b'start' etc.
    sed -i "s/b'start'/b'start${namabot}'/g" /usr/bin/kyt/modules/start.py 2>/dev/null || true
    sed -i "s/b'admin'/b'admin${namabot}'/g" /usr/bin/kyt/modules/admin.py 2>/dev/null || true
    sed -i "s/b'menu'/b'${namabot}'/g" /usr/bin/kyt/modules/menu.py 2>/dev/null || true
    sed -i "s/b'menu'/b'${namabot}'/g" /usr/bin/kyt/modules/start.py 2>/dev/null || true

    # admin command names
    sed -i "s/add-ip/add-ip${namabot}/g" /usr/bin/kyt/modules/admin.py 2>/dev/null || true
    sed -i "s/change-ip/change-ip${namabot}/g" /usr/bin/kyt/modules/admin.py 2>/dev/null || true
    sed -i "s/add-key/add-key${namabot}/g" /usr/bin/kyt/modules/admin.py 2>/dev/null || true

    # prefix replacements like 7- -> <namabot>-
    sed -i "s/7-/${namabot}-/g" /usr/bin/kyt/modules/vmess.py 2>/dev/null || true
    sed -i "s/7-/${namabot}-/g" /usr/bin/kyt/modules/vless.py 2>/dev/null || true
    sed -i "s/7-/${namabot}-/g" /usr/bin/kyt/modules/trojan.py 2>/dev/null || true
    sed -i "s/7-/${namabot}-/g" /usr/bin/kyt/modules/ssh.py 2>/dev/null || true

    # python byte string vmess/vless/trojan/ssh
    sed -i "s/b'vmess'/b'vmess${namabot}'/g" /usr/bin/kyt/modules/vmess.py 2>/dev/null || true
    sed -i "s/b'vless'/b'vless${namabot}'/g" /usr/bin/kyt/modules/vless.py 2>/dev/null || true
    sed -i "s/b'trojan'/b'trojan${namabot}'/g" /usr/bin/kyt/modules/trojan.py 2>/dev/null || true
    sed -i "s/b'sshovpn'/b'sshovpn${namabot}'/g" /usr/bin/kyt/modules/ssh.py 2>/dev/null || true

    # replace "menu" string with namabot in several modules
    sed -i "s/\"menu\"/\"${namabot}\"/g" /usr/bin/kyt/modules/vmess.py 2>/dev/null || true
    sed -i "s/\"menu\"/\"${namabot}\"/g" /usr/bin/kyt/modules/vless.py 2>/dev/null || true
    sed -i "s/\"menu\"/\"${namabot}\"/g" /usr/bin/kyt/modules/trojan.py 2>/dev/null || true
    sed -i "s/\"menu\"/\"${namabot}\"/g" /usr/bin/kyt/modules/ssh.py 2>/dev/null || true
    sed -i "s/\"menu\"/\"${namabot}\"/g" /usr/bin/kyt/modules/menu.py 2>/dev/null || true

    clear
    echo -e "${BIGreen}Succes Ganti Nama Panggilan BOT Telegram${NC}"
    echo -e "Kalau Mau Panggil Menu botnya Ketik .${namabot} atau /${namabot}"
    echo -e "Kalau Mau Panggil Start botnya Ketik .start${namabot} atau /start${namabot}"

    # Attempt restart service (if exists)
    if systemctl list-units --full -all | grep -Fq "kyt.service"; then
        systemctl restart kyt 2>/dev/null || true
    else
        # try pm2 restart
        if command -v pm2 >/dev/null 2>&1; then
            pm2 restart kyt 2>/dev/null || true
        fi
    fi

    read -n 1 -s -r -p "Press any key to back on menu"
}

# === Tampilan Menu ===
display_menu() {
    LIGHTGREEN="\033[1;32m"
    NC="\033[0m"
    echo -e "\033[1;32m──────────────────────────────────────────\033[0m"
    echo -e "\e[44;97;1m               BOT TELEGRAM               $NC"
    echo -e "\033[1;32m anda bisa mengunakan bot simpel untuk\033[0m"
    echo -e "\033[1;32m membuat akun lewat telegram silahkan\033[0m"
    echo -e "\033[1;32m anda buat bot di telegram cari bot\033[0m"
    echo -e "\033[1;32m @BotFather silahkan buat bot anda ambil\033[0m"
    echo -e "\033[1;32m token&id anda untuk cek id\033[0m"
    echo -e "\033[1;32m @CekIDTelegram_bot\033[0m"
    echo -e "\033[1;32m──────────────────────────────────────────\033[0m"
    echo -e "  ${LIGHTGREEN}[1].${NC}\033[1;97m Install Bot Reseller${NC}"
    echo -e "  ${LIGHTGREEN}[2].${NC}\033[1;97m Restart Bot Reseller${NC}"
    echo -e "  ${LIGHTGREEN}[3].${NC}\033[1;97m Stop Bot Reseller${NC}"
    echo -e "  ${LIGHTGREEN}[4].${NC}\033[1;97m Hapus Bot Reseller${NC}"
    echo -e "\033[1;32m──────────────────────────────────────────\033[0m"
    echo -e "  ${LIGHTGREEN}[5].${NC}\033[1;97m Install Bot private${NC}"
    echo -e "  ${LIGHTGREEN}[6].${NC}\033[1;97m Hapus Bot private${NC}"
    echo -e "  ${LIGHTGREEN}[7].${NC}\033[1;97m Stop Bot private${NC}"
    echo -e "  ${LIGHTGREEN}[8].${NC}\033[1;97m Restart Bot private${NC}"
    echo -e "  ${LIGHTGREEN}[9].${NC}\033[1;97m (reserved)${NC}"
    echo -e "  ${LIGHTGREEN}[10].${NC}\033[1;97m Ganti Nama Panggilan Bot ${NC}"
    echo -e "  ${LIGHTGREEN}[x].${NC}\033[1;97m Exit ${NC}"
    echo -e "\033[1;32m──────────────────────────────────────────\033[0m"
}

# === Fungsi Utama ===
main() {
    while true; do
        display_menu
        read -p "Select From Options [ 1 - 10 or x ] : " menu
        echo -e ""
        case $menu in
            1) bot2 ;;
            2) restart-bot2 ;;
            3) stop-bot2 ;;
            4) del-bot2 ;;
            5) add-bot ;;
            6) hapus-bot ;;
            7) stop-bot ;;
            8) restart-bot ;;
            9) echo "Pilihan 9 reserved." ;;
            10) ganti_nama_bot ;;
            x|X) echo "Exiting..."; break ;;
            *) echo "Pilihan tidak valid." ;;
        esac
        echo -e "\n"
    done
}

# Run
main