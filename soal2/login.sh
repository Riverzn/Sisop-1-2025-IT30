#!/bin/bash

DATA_FILE="/data/player.csv"
SALT="ArcaeaSALT2025"

mkdir -p /data
touch "$DATA_FILE"

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

clear
echo -e "${BLUE}======================================"
echo -e "        🔑 Login Player              "
echo -e "======================================${NC}"

read -p "Masukkan Email: " email
read -s -p "Masukkan Password: " password
echo ""

# Hash password yang dimasukkan
password_hash=$(echo -n "${password}${SALT}" | sha256sum | awk '{print $1}')

if grep -q "^$email,.*,$password_hash$" "$DATA_FILE"; then
    echo -e "${GREEN}✅ Login berhasil! Selamat datang kembali! 🎉${NC}"
else
    echo -e "${RED}❌ Error: Email atau Password salah.${NC}"
    exit 1
fi
