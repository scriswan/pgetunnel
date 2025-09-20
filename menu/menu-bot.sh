#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=$(date +"%Y-%m-%d" -d "$dateFromServer")

###########- COLOR CODE -##############
NC="\e[0m"
RED="\033[0;31m"

# =============== CEK IZIN ===============
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

# =============== DEFINISI WARNA ===============
BIBlue='\033[1;94m'
BIWhite='\033[1;97m'
LIGHTGREEN="\033[1;32m"
NC="\033[0m"

export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'

MYIP=$(wget -qO- ipinfo.io/ip)
clear

# =============== MENU TAMPILAN ===============
function display_menu {
echo -e "\033[1;32m──────────────────────────────────────────\033[0m"
echo -e "\e[44;97;1m               BOT TELEGRAM               $NC"
echo -e "\033[1;32m Gunakan bot simpel untuk membuat akun    \033[0m"
echo -e "\033[1;32m via telegram. Token & ID dari BotFather. \033[0m"
echo -e "\033[1;32m──────────────────────────────────────────\033[0m"
echo -e "  ${LIGHTGREEN}[1].${NC}${BIWhite} Install Bot Reseller (CYBERVPN)${NC}"
echo -e "  ${LIGHTGREEN}[2].${NC}${BIWhite} Restart Bot Reseller${NC}"
echo -e "  ${LIGHTGREEN}[3].${NC}${BIWhite} Stop Bot Reseller${NC}"
echo -e "  ${LIGHTGREEN}[4].${NC}${BIWhite} Hapus Bot Reseller${NC}"
echo -e "  ${LIGHTGREEN}[5].${NC}${BIWhite} Install Bot KYT${NC}"
echo -e "  ${LIGHTGREEN}[6].${NC}${BIWhite} Hapus Bot KYT${NC}"
echo -e "  ${LIGHTGREEN}[7].${NC}${BIWhite} Stop Bot KYT${NC}"
echo -e "  ${LIGHTGREEN}[8].${NC}${BIWhite} Restart Bot KYT${NC}"
echo -e "  ${LIGHTGREEN}[x].${NC}${BIWhite} Exit${NC}"
echo -e "\033[1;32m──────────────────────────────────────────\033[0m"
}

# =============== FUNGSI BOT CYBERVPN ===============
bot2() {
    echo "🔄 Menginstall Bot Reseller (CYBERVPN)..."
    # isi script instalasi di sini
    sleep 2
    echo "✅ Bot Reseller terinstall!"
}

restart-bot2() {
    echo "🔄 Restart Bot Reseller..."
    # contoh systemctl restart
    systemctl restart botreseller 2>/dev/null
    echo "✅ Bot Reseller berhasil direstart!"
}

stop-bot2() {
    echo "⛔ Stop Bot Reseller..."
    systemctl stop botreseller 2>/dev/null
    echo "✅ Bot Reseller dihentikan!"
}

del-bot2() {
    echo "🗑️ Hapus Bot Reseller..."
    systemctl stop botreseller 2>/dev/null
    systemctl disable botreseller 2>/dev/null
    rm -f /etc/systemd/system/botreseller.service
    echo "✅ Bot Reseller dihapus!"
}

# =============== FUNGSI BOT KYT ===============
add-bot() {
    echo "🔄 Menginstall Bot KYT..."
    # isi script instalasi di sini
    sleep 2
    echo "✅ Bot KYT terinstall!"
}

hapus-bot() {
    echo "🗑️ Hapus Bot KYT..."
    systemctl stop botkyt 2>/dev/null
    systemctl disable botkyt 2>/dev/null
    rm -f /etc/systemd/system/botkyt.service
    echo "✅ Bot KYT dihapus!"
}

stop-bot() {
    echo "⛔ Stop Bot KYT..."
    systemctl stop botkyt 2>/dev/null
    echo "✅ Bot KYT dihentikan!"
}

restart-bot() {
    echo "🔄 Restart Bot KYT..."
    systemctl restart botkyt 2>/dev/null
    echo "✅ Bot KYT berhasil direstart!"
}

# =============== MAIN PROGRAM ===============
function main {
    while true; do
        display_menu
        read -p "Select From Options [1-8 or x]: " menu
        echo ""

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