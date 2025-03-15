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
### Main Menu
```sh
# main menu
while true; do
    clear
    echo -e "${BLUE}======================================"
    echo -e "     🌟 Welcome to Arcaea System     "
    echo -e "======================================${NC}"
    echo -e "1️⃣ Register Account"
    echo -e "2️⃣ Login Account"
    echo -e "3️⃣ Exit Arcaea"
    echo -e "--------------------------------------"
    read -p "Pilih opsi [1-3]: " choice
```
1 ) Jika user memilih 1, maka akan menjalankan script register.sh, yang berisi proses registrasi akun.
```sh
    case $choice in
        1) 
            bash register.sh 
            ;;
```
2 ) Menjalankan script login.sh, lalu menyimpan outputnya ke dalam variabel login_output. Serta Mengecek apakah output login mengandung string "✅ Login berhasil!".
* Jika benar, berarti user berhasil login, dan akan diarahkan ke menu selanjutnya.
* Jika gagal, akan menampilkan pesan error dan kembali ke menu utama setelah 2 detik.
```sh
        2) 
            login_output=$(bash login.sh)
            if [[ $login_output == *"✅ Login berhasil!"* ]]; then
                echo -e "${GREEN}$login_output${NC}"
                echo -e "${YELLOW}🎮 Anda sekarang masuk ke dalam dunia Arcaea.${NC}"
```
Menu selanjutnya berisi 4 Option :
1. → break → Menghentikan loop dan kembali ke menu utama.
2. → Menjalankan core_monitor.sh → Melakukan monitoring CPU dengan menjalankan script core_monitor.sh.
3. → Menjalankan frag_monitor.sh → Melakukan monitoring RAM dengan menjalankan script frag_monitor.sh.
4. → Menjalankan manager.sh → Mengelola Crontab (jadwal pemantauan sistem) dengan menjalankan script manager.sh.
Jika input tidak valid (*), akan menampilkan pesan error.

```sh
                while true; do
                    echo -e "\n1️⃣ Kembali ke Menu Utama"
      		    echo -e "2️⃣ Monitor CPU Usage"
		    echo -e "3️⃣ Monitor RAM Usage"
		    echo -e "4 Crontab Manager"
                    read -p "Pilih opsi [1-4]: " login_choice

                    case $login_choice in
                        1) break ;;  # back to main menu
			2) bash scripts/core_monitor.sh ;;
			3) bash scripts/frag_monitor.sh ;;
			4) bash scripts/manager.sh ;;
 			*) echo -e "${RED}❌ Pilihan tidak valid!${NC}"
                            ;;
                    esac
                done
            else
                echo -e "${RED}$login_output${NC}"
                sleep 2
            fi
            ;;
        3) 
            echo -e "${YELLOW}👋 Terima kasih telah bermain di Arcaea!${NC}"
            exit 0
            ;;
        *) 
            echo -e "${RED}❌ Pilihan tidak valid!${NC}"
            sleep 1
            ;;
    esac
done
```

##core_monitor.sh
```sh
```
