#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=$(date +"%Y-%m-%d" -d "$dateFromServer")

###########- COLOR CODE -##############
NC="\e[0m"
RED="\033[0;31m"
GREEN="\033[0;32m"
grenbo="\033[1;32m"
COLOR1="\033[1;36m"

# ====== CEK IZIN IP ======
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

# ====== SERVICE KYT ======
function buat_service {
cat > /etc/systemd/system/kyt.service <<EOF
[Unit]
Description=Bot Telegram KYT
After=network.target

[Service]
WorkingDirectory=/usr/bin/kyt
ExecStart=/usr/bin/python3 /usr/bin/kyt/index.py
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reexec
systemctl enable kyt
}

# ====== FUNGSI BOT ======
bot2() {
    echo "Menginstall BOT Reseller..."
    mkdir -p /usr/bin/kyt
    # contoh: taruh file bot di sini
    echo "print('BOT Reseller jalan')" > /usr/bin/kyt/index.py
    chmod +x /usr/bin/kyt/index.py
    buat_service
    systemctl start kyt
    echo "BOT Reseller berhasil diinstall."
}
restart-bot2() { systemctl restart kyt; echo "BOT Reseller berhasil direstart."; }
stop-bot2() { systemctl stop kyt; echo "BOT Reseller berhasil distop."; }
del-bot2() { systemctl stop kyt; rm -rf /usr/bin/kyt; systemctl disable kyt; echo "BOT Reseller berhasil dihapus."; }

add-bot() {
    echo "Menginstall BOT Private..."
    mkdir -p /usr/bin/kyt
    echo "print('BOT Private jalan')" > /usr/bin/kyt/index.py
    chmod +x /usr/bin/kyt/index.py
    buat_service
    systemctl start kyt
    echo "BOT Private berhasil diinstall."
}
hapus-bot() { systemctl stop kyt; rm -rf /usr/bin/kyt; systemctl disable kyt; echo "BOT Private berhasil dihapus."; }
stop-bot() { systemctl stop kyt; echo "BOT Private distop."; }
restart-bot() { systemctl restart kyt; echo "BOT Private direstart."; }

# ====== MENU ======
function display_menu {
echo -e "\033[1;32m──────────────────────────────────────────\033[0m"
echo -e "\e[44;97;1m               BOT TELEGRAM               $NC"
echo -e "\033[1;32m──────────────────────────────────────────\033[0m"
echo -e "  ${GREEN}[1].${NC} Install Bot Reseller"
echo -e "  ${GREEN}[2].${NC} Restart Bot Reseller"
echo -e "  ${GREEN}[3].${NC} Stop Bot Reseller"
echo -e "  ${GREEN}[4].${NC} Hapus Bot Reseller"
echo -e "\033[1;32m──────────────────────────────────────────\033[0m"
echo -e "  ${GREEN}[5].${NC} Install Bot Private"
echo -e "  ${GREEN}[6].${NC} Hapus Bot Private"
echo -e "  ${GREEN}[7].${NC} Stop Bot Private"
echo -e "  ${GREEN}[8].${NC} Restart Bot Private"
echo -e "  ${GREEN}[10].${NC} Custom Nama Panggilan Bot"
echo -e "  ${GREEN}[x].${NC} Exit"
echo -e "\033[1;32m──────────────────────────────────────────\033[0m"
}

# ====== MAIN ======
function main {
    while true; do
        display_menu
        read -p "Select From Options [1-10 or x] : " menu
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
            10)
                echo -e "${grenbo}Ini digunakan jika Mau memakai 1bot saja tanpa perlu ${NC}"
                echo -e "${grenbo}memakai banyak bot create ini digunakan untuk create akun ${NC}"
                echo -e "$COLOR1╰═══════════════════════════════════════╯${NC}"
                echo ""
                read -e -p "[*] Input Nama Panggilan Botnya : " namabot

                sed -i "s/77/${namabot}/g" /usr/bin/kyt/modules/menu.py
                sed -i "s/77/${namabot}/g" /usr/bin/kyt/modules/start.py
                sed -i "s/sshovpn/sshovpn${namabot}/g" /usr/bin/kyt/modules/menu.py
                sed -i "s/vmess/vmess${namabot}/g" /usr/bin/kyt/modules/menu.py
                sed -i "s/vless/vless${namabot}/g" /usr/bin/kyt/modules/menu.py
                sed -i "s/trojan/trojan${namabot}/g" /usr/bin/kyt/modules/menu.py
                systemctl restart kyt

                clear
                echo -e "Succes Ganti Nama Panggilan BOT Telegram"
                echo -e "Kalau Mau Panggil Menu botnya Ketik .${namabot} atau /${namabot}"
                echo -e "Kalau Mau Panggil Start botnya Ketik .start${namabot} atau /start${namabot}"
                read -n 1 -s -r -p "Press any key to back on menu"
                ;;
            x) echo "Exiting..."; exit ;;
            *) echo "Pilihan tidak valid." ;;
        esac
        echo ""
    done
}
main