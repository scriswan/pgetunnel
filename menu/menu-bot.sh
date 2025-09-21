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

# Exporting Language to UTF-8
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'

# -------------------------------
# Tampilan Menu
# -------------------------------
function display_menu {
    LIGHTGREEN="\033[1;32m"
    NC="\033[0m"

    echo -e "\033[1;32m──────────────────────────────────────────\033[0m"
    echo -e "\e[44;97;1m               BOT TELEGRAM               $NC"
    echo -e "\033[1;32m Anda bisa mengunakan bot untuk membuat akun\033[0m"
    echo -e "\033[1;32m lewat telegram. Silahkan buat bot di\033[0m"
    echo -e "\033[1;32m @BotFather, ambil token & cek ID via\033[0m"
    echo -e "\033[1;32m @CekIDTelegram_bot.\033[0m"
    echo -e "\033[1;32m──────────────────────────────────────────\033[0m"
    echo -e "  ${LIGHTGREEN}[1].${NC}\033[1;97m Install Bot Reseller${NC}"
    echo -e "  ${LIGHTGREEN}[2].${NC}\033[1;97m Restart Bot Reseller${NC}"
    echo -e "  ${LIGHTGREEN}[3].${NC}\033[1;97m Stop Bot Reseller${NC}"
    echo -e "  ${LIGHTGREEN}[4].${NC}\033[1;97m Hapus Bot Reseller${NC}"
    echo -e "  ${LIGHTGREEN}[5].${NC}\033[1;97m Install Bot Private${NC}"
    echo -e "  ${LIGHTGREEN}[6].${NC}\033[1;97m Hapus Bot Private${NC}"
    echo -e "  ${LIGHTGREEN}[7].${NC}\033[1;97m Stop Bot Private${NC}"
    echo -e "  ${LIGHTGREEN}[8].${NC}\033[1;97m Restart Bot Private${NC}"
    echo -e "  ${LIGHTGREEN}[9].${NC}\033[1;97m Ganti Custom Command Bot${NC}"
    echo -e "  ${LIGHTGREEN}[x].${NC}\033[1;97m Exit ${NC}"
    echo -e "\033[1;32m──────────────────────────────────────────\033[0m"
}

# -------------------------------
# Fungsi utama
# -------------------------------
function main {
    while true; do
        display_menu
        read -p "Select From Options [ 1 - 9 or x ] : " menu
        echo -e ""

        case $menu in
            1) echo "Installing BOT CYBERVPN..."; bot2 ;;
            2) echo "Restarting BOT CYBERVPN..."; restart-bot2 ;;
            3) echo "Stopping BOT CYBERVPN..."; stop-bot2 ;;
            4) echo "Uninstalling BOT CYBERVPN..."; del-bot2 ;;
            5) echo "Installing Bot KYT..."; add-bot ;;
            6) echo "Hapus Bot KYT..."; hapus-bot ;;
            7) echo "Stopping Bot KYT..."; stop-bot ;;
            8) echo "Restarting Bot KYT..."; restart-bot ;;
            9)
                read -p "Masukkan command baru (contoh: menu / panel / akses): " cmd
                echo "$cmd" > /etc/bot_command.conf
                echo "✅ Custom command bot disimpan: $cmd"
                ;;
            x) echo "Exiting..."; break ;;
            *) echo "Pilihan tidak valid." ;;
        esac
        echo -e "\n"
    done
}

# Jalankan fungsi utama
main