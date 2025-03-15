#!/bin/bash

DATA_FILE="/data/player.csv"
SALT="ArcaeaSALT2025"

# Pastikan folder /data/ ada
mkdir -p /data
touch "$DATA_FILE"

# Warna untuk tampilan lebih menarik
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Fungsi animasi loading
loading() {
    echo -n "Processing"
    for i in {1..3}; do
        echo -n "."
        sleep 0.5
    done
    echo ""
}

clear
echo -e "${BLUE}======================================"
echo -e "        🎮 Register Player           "
echo -e "======================================${NC}"

read -p "Masukkan Email: " email
read -p "Masukkan Username: " username
read -s -p "Masukkan Password: " password
echo ""

# Validasi email
if ! [[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
    echo -e "${RED}❌ Error: Format email tidak valid!${NC}"
    exit 1
fi

# Validasi password
if ! [[ "$password" =~ [A-Z] && "$password" =~ [a-z] && "$password" =~ [0-9] && ${#password} -ge 8 ]]; then
    echo -e "${RED}❌ Error: Password harus minimal 8 karakter, memiliki huruf besar, huruf kecil, dan angka.${NC}"
    exit 1
fi

# Cek apakah email sudah terdaftar
if grep -q "^$email," "$DATA_FILE"; then
    echo -e "${RED}❌ Error: Email sudah terdaftar!${NC}"
    exit 1
fi

loading

# Hash password (gunakan SHA-256)
password_hash=$(echo -n "${password}${SALT}" | sha256sum | awk '{print $1}')

# Simpan data ke dalam file CSV
echo "$email,$username,$password_hash" >> "$DATA_FILE"

echo -e "${GREEN}✅ Registrasi berhasil! Selamat datang, ${username}! 🎉${NC}"
