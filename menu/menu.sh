#!/bin/bash

BURIQ () {
    # Mengunduh daftar register dari URL baru dan menyimpannya ke dalam file sementara
    curl -sS https://raw.githubusercontent.com/scriswan/pgetunnel/main/register > /root/tmp
    
    # Mendapatkan IP pengguna saat ini
    MYIP=$(curl -sS ipv4.icanhazip.com)
    
    # Mencari entri yang memiliki IP yang sama dengan pengguna saat ini
    entry=$(grep -E " $MYIP" /root/tmp)
    
    # Jika entri ditemukan, proses tanggal kedaluwarsa
    if [[ -n "$entry" ]]; then
        # Mengambil nama pengguna dan tanggal kedaluwarsa dari entri tersebut
        user=$(echo "$entry" | awk '{print $2}')
        exp=$(echo "$entry" | awk '{print $3}')
        
        # Mengonversi tanggal kedaluwarsa dan tanggal hari ini ke detik sejak epoch
        d1=$(date -d "$exp" +%s)
        d2=$(date +%s) # Hari ini
        
        # Menghitung selisih hari antara hari ini dan tanggal kedaluwarsa
        exp2=$(( (d1 - d2) / 86400 ))
        
        # Jika waktu habis (expired)
        if [[ "$exp2" -le "0" ]]; then
            echo $user > /etc/.$user.ini
        else
            rm -f /etc/.$user.ini > /dev/null 2>&1
        fi
    fi

    # Menghapus file sementara
    rm -f /root/tmp
}

# Mendapatkan IP pengguna saat ini
MYIP=$(curl -sS ipv4.icanhazip.com)

# Mendapatkan nama berdasarkan IP yang sesuai di file register
Name=$(curl -sS https://raw.githubusercontent.com/scriswan/pgetunnel/main/register | grep $MYIP | awk '{print $2}')

# Menyimpan nama ke file .ini untuk pemeriksaan izin
echo $Name > /usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)

Bloman () {
    # Memeriksa apakah file izin untuk user ada
    if [ -f "/etc/.$Name.ini" ]; then
        CekTwo=$(cat /etc/.$Name.ini)
        
        # Memeriksa apakah nama pada file izin cocok
        if [ "$CekOne" = "$CekTwo" ]; then
            res="Expired"
        fi
    else
        res="Permission Accepted..."
    fi
}

