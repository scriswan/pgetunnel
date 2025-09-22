#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=$(date +"%Y-%m-%d" -d "$dateFromServer")
###########- COLOR CODE -##############
NC="\e[0m"
RED="\033[0;31m"

PERMISSION () {
    MYIP=$(curl -sS ipv4.icanhazip.com)
    IZIN=$(curl -sS https://raw.githubusercontent.com/scriswan/pgetunnel/main/register | awk '{print $4}' | grep $MYIP)
    if [ "$MYIP" = "$IZIN" ]; then
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
elif [ "$res" = "Permission Accepted" ]; then
    echo "Access granted."
else
    echo -e "${RED}Permission Denied!${NC}"
    exit 0
fi

# Color Definitions
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

# Exporting Language to UTF-8
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'

MYIP=$(wget -qO- ipinfo.io/ip)
echo "Checking VPS"

clear

# ===== FUNGSI TAMBAHAN =====
function ganti-nama-bot {
    config_file="/root/bot/config.json"
    if [ ! -f "$config_file" ]; then
        echo "File config tidak ditemukan di $config_file"
        return
    fi
    read -p "Masukkan nama panggilan bot baru: " newname
    sed -i "s/\"bot_name\": \".*\"/\"bot_name\": \"$newname\"/" "$config_file"
    echo "Nama panggilan bot berhasil diganti menjadi: $newname"
}

function tambah-admin {
    config_file="/root/bot/config.json"
    if [ ! -f "$config_file" ]; then
        echo "File config tidak ditemukan di $config_file"
        return
    fi
    read -p "Masukkan Telegram ID admin baru: " adminid
    # Asumsi format JSON punya field "admins": ["id1","id2"]
    sed -i "s/\(\"admins\": \[.*\)\]/\1, \"$adminid\"]/" "$config_file"
    echo "Admin baru berhasil ditambahkan: $adminid"
}

# ===== MENU =====
function display_menu {
    LIGHTGREEN="\033[1;32m"
    NC="\033[0m"  # Reset color

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
    echo -e "  ${LIGHTGREEN}[4].${NC}\033[1;97m Ganti Nama Panggilan Bot (Multi Server)${NC}"
    echo -e "  ${LIGHTGREEN}[5].${NC}\033[1;97m Tambah Admin${NC}"
    echo -e "  ${LIGHTGREEN}[6].${NC}\033[1;97m Install Bot Private${NC}"
    echo -e "  ${LIGHTGREEN}[7].${NC}\033[1;97m Hapus Bot Private${NC}"
    echo -e "  ${LIGHTGREEN}[8].${NC}\033[1;97m Stop Bot Private${NC}"
    echo -e "  ${LIGHTGREEN}[9].${NC}\033[1;97m Restart Bot Private${NC}"
    echo -e "  ${LIGHTGREEN}[x].${NC}\033[1;97m Exit ${NC}"
    echo -e "\033[1;32m──────────────────────────────────────────\033[0m"
}

# ===== MAIN LOOP =====
function main {
    while true; do
        display_menu
        read -p "Select From Options [ 1 - 9 or x ] : " menu
        echo -e ""

        case $menu in
            1)
                echo "Installing BOT CYBERVPN..."
                bot2
                ;;
            2)
                echo "Restarting BOT CYBERVPN..."
                restart-bot2
                ;;
            3)
                echo "Stopping BOT CYBERVPN..."
                stop-bot2
                ;;
            4)
                echo "Mengganti Nama Panggilan Bot..."
                ganti-nama-bot
                ;;
            5)
                echo "Menambah Admin Baru..."
                tambah-admin
                ;;
            6)
                echo "Installing Bot Private..."
                add-bot
                ;;
            7)
                echo "Menghapus Bot Private..."
                hapus-bot
                ;;
            8)
                echo "Stopping Bot Private..."
                stop-bot
                ;;
            9)
                echo "Restarting Bot Private..."
                restart-bot
                ;;
            x)
                echo "Exiting..."
                exit 0
                ;;
            *)
                echo "Pilihan tidak valid."
                ;;
        esac
        echo -e "\n"
    done
}

# Jalankan fungsi utama
main