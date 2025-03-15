# Dokumentasi Sisop modul 1 ; soal_2

## register.sh :

### 1. Persiapan data
Membuat folder /data untuk menyimpan database player
```sh
#!/bin/bash

DATA_FILE="/data/player.csv"
SALT="ArcaeaSALT2025"

mkdir -p /data
touch "$DATA_FILE"
```
### 2. Main Menu
Membaca email, usn, dan password dalam terminal
```sh
clear
echo -e "${BLUE}======================================"
echo -e "        🎮 Register Player           "
echo -e "======================================${NC}"

read -p "Masukkan Email: " email
read -p "Masukkan Username: " username
read -s -p "Masukkan Password: " password
echo ""
```
```sh
if ! [[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
    echo -e "${RED}❌ Error: Format email tidak valid!${NC}"
    exit 1
fi

# Validasi password, password setidaknya memiliki 1 huruf besar,huruf kecil, dan angka. password minimal 8 karakter [-ge 8]
if ! [[ "$password" =~ [A-Z] && "$password" =~ [a-z] && "$password" =~ [0-9] && ${#password} -ge 8 ]]; then
    echo -e "${RED}❌ Error: Password harus minimal 8 karakter, memiliki huruf besar, huruf kecil, dan angka.${NC}"
    exit 1
fi
```

```sh
# Cek email apakah sudah terdaftar dalam /data/player.csv, apabila tidak ada proses dilanjutkan
if grep -q "^$email," "$DATA_FILE"; then
    echo -e "${RED}❌ Error: Email sudah terdaftar!${NC}"
    exit 1
fi
```
Hashing password menggunakan sha256sum dan memakai static salt.
```sh
password_hash=$(echo -n "${password}${SALT}" | sha256sum | awk '{print $1}')
```
Apabila semua contidional terpenuhi, proses dilanjutkan dan data akan tersimpan ke /data/player.csv
```sh
# simpan data ke player.csv file
echo "$email,$username,$password_hash" >> "$DATA_FILE"

echo -e "${GREEN}✅ Registrasi berhasil! Selamat datang, ${username}! 🎉${NC}"
```

## login.sh
### 1. Main menu
```sh
#!/bin/bash

DATA_FILE="/data/player.csv"
SALT="ArcaeaSALT2025"

mkdir -p /data
touch "$DATA_FILE"

clear
echo -e "${BLUE}======================================"
echo -e "        🔑 Login Player              "
echo -e "======================================${NC}"

read -p "Masukkan Email: " email
read -s -p "Masukkan Password: " password
echo ""
```
Mengecek apakah email dan password ada dalam database /data/player.csv
```sh
# Hash password yang dimasukkan
password_hash=$(echo -n "${password}${SALT}" | sha256sum | awk '{print $1}')

if grep -q "^$email,.*,$password_hash$" "$DATA_FILE"; then
    echo -e "${GREEN}✅ Login berhasil! Selamat datang kembali! 🎉${NC}"
else
    echo -e "${RED}❌ Error: Email atau Password salah.${NC}"
    exit 1
fi
```

##terminal .sh
###1. 
```sh
```