PERMISSION () {
    # Mendapatkan IP pengguna
    MYIP=$(curl -sS ipv4.icanhazip.com)
    
    # Memeriksa apakah IP ada di daftar register
    IZIN=$(curl -sS https://raw.githubusercontent.com/scriswan/pgetunnel/main/register | awk '{print $4}' | grep $MYIP)
    
    if [ "$MYIP" = "$IZIN" ]; then
        Bloman
    else
        res="Permission Denied!"
    fi
    
    BURIQ
}

# Menjalankan fungsi PERMISSION untuk memulai
PERMISSION
if [ "$res" = "Expired" ]; then
Exp="\e[36mExpired\033[0m"
else
Exp=$(curl -sS https://raw.githubusercontent.com/scriswan/pgetunnel/main/register | grep $MYIP | awk '{print $3}')
fi
vlx=$(grep -c -E "^#& " "/etc/xray/config.json")
let vla=$vlx/2
vmc=$(grep -c -E "^### " "/etc/xray/config.json")
let vma=$vmc/2
ssh1="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
trx=$(grep -c -E "^#! " "/etc/xray/config.json")
let tra=$trx/2
ssx=$(grep -c -E "^## " "/etc/xray/config.json")
let ssa=$ssx/2
UDPX="https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1S3IE25v_fyUfCLslnujFBSBMNunDHDk2' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1S3IE25v_fyUfCLslnujFBSBMNunDHDk2"
# Fungsi Anti DC dengan Ping
anti_dc () {
    while true; do
        # Mengirim ping ke server atau IP tertentu
        ping -c 1 8.8.8.8 > /dev/null
        
        # Menunggu beberapa detik sebelum mengirim ping lagi
        sleep 10
    done
}

# Jalankan anti_dc di background
anti_dc &

BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White
UWhite='\033[4;37m'       # White
On_IPurple='\033[0;105m'  #
On_IRed='\033[0;101m'
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White
w="\033[97m"
ORANGE="\033[0;34m"
NC='\e[0m'
dtoday="$(vnstat -i eth0 | grep "today" | awk '{print $2" "substr ($3, 1, 1)}')"
utoday="$(vnstat -i eth0 | grep "today" | awk '{print $5" "substr ($6, 1, 1)}')"
ttoday="$(vnstat -i eth0 | grep "today" | awk '{print $8" "substr ($9, 1, 1)}')"
dyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $2" "substr ($3, 1, 1)}')"
uyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $5" "substr ($6, 1, 1)}')"
tyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $8" "substr ($9, 1, 1)}')"
dmon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $3" "substr ($4, 1, 1)}')"
umon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $6" "substr ($7, 1, 1)}')"
tmon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $9" "substr ($10, 1, 1)}')"
clear
tram=$( free -h | awk 'NR==2 {print $2}' )
uram=$( free -h | awk 'NR==2 {print $3}' )
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
cpu_usage="$((${cpu_usage1/\.*} / ${corediilik:-1}))"
cpu_usage+=" %"
total_ram=` grep "MemTotal: " /proc/meminfo | awk '{ print $2}'`
totalram=$(($total_ram/1024))
persenmemori="$(echo "scale=2; $usmem*100/$tomem" | bc)"
persencpu="$(echo "scale=2; $cpu1+$cpu2" | bc)"
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHT='\033[0;37m'
export NC='\033[0m'
export EROR="[${RED} EROR ${NC}]"
export INFO="[${YELLOW} INFO ${NC}]"
export OKEY="[${GREEN} OKEY ${NC}]"
export PENDING="[${YELLOW} PENDING ${NC}]"
export SEND="[${YELLOW} SEND ${NC}]"
export RECEIVE="[${YELLOW} RECEIVE ${NC}]"
export BOLD="\e[1m"
export WARNING="${RED}\e[5m"
export UNDERLINE="\e[4m"
clear
clear && clear && clear
clear;clear;clear
cek=$(service ssh status | grep active | cut -d ' ' -f5)
if [ "$cek" = "active" ]; then
stat=-f5
else
stat=-f7
fi
ssh=$(service ssh status | grep active | cut -d ' ' $stat)
if [ "$ssh" = "active" ]; then
ressh="${green}ON${NC}"
else
ressh="${red}OFF${NC}"
fi
sshstunel=$(service stunnel4 status | grep active | cut -d ' ' $stat)
if [ "$sshstunel" = "active" ]; then
resst="${green}ON${NC}"
else
resst="${red}OFF${NC}"
fi
sshws=$(service ws-stunnel status | grep active | cut -d ' ' $stat)
if [ "$sshws" = "active" ]; then
ressshws="${green}ON${NC}"
else
ressshws="${red}OFF${NC}"
fi
ngx=$(service nginx status | grep active | cut -d ' ' $stat)
if [ "$ngx" = "active" ]; then
resngx="${green}ON${NC}"
else
resngx="${red}OFF${NC}"
fi
dbr=$(service dropbear status | grep active | cut -d ' ' $stat)
if [ "$dbr" = "active" ]; then
resdbr="${green}ON${NC}"
else
resdbr="${red}OFF${NC}"
fi
v2r=$(service xray status | grep active | cut -d ' ' $stat)
if [ "$v2r" = "active" ]; then
resv2r="${green}ON${NC}"
else
resv2r="${red}OFF${NC}"
fi
function addhost(){
clear
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
read -rp "Domain/Host: " -e host
echo ""
if [ -z $host ]; then
echo "????"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
read -n 1 -s -r -p "Press any key to back on menu"
setting-menu
else
echo "IP=$host" > /var/lib/scrz-prem/ipvps.conf
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo "Dont forget to renew cert"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
fi
}
function genssl(){
clear
systemctl stop nginx
domain=$(cat /var/lib/scrz-prem/ipvps.conf | cut -d'=' -f2)
Cek=$(lsof -i:80 | cut -d' ' -f1 | awk 'NR==2 {print $1}')
if [[ ! -z "$Cek" ]]; then
sleep 1
echo -e "[ ${red}WARNING${NC} ] Detected port 80 used by $Cek "
systemctl stop $Cek
sleep 2
echo -e "[ ${green}INFO${NC} ] Processing to stop $Cek "
sleep 1
fi
echo -e "[ ${green}INFO${NC} ] Starting renew cert... "
sleep 2
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
echo -e "[ ${green}INFO${NC} ] Renew cert done... "
sleep 2
echo -e "[ ${green}INFO${NC} ] Starting service $Cek "
sleep 2
echo $domain > /etc/xray/domain
systemctl restart xray
systemctl restart nginx
echo -e "[ ${green}INFO${NC} ] All finished... "
sleep 0.5
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
}
# Date
DATE=$(date +'%d %B %Y')
datediff() {
d1=$(date -d "$1" +%s)
d2=$(date -d "$2" +%s)
# Get system uptime
uptime_info=$(uptime -p | sed 's/up //')
}
mai="datediff "$Exp" "$DATE""
export sem=$( curl -s https://raw.githubusercontent.com/scriswan/pgetunnel/main/version)
export pak=$( cat /home/.ver)
IPVPS=$(curl -s ipinfo.io/ip )
clear
# Warna
BICyan="\033[1;96m"
BIWhite="\033[1;97m"
BIYellow="\033[1;93m"
NC="\033[0m"

# Informasi sistem
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')       # CPU usage %
totalram=$(free -m | awk '/Mem:/ {print $2}')                      # Total RAM
uram=$(free -m | awk '/Mem:/ {print $3}')                          # RAM Terpakai
tram=$(free -m | awk '/Swap:/ {print $2}')                          # Swap Total

# Domain dan IP
DOMAIN=$(cat /etc/xray/domain 2>/dev/null)
IPVPS=$(curl -s ipinfo.io/ip)

# ISP dan Kota/Negara berdasarkan IP VPS
ISP=$(curl -s https://ipinfo.io/$IPVPS/org | cut -d' ' -f2-)
CITY=$(curl -s https://ipinfo.io/$IPVPS/city)
COUNTRY=$(curl -s https://ipinfo.io/$IPVPS/country)

#!/bin/bash
# ==================== TRAFFIC INFO =====================

# Pilih interface utama
iface=$(ip route get 1.1.1.1 2>/dev/null | awk '{for(i=1;i<=NF;i++) if($i=="dev"){print $(i+1);exit}}')
[ -z "$iface" ] && iface="eth0"

# Fungsi ubah bytes ke format human readable
human() {
  awk -v b="$1" 'BEGIN{
    kib=1024; mib=kib*kib; gib=mib*kib;
    if(b>=gib) printf "%.2f GiB", b/gib;
    else if(b>=mib) printf "%.2f MiB", b/mib;
    else if(b>=kib) printf "%.2f KiB", b/kib;
    else printf "%d B", b;
  }'
}

if command -v vnstat >/dev/null 2>&1; then
  today=$(vnstat -i "$iface" | awk '/today/ {print $2" "$3}')
  yesterday=$(vnstat -i "$iface" | awk '/yesterday/ {print $2" "$3}')
  month=$(vnstat -i "$iface" | grep "$(date +%b)" | head -n1 | awk '{print $2" "$3}')
  total=$(vnstat -i "$iface" | awk '/total/ {print $2" "$3}')
else
  # --- fallback snapshot ---
  TRAFFIC_DIR="/var/log/pgetunnel/traffic"
  mkdir -p "$TRAFFIC_DIR"

  rx_file="/sys/class/net/$iface/statistics/rx_bytes"
  tx_file="/sys/class/net/$iface/statistics/tx_bytes"

  cur=$(( $(cat "$rx_file") + $(cat "$tx_file") ))

  today_file="$TRAFFIC_DIR/$(date +%F).snap"
  start_file="$TRAFFIC_DIR/$(date +%F).start"

  [ ! -f "$start_file" ] && echo "$cur" > "$start_file"
  echo "$cur" > "$today_file"

  start_cur=$(cat "$start_file")
  today_bytes=$((cur - start_cur))
  [ "$today_bytes" -lt 0 ] && today_bytes=$cur

  # yesterday
  yfile_start="$TRAFFIC_DIR/$(date -d "yesterday" +%F).start"
  yfile_end="$TRAFFIC_DIR/$(date -d "yesterday" +%F).snap"
  if [ -f "$yfile_start" ] && [ -f "$yfile_end" ]; then
    ystart=$(cat "$yfile_start")
    yend=$(cat "$yfile_end")
    yesterday_bytes=$((yend - ystart))
    [ "$yesterday_bytes" -lt 0 ] && yesterday_bytes=$yend
  else
    yesterday_bytes=0
  fi

  # month
  month_bytes=0
  for f in "$TRAFFIC_DIR"/$(date +%Y-%m)-*.start; do
    [ ! -f "$f" ] && continue
    day=$(basename "$f" .start)
    s=$(cat "$f")
    efile="$TRAFFIC_DIR/$day.snap"
    if [ -f "$efile" ]; then
      e=$(cat "$efile")
      delta=$((e - s))
      [ "$delta" -lt 0 ] && delta=$e
      month_bytes=$((month_bytes + delta))
    fi
  done

  # total (lifetime)
  lifetime_file="$TRAFFIC_DIR/total.bytes"
  [ ! -f "$lifetime_file" ] && echo "$cur" > "$lifetime_file"
  prev_total=$(cat "$lifetime_file")
  echo "$cur" > "$lifetime_file"
  total_bytes=$((prev_total + today_bytes))

  today=$(human "$today_bytes")
  yesterday=$(human "$yesterday_bytes")
  month=$(human "$month_bytes")
  total=$(human "$total_bytes")
fi
# =======================================================

# Warna
NC='\e[0m'
BICyan='\e[96;1m'
BIYellow='\e[93;1m'
BIGold='\e[38;5;220;1m'
BIWhite='\e[97;1m'
Blue='\e[94;1m'

# Dummy variabel (isi sesuai kebutuhanmu)
totalram=$(free -m | awk '/Mem:/ {print $2}')
cpu_usage=$(top -bn1 | awk '/Cpu/ {print 100 - $8"%"}')
DOMAIN="example.com"
IPVPS=$(curl -s ipv4.icanhazip.com)
ISP=$(curl -s ipinfo.io/org | sed 's/"/ /g')
CITY=$(curl -s ipinfo.io/city)
COUNTRY=$(curl -s ipinfo.io/country)

# Tampilan Info VPS
echo -e "${BICyan} ┌─────────────────────────────────────────────────────┐${NC}"
echo -e "${BICyan} │           ${BIGold}WELCOME TO SCRIPT PGETUNNEL STORE${NC}"
echo -e "${BICyan} │${NC}"
echo -e "${BICyan} │  OS        : ${BIWhite}$(grep -w PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '\"') ( $(uname -m) )${NC}"
echo -e "${BICyan} │  RAM & CPU : ${BIWhite}$totalram MB : $cpu_usage${NC}"
echo -e "${BICyan} │  DOMAIN    : ${BIWhite}$DOMAIN${NC}"
echo -e "${BICyan} │  IP VPS    : ${BIWhite}$IPVPS${NC}"
echo -e "${BICyan} │  ISP       : ${BIWhite}$ISP${NC}"
echo -e "${BICyan} │  KOTA      : ${BIWhite}$CITY, $COUNTRY${NC}"
echo -e "${BICyan} │  REBOOT    : ${BIWhite}02:00 ( Jam 2 Malam )${NC}"
echo -e "${BICyan} │  Today:${BIWhite} $today ${NC}Yesterday:${BIWhite} $yesterday${NC}"
echo -e "${BICyan} │  Month:${BIWhite} $month ${NC}Total:${BIWhite} $total${NC}"
echo -e "${BICyan} └─────────────────────────────────────────────────────┘${NC}"

# Jumlah Akun
echo -e "${BICyan} ┌─────────────────────────────────────────────────────┐${NC}"
echo -e "${BICyan} │  ${BIYellow}SSH         VMESS           VLESS          TROJAN${NC}"
echo -e "${BICyan} │  ${BIWhite}$ssh1           $vma             $vla             $tra${NC}"
echo -e "${BICyan} └─────────────────────────────────────────────────────┘${NC}"

# Status Service
echo -e "   ${BICyan}SSH ${NC}: $ressh   ${BICyan}NGINX ${NC}: $resngx   ${BICyan}XRAY ${NC}: $resv2r   ${BICyan}TROJAN ${NC}: $resv2r"
echo -e "   ${BICyan}STUNNEL ${NC}: $resst   ${BICyan}DROPBEAR ${NC}: $resdbr   ${BICyan}SSH-WS ${NC}: $ressshws"

# Menu
echo -e "${BICyan} ┌─────────────────────────────────────────────────────┐${NC}"
echo -e "${BICyan} │  [${BIWhite}01${BICyan}] SSH        [${BIYellow}Menu${BICyan}]    [${BIWhite}08${BICyan}] ADD-HOST      [${BIYellow}Menu${BICyan}]${NC}"
echo -e "${BICyan} │  [${BIWhite}02${BICyan}] VMESS      [${BIYellow}Menu${BICyan}]    [${BIWhite}09${BICyan}] RUNNING       [${BIYellow}Menu${BICyan}]${NC}"
echo -e "${BICyan} │  [${BIWhite}03${BICyan}] VLESS      [${BIYellow}Menu${BICyan}]    [${BIWhite}10${BICyan}] INSTALL UDP   [${BIYellow}Menu${BICyan}]${NC}"
echo -e "${BICyan} │  [${BIWhite}04${BICyan}] TROJAN     [${BIYellow}Menu${BICyan}]    [${BIWhite}11${BICyan}] INSTALL BOT   [${BIYellow}Menu${BICyan}]${NC}"
echo -e "${BICyan} │  [${BIWhite}05${BICyan}] SETTING    [${BIYellow}Menu${BICyan}]    [${BIWhite}12${BICyan}] BANDWIDTH     [${BIYellow}Menu${BICyan}]${NC}"
echo -e "${BICyan} │  [${BIWhite}06${BICyan}] TRIAL      [${BIYellow}Menu${BICyan}]    [${BIWhite}13${BICyan}] MENU THEME    [${BIYellow}Menu${BICyan}]${NC}"
echo -e "${BICyan} │  [${BIWhite}07${BICyan}] BACKUP     [${BIYellow}Menu${BICyan}]    [${BIWhite}14${BICyan}] UPDATE SCRIPT [${BIYellow}Menu${BICyan}]${NC}"
echo -e "${BICyan} └─────────────────────────────────────────────────────┘${NC}"

# Informasi Lisensi
DATE=$(date +'%d %B %Y')
datediff() {
    d1=$(date -d "$1" +%s)
    d2=$(date -d "$2" +%s)
    echo -e "${BICyan} │${NC} License Script : ${BIWhite}$(cat /usr/bin/e) $(( (d1 - d2) / 86400 )) Days${NC}"
}
mai="datediff "$Exp" "$DATE""

echo -e "${BICyan} ┌─────────────────────────────────────────────────────┐${NC}"
echo -e "${BICyan} │${NC} Version Script : ${BIWhite}$(cat /opt/.ver)${NC}   Last Update"
echo -e "${BICyan} │${NC} Username       : ${BIWhite}$Name${NC}"
if [ $exp -lt 1000 ]; then
    echo -e "${BICyan} │${NC} License Script : ${BIWhite}$sisa_hari${NC} Days Tersisa"
else
    datediff "$Exp" "$DATE"
fi
echo -e "${BICyan} └─────────────────────────────────────────────────────┘${NC}"

echo -e ""
read -p "               Pilih Nomor └╼>>>  bro: " opt
echo -e ""
case $opt in
1) clear ; menu-ssh ;;
2) clear ; menu-vmess ;;
3) clear ; menu-vless ;;
4) clear ; menu-trojan ;;
5) clear ; menu-set ;;
6) clear ; menu-trial ;;
7) clear ; menu-backup ;;
8) clear ; add-host ;;
9) clear ; running ;;
10) clear ; wget https://raw.githubusercontent.com/scriswan/pgetunnel/main/files/udp-custom.sh && chmod +x udp-custom.sh && ./udp-custom.sh ;;
11) clear ; menu-bot ;;
12) clear ; bw ;;
13) clear ; menu-theme ;;
14) clear ; update ;;
0) clear ; menu ;;
x) exit ;;
*) echo -e "" ; echo "Press any key to back exit" ; sleep 1 ; exit ;;
esac
