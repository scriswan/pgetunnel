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

# =============== MENU DISPLAY ===============
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
    echo -e "  ${LIGHTGREEN}[1].${NC}\033[1;97m Install Bot Reseller (CYBERVPN)${NC}"
    echo -e "  ${LIGHTGREEN}[2].${NC}\033[1;97m Restart Bot Reseller (CYBERVPN)${NC}"
    echo -e "  ${LIGHTGREEN}[3].${NC}\033[1;97m Stop Bot Reseller (CYBERVPN)${NC}"
    echo -e "  ${LIGHTGREEN}[4].${NC}\033[1;97m Hapus Bot Reseller (CYBERVPN)${NC}"
    echo -e "  ${LIGHTGREEN}[5].${NC}\033[1;97m Install Bot KYT${NC}"
    echo -e "  ${LIGHTGREEN}[6].${NC}\033[1;97m Hapus Bot KYT${NC}"
    echo -e "  ${LIGHTGREEN}[7].${NC}\033[1;97m Stop Bot KYT${NC}"
    echo -e "  ${LIGHTGREEN}[8].${NC}\033[1;97m Restart Bot KYT${NC}"
    echo -e "  ${LIGHTGREEN}[x].${NC}\033[1;97m Exit${NC}"
    echo -e "\033[1;32m──────────────────────────────────────────\033[0m"
}

# =============== PLACEHOLDER FUNCTIONS ===============
function bot2 {
    echo ">> Menjalankan instalasi BOT CYBERVPN..."
    # isi perintah instalasi di sini
}
function restart-bot2 {
    echo ">> Restarting BOT CYBERVPN..."
    # isi perintah restart di sini
}
function stop-bot2 {
    echo ">> Stopping BOT CYBERVPN..."
    # isi perintah stop di sini
}
function del-bot2 {
    echo ">> Menghapus BOT CYBERVPN..."
    # isi perintah uninstall di sini
}

function add-bot {
    echo ">> Install BOT KYT..."
    # isi perintah instalasi di sini
}
function hapus-bot {
    echo ">> Menghapus BOT KYT..."
    # isi perintah uninstall di sini
}
function stop-bot {
    echo ">> Stop BOT KYT..."
    # isi perintah stop di sini
}
function restart-bot {
    echo ">> Restart BOT KYT..."
    # isi perintah restart di sini
}

# =============== MAIN PROGRAM ===============
function main {
    while true; do
        display_menu
        read -p "Select From Options [ 1 - 8 or x ] : " menu
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
            x) echo "Exiting..."; exit 0 ;;
            *) echo "Pilihan tidak valid." ;;
        esac
        echo -e "\n"
    done
}

# Jalankan fungsi utama
main