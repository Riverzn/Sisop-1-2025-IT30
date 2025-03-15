<div align=center>
	
## Dokumentasi Sisop modul 1 soal_2
</div>

## Table of Contents

- [register.sh](#register.sh)
- [login.sh](#login.sh)
- [terminal.sh](#terminal.sh)
- [core_monitor.sh](#core_monitor.sh)
- [frag_mnitor.sh](#frag_Monitor.sh)
- [manager.sh](#manager.sh)
  
# register.sh :

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

# login.sh
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

# core_monitor.sh
1. Inisialisasi Log File & Folder
```sh
LOG_DIR="./log" // Menentukan lokasi folder untuk menyimpan log.
LOG_FILE="$LOG_DIR/core.log" //Menentukan nama file log (core.log) di dalam folder /log
mkdir -p "$LOG_DIR"
```
2. Mengambil info CPU
* grep "Cpu(s)" > Mencari baris yang mengandung informasi CPU.
* awk '{print 100 - $8"%"}' >
$8 adalah nilai idle CPU.
100 - idle → Menghitung persentase penggunaan CPU aktif.
```sh
# Info CPU
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"%"}')
```
3. Mengambil model CPU
* lscpu > Menampilkan informasi tentang CPU.
* grep "Model name" > Mencari baris yang berisi model CPU.
* awk -F: '{print $2}' > Mengambil teks setelah tanda ':'
* sed 's/^[ \t]*//' > Menghapus spasi/tab di awal teks.
```sh
# Model CPU
cpu_model=$(lscpu | grep "Model name" | awk -F: '{print $2}' | sed 's/^[ \t]*//')
```
4. Mengambil Top 5 recent processes CPU
* ps -eo pid,comm,%cpu > Mengambil daftar PID, nama proses, dan penggunaan CPU.
* --sort=-%cpu > Mengurutkan proses dari penggunaan CPU tertinggi.
* head -6 > Mengambil 6 baris teratas (termasuk header).
* awk 'NR>1 {printf "%-6s %-20s %s%%\n", $1, $2, $3}'
* NR>1 → Melewati baris pertama (header).
```sh
# top processes cpu
top_processes=$(ps -eo pid,comm,%cpu --sort=-%cpu | head -6 | awk 'NR>1 {printf "%-6s %-20s %s%%\n", $1, $2, $3}')
```
5. Tampilan terminal
```sh
clear
echo -e "${CYAN}┌───────────────────────────────────┐"
echo -e "│           🔥 CPU Monitor          │"
echo -e "│         ⏳ $current_time          │"
echo -e "└───────────────────────────────────┘${NC}"

echo -e "📌 ${YELLOW}CPU Model:${NC} ${GREEN}$cpu_model${NC}"
echo -e "⚡ ${YELLOW}CPU Usage:${NC} ${GREEN}$cpu_usage${NC}"

echo -e "${CYAN}┌───────────────────────────────────┐"
echo -e "│      🔍 Top 5 CPU Processes       │"
echo -e "└───────────────────────────────────┘${NC}"
echo -e "${YELLOW}PID     COMMAND              CPU%${NC}"
echo -e "$top_processes"
```
>> "$LOG_FILE" > Menambahkan hasil ke dalam file log tanpa menghapus isi sebelumnya.
```sh
# Simpan ke log
echo "[$timestamp] - Core Usage [$cpu_usage%] - Terminal Model [$cpu_model]" >> "$LOG_FILE"
```

# frag_monitor.sh
1. Inisialisasi Log File & Folder
```sh
LOG_DIR="./log"
LOG_FILE="$LOG_DIR/fragment.log"
mkdir -p "$LOG_DIR"
```
2. Mengambil Info RAM
* free -m > membaca informasi RAM dalam satuan MB (megabyte).
* used_ram > RAM yang sedang digunakan dalam MB.
* free_ram > RAM yang tersedia dalam MB.
* ram_usage > Persentase penggunaan RAM:
$3 = RAM yang digunakan.
$2 = Total RAM.
($3 / $2 * 100) → Menghitung persentase RAM yang digunakan.
```sh
total_ram=$(free -m | awk '/Mem:/ {print $2}')
used_ram=$(free -m | awk '/Mem:/ {print $3}')
free_ram=$(free -m | awk '/Mem:/ {print $4}')
ram_usage=$(free | awk '/Mem:/ {printf("%.2f"), $3/$2 * 100}')
```
3. Tampilan Info RAM di Terminal
```sh
clear
echo -e "${CYAN}┌───────────────────────────────────┐"
echo -e "│          💾 RAM Monitor           │"
echo -e "│            ⏳ $current_time            │"
echo -e "└───────────────────────────────────┘${NC}"

echo -e "📌 ${YELLOW}Total RAM:${NC} ${GREEN}$total_ram MB${NC}"
echo -e "🔥 ${YELLOW}Used RAM:${NC} ${GREEN}$used_ram MB${NC}"
echo -e "💡 ${YELLOW}Free RAM:${NC} ${GREEN}$free_ram MB${NC}"
echo -e "⚡ ${YELLOW}Usage:${NC} ${GREEN}$ram_usage${NC}"
```
Tampilan Recent RAM Processes
* ps -eo pid,user,%cpu,%mem,comm --sort=-%mem > Mengambil daftar proses dengan informasi:
PID (Process ID).
User yang menjalankan proses.
CPU% (penggunaan CPU).
MEM% (penggunaan RAM).
Command (nama proses).
* head -6 → Mengambil 5 proses teratas + 1 baris header.
```sh
echo -e "${CYAN}┌────────────────────────────────────────────────────────────────────┐"
echo -e "│       🔍 Recent Memory Processes                                   │"
echo -e "└────────────────────────────────────────────────────────────────────┘${NC}"
echo -e "${YELLOW}PID     USER       CPU%   MEM%   COMMAND       {NC}"

ps -eo pid,user,%cpu,%mem,comm --sort=-%mem | head -6 | awk -v green="$GREEN" -v nc="$NC" 'NR>1 {
    printf "%-6s " green "%-10s" nc " %-6s %-6s %-20s\n", $1, $2, $3, $4, $5;
}'
```
>> "$LOG_FILE" > Menambahkan hasil ke dalam file log tanpa menghapus isi sebelumnya.
```sh
echo "[$timestamp] - Fragment Usage [$ram_usage%] - Fragment Count [$used_ram MB] - Details [Total: $total_ram MB, Available: $free_ram MB]" >> "$LOG_FILE"
```

# manager.sh
* CORE_MONITOR > Path ke script yang memantau penggunaan CPU.
* FRAG_MONITOR > Path ke script yang memantau penggunaan RAM.
```sh
CORE_MONITOR="./scripts/core_monitor.sh"
FRAG_MONITOR="./scripts/frag_monitor.sh"
```
Tampilan Arcaea Terminal
```sh
while true; do
    clear
    echo -e "${NC}┌────────────────────────────────────────────────┐"
    echo -e "│                ARCAEA TERMINAL                 │"
    echo -e "├────┬───────────────────────────────────────────┤"
    echo -e "│ ID │ OPTION                                    │"
    echo -e "├────┼───────────────────────────────────────────┤"
    echo -e "│ 1  │ Add CPU - Core Monitor to Crontab         │"
    echo -e "│ 2  │ Add RAM - Fragment Monitor to Crontab     │"
    echo -e "│ 3  │ Remove CPU - Core Monitor from Crontab    │"
    echo -e "│ 4  │ Remove RAM - Fragment Monitor from Crontab│"
    echo -e "│ 5  │ View All Scheduled Monitoring Jobs        │"
    echo -e "│ 6  │ Exit Arcaea Terminal                      │"
    echo -e "└────┴───────────────────────────────────────────┘${NC}"
    echo -n "Enter option [1-6]: "
    read choice
```
User Option
1. Monitoring CPU ke Crontab
* read -p > Meminta user memasukkan interval cron (contoh: */5 * * * * untuk setiap 5 menit).
* crontab -l 2>/dev/null > Mengambil daftar crontab yang ada 
* Menambahkan perintah baru ke crontab tanpa menghapus yang lama.
```sh
    case $choice in
        1) 
            read -p "Set interval (contoh: */5 * * * * untuk 5 menit): " interval
            (crontab -l 2>/dev/null; echo "$interval bash $CORE_MONITOR") | crontab -
            echo -e "${GREEN}✅ CPU monitoring berhasil ditambahkan!${NC}"
            sleep 2
            ;;
```
* Sama seperti opsi 1, tapi untuk monitoring RAM.
```sh
        2)
            read -p "Set interval (contoh: */5 * * * * untuk 5 menit): " interval
            (crontab -l 2>/dev/null; echo "$interval bash $FRAG_MONITOR") | crontab -
            echo -e "${GREEN}✅ RAM monitoring berhasil ditambahkan!${NC}"
            sleep 2
            ;;
```
Menghapus Monitoring CPU dari Crontab
crontab -l 2>/dev/null → Mengambil daftar crontab.
grep -v "$CORE_MONITOR" → Menghapus baris yang mengandung core_monitor.sh.
crontab - → Menyimpan kembali daftar yang sudah difilter.
```sh
        3)
            crontab -l 2>/dev/null | grep -v "$CORE_MONITOR" | crontab -
            echo -e "${RED}❌ CPU monitoring dihapus!${NC}"
            sleep 2
            ;;
```
Menghapus Monitoring RAM dari Crontab
```sh
        4)
            crontab -l 2>/dev/null | grep -v "$FRAG_MONITOR" | crontab -
            echo -e "${RED}❌ RAM monitoring dihapus!${NC}"
            sleep 2
            ;;
```
Menampilkan semua crontab yang aktif.
* Jika tidak ada, maka menampilkan pesan "No scheduled jobs."
```sh
        5)
            echo -e "${YELLOW}📜 Active Crontab Jobs:${NC}"
            crontab -l 2>/dev/null || echo "No scheduled jobs."
            read -p "Press enter to return..."
            ;;
```
Exit program
```sh
        6)
            echo -e "${RED}👋 Exiting Arcaea Terminal...${NC}"
            exit 0
            ;;
```
```sh
        *)
            echo -e "${RED}❌ Invalid option! Please try again.${NC}"
            sleep 2
            ;;
    esac
done
```
