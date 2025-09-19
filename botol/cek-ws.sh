#!/bin/bash

# Fungsi untuk mengonversi byte menjadi format yang lebih mudah dibaca
function konversi() {
    local -i byte=$1
    if (( byte < 1024 )); then
        echo "${byte}B"
    elif (( byte < 1048576 )); then
        echo "$(( (byte + 1023) / 1024 ))KB"
    elif (( byte < 1073741824 )); then
        echo "$(( (byte + 1048575) / 1048576 ))MB"
    else
        echo "$(( (byte + 1073741823) / 1073741824 ))GB"
    fi
}

# Bersihkan layar dan file sementara
clear
> /tmp/other.txt

# Ambil daftar akun VMess dari file konfigurasi
akun=($(grep -E "^###" "/etc/xray/config.json" | cut -d ' ' -f 2 | sort -u))

# Proses setiap akun VMess
for user in "${akun[@]}"; do
    # Lewatkan jika akun kosong
    [[ -z "$user" ]] && continue  

    # Siapkan file sementara untuk menyimpan IP
    > /tmp/ipvmess.txt

    # Ambil 500 entri log akses terakhir dan ekstrak IP unik untuk akun
    ip_list=($(grep -w "$user" /var/log/xray/access.log | tail -n 500 | awk '{print $3}' | sed 's/tcp://g' | cut -d ":" -f 1 | sort -u))

    # Proses setiap IP dan simpan ke file sementara
    for ip in "${ip_list[@]}"; do
        if grep -qw "$ip" /var/log/xray/access.log; then
            echo "$ip" >> /tmp/ipvmess.txt
        else
            echo "$ip" >> /tmp/other.txt
        fi
    done

    # Jika ada IP yang terkait dengan akun ini, tampilkan informasi
    if [[ -s /tmp/ipvmess.txt ]]; then
        # Ambil waktu login terakhir
        lastlogin=$(journalctl -u xray --no-pager | grep -w "$user" | tail -n 1 | awk '{print $1, $2}')
        [[ -z "$lastlogin" ]] && lastlogin=$(grep -w "$user" /var/log/xray/access.log | tail -n 1 | awk '{print $2}')

        

        # Tampilkan informasi akun
        echo "Pengguna: ${user}"
        echo "Waktu Login Terakhir: ${lastlogin}"
        echo "Kuota Penggunaan: ${lim}"
        echo "Kuota Limit: ${gb}"
        echo "Batas IP: $iplimit"
        echo "Jumlah IP Login Unik: $jumlah_ip"
      
        # Tampilkan daftar IP yang login
        nl /tmp/ipvmess.txt
        echo ""
    fi
done

# Hapus file sementara setelah selesai
rm -f /tmp/other.txt /tmp/ipvmess.txt
