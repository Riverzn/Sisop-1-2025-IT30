# Praktikum Sistem Operasi Modul 1
### by IT30


### Anggota Kelompok

| No | Nama                              | NRP         |
|----|-----------------------------------|------------|
| 1  | Adiwidya Budi Pratama            | 5027241012 |
| 2  | Ahmad Rafi Fadhillah Dwiputra     | 5027241068 |
| 3  | Dimas Satya Andhika              | 5027241032 |


---

## Soal_1 (Revisi)
### The Adventure of Poppo and Siroyo through the magical tablet!
### Problem:
  
> **Suatu hari, mereka menemukan tablet ajaib berisi catatan misterius bernama [reading_data.csv](https://drive.google.com/file/d/1l8fsj5LZLwXBlHaqhfJVjz_T0p7EJjqV/view?usp=sharing). Dengan bantuan keajaiban `awk`, mereka memutuskan untuk menjelajahi rahasia di balik data itu, siap menghadapi tantangan demi tantangan dalam petualangan baru mereka.**
- **Berapa banyak buku yang dibaca oleh “Chris Hemsworth”?**
- **Berapa rata-rata durasi "mereka" membaca?**
- **Siapakah yang memberi rating buku tertinggi? dan buku apakah itu?**
- **Setelah tahun 2023, genre buku apakah yang terpopuler?**

## Penjelasan dan Penyelesaian Problem

        tablet_ajaib() {
      
    
        cat << "EOF"
    
    	 _____      _     _      _       _    _       _ _
    	/__   \__ _| |__ | | ___| |_    /_\  (_) __ _(_) |__
    	  / /\/ _` | '_ \| |/ _ \ __|  //_\\ | |/ _` | | '_ \
    	 / / | (_| | |_) | |  __/ |_  /  _  \| | (_| | | |_) |
    	 \/   \__,_|_.__/|_|\___|\__| \_/ \_// |\__,_|_|_.__/
    	                                   |__/
    
    	Hadapi petualangan dan temukan rahasia di tablet_ajaib!
    	1. Berapa banyak buku yang Chris Hemsworth baca???
    	2. Berapa rata-rata durasi "mereka" membaca???
    	3. Siapakah yang memberi rating buku tertinggi? dan buku apakah itu??
    	4. Setelah tahun 2023, genre buku apakah yang terpopuler???
    
    EOF
    }
Kode diatas digunakan untuk menjadi *interface* program yang ditujukan pada problem-problem yang telah ditunjukkan.
`EOF` disini digunakan sebagai pengganti `echo` dan `print`, sehingga mengefisiensikan multiline kode dengan fungsi yang sama.

`tablet_ajaib` digunakan untuk *run* interface program, dan

    echo "Pilih opsi (1-4) : "
    read opsi
digunakan untuk memasukan opsi sebagai solusi dari opsi problem.

---
Berdasarkan ketentuan soal_1 yang telah ditetapkan pada *note, seluruh opsi solusi problem di soal_1 menggunakan `if else` dan `awk` yang disatukan dalam suatu file.

Opsi-opsi solusi problem menggunakan kondisi `if else`, sehingga:
### Problem1

    if [[ "$opsi" == "1" ]]; then
		awk -F',' ' BEGIN {n = 0} $2 == "Chris Hemsworth" {++n}
		END {print "Chris Hemsworth membaca", n, "buku."}' reading_data.csv
Kode diatas akan menyelesaikan **problem pertama** dengan menghitung berapa banyak `Chris Hemsworth` sebagai "n" dan melakukan *increment* setiap `Chris Hemsworth`ditemui di column 2 / $2.
### Problem2

    elif [[ "$opsi" == "2" ]]; then
    	awk -F',' 'NR > 1 { total += $6; count++ }
    	END { if (count > 0)
	    	print "Rata-rata durasi \"mereka\" membaca adalah", total/count, "menit." }' reading_data.csv
Kode diatas akan menyelesaikan **problem kedua** dengan `NR > 1 { total += $6; count++ }` yang akan menghitung total column 6 / $6 yang merupakan *durasi membaca*, dilanjutkan menghitung jumlah kolom yang ada, yang kemudian akan digunakan untuk menghitung rata-rata durasi membaca dengan `total/count`.
### Problem3

    elif [[ "$opsi" == "3" ]]; then
    	awk -F',' 'NR > 1 {
        		if ($7+0 > max_rating) {
            		max_rating = $7+0
            		pembaca = $2
            		buku = $3
        		}
    	}
    	END {print pembaca, "memberi rating tertinggi", max_rating, "untuk buku", buku;}' reading_data.csv
Kode diatas akan menyelesaikan **problem ketiga** dengan membandingkan nilai rating dan diteruskan sehingga mendapat nilai `max_rating` sebagai rating tertinggi, diikuti dengan pembacanya ($2) dan bukunya ($3).
### Problem4

    elif [[ "$opsi" == "4" ]]; then
    	awk -F',' 'NR > 1 && $5 > 2023 {
      		jmlh_genre[$4]++
    	} 
    	END {
      	max_jmlh = 0
      	for (genre in jmlh_genre) {
        		if (jmlh_genre[genre] > max_jmlh) {
          		max_jmlh = jmlh_genre[genre]
          		popular_genre = genre
        		}
      	}
      	print "Genre buku terpopuler setelah 2023 adalah:", popular_genre, "\nDengan jumlah buku yaitu: ", max_jmlh, "buku";
    }' reading_data.csv
*! kode ini akan menyelesaikan **problem keempat** yang dimana akan mencari genre buku terpopuler setelah 2023 disertai jumlah bukunya. *!

	awk -F',' 'NR > 1 && $5 > 2023 {
  		jmlh_genre[$4]++
	} 
*! akan menghitung jumlah buku dengan genre tertentu (column 4 / $4) yang telah dipilah hanya untuk buku terbitan setelah 2023 ($5 > 2023). *!

    END {
    max_jmlh = 0
    for (genre in jmlh_genre) {
    		if (jmlh_genre[genre] > max_jmlh) {
      		max_jmlh = jmlh_genre[genre]
      		popular_genre = genre
    		}
    }
akan membandingkan genre-genre buku berdasarkan jumlahnya dengan `for loop` yang diinisasikan dan memperbarui inisialisasi genre terpopuler dengan jumlah genre buku terbanyak.

    else
    	echo "Pilihlah dari keempat opsi yang disediakan!"
    fi
Dan terakhir, kode ini akan terinisiasi ketika input keempat opsi tidak dimasukkan.

---

<div align=center>
	
## soal_2
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

# terminal .sh
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

---

# The Dark Side of the Moon🌑
## Bersihkan layar
```bash
clear
```
Perintah clear digunakan untuk membersihkan tampilan terminal dengan cara menghapus semua output yang sudah muncul di layar
## Array
```bash
emoji=("🫵" "🤩" "🥰" "🌟" "🔥" "💐" "✨" "🏆" "🎀" "💎" "💞" "💖" "🌈" "🐈")
warna=("\033[1;32m" "\033[1;33m" "\033[1;34m" "\033[1;31m" "\033[1;35m" "\033[1;36m")
simbol=("💲" "€" "£" "¥" "¢" "₹" "₩" "₿" "₣" "$" "₺")
```
- X=(...) → menyatakan sebuah array. X adalah nama array
- ("...") → element-element dari array

## Speak to me
```bash
affirmation() {
    while true; do
```
- affirmation() { → deklarasi fungsi
- while true; do → loop yang akan terus berjalan sampai user menghentikan dengan ctrl + c


```bash
 response=$(curl -s "https://www.affirmations.dev")
```
- response= → variabel
- curl → pengambil data dari URL (API).
- -s → menghilangkan output status agar hanya menampilkan data API
- "https://www.affirmations.dev" → URL API

```bash
affirmation=$(echo "$response" | sed -E 's/.*"affirmation":"([^"}]*)".*/\1/')
```
- affirmation → variabel
- echo → menampilkan isi variabel response
- "$response" → isi data JSON dari API
- sed → memproses teks dan menerapkan pencocokan teks
- -E → extended regex
- 's/.*"affirmation":"([^"}]*)".*/\1/' → regex

```bash
random_emoji=$(( RANDOM % ${#emoji[@]} ))
```
- random_emoji → variabel
- RANDOM → variabel bawaan Bash yang menghasilkan angka acak
- % → memastikan indeks tetap sesuai array
- ${#emoji[@] → menjaga agar indeks sesuai array emoji

```bash
echo " $affirmation ${emoji[$random_emoji]} "
```
Menampilkan affirmation dan emoji secara acak

```bash
sleep 1
```
Tunda 1 detik

## On the Run
```bash
progress_bar() {
    local duration=100
    local width=$(tput cols)
    local filled=0
```
- progress_bar() { → deklarasi fungsi
- local duration=100 → jumlah total progress
- local width=$(tput cols) → lebar terminal
- local filled=0 → menyimpan nilai progres yang akan bertambah secara bertahap
```bash
while [[ $filled -le $duration ]]; do
    sleep $(awk -v min=0.1 -v max=1 'BEGIN{srand(); print min+rand()*(max-min)}')
```
- while [[ $filled -le $duration ]] → Loop berjalan dan menyimpan progress sampai duration (100%)
- awk → menghasilkan angka acak
- srand() → inisialisasi generator angka acak
- print min+rand()*(max-min) → hitung angka acak dalam rentang yang ditentukan

```bash
local progress=$(( (filled * (width - 10)) / duration ))
local empty=$(( (width - 10) - progress ))
```
- progress → Menghitung jumlah karakter # dalam progress bar berdasarkan persentase filled
- empty → Menghitung jumlah karakter kosong (' ') yang tersisa dalam progress bar

```bash
local warna_index=$(( filled / 5 % ${#warna[@]} ))
local color="${warna[$warna_index]}"
``` 
- ${#warna[@]} → hitung jumlah elemen dalam array warna
- filled / 5 → 
- % ${#warna[@]} → menjaga agar indeks sesuai array warna
- color="${warna[$warna_index]}" → memilih warna berdasarkan indeks yang dihitung

```bash
echo -ne "\r${color}["
printf '#%.0s' $(seq 1 $progress)
printf ' %.0s' $(seq 1 $empty)
echo -ne "] $filled%%\033[0m"
```
1. echo -ne "\r${color}["
 - \r → mengembalikan kursor ke awal baris agar progress bar diperbarui di tempat yang sama
 - ${color} → menetapkan warna progress bar
 - [ → awal dari progress bar
2. printf '#%.0s' $(seq 1 $progress)
- $(seq 1 $progress) → menghasilkan angka 1 hingga progress
- printf '#%.0s' → mencetak # sesuai progress
3. printf ' %.0s' $(seq 1 $empty)
Menghasilkan spasi kosong sebanyak empty untuk mengisi sisa progress bar

4. echo -ne "] $filled%%\033[0m"
- ] → menutup progress bar
- $filled%% → menampilkan presentase
- \033[0m → warna kembali ke default

```bash
((filled++))
```
mengisi progress dari 1 hingga kapasitas yang ditentukan
 
 ```bash
 echo -e "\n ✅FINISH!"
 ```
 mencetak pesan ✅FINISH pada line baru yang berbeda dengan progress bar

## Time
```bash
clock() {
while true; do
```
deklarasi fungsi `clock` serta melakukan loop
```bash
echo -e "\033[1;36m$(date '+%Y-%m-%d %H:%M:%S')\033[0m"
```
mengambil tanggal dan waktu sesuai format

## Money
```bash
cmatrix() {
tput civis
```
deklarasi fungsi `cmatrix` dan menyembunyikan kursor

```bash
cols=$(tput cols)
lines=$(tput lines)
```
membuat variabel `cols` dan `lines` yang memuat jumlah kolom dan baris dari `tput`

```bash
declare -a positions
for ((i=0; i<cols; i++)); do
    positions[i]=$(( RANDOM % lines ))
done
```
membuat array `positions` yang akan menyimpan posisi vertikal awal dari kolom dengan nilai acak

```bash
while true; do
```
loop

```bash
for ((i=0; i<cols; i++)); do
```
loop ini berjalan dari 0 hingga cols - 1, memproses setiap kolom terminal

```bash
symbol=${simbol[$((RANDOM % ${#simbol[@]}))]}
color=${warna[$((RANDOM % ${#warna[@]}))]}
```
memilih simbol dan warna dari array secara acak

```bash
tput cup ${positions[i]} $i
echo -ne "${color}${symbol}\033[0m"
```
- tput cup → memindahkan posisi kursor ke baris, kolom
- echo -ne → mencetak simbol dan warna yang terpilih

```bash
positions[i]=$(( (positions[i] + 1) % lines ))
```
memperbarui posisi vertikal simbol di kolom tersebut, menggeser ke bawah dan kembali ke atas saat mencapai batas bawah terminal.

## Brain Damage
```bash
task_manager() {
while true; do
clear
```
deklarasi fungsi `task manager`, `while true; do
clear` melakukan loop secara terus menerus, dan `clear` membersihkan tampilan terminal

```bash
echo -e "\033[1;33m$(date "+%H:%M:%S") | Load Average: $(cat /proc/loadavg | awk '{print $1, $2, $3}')\033[0m""
```
- menampilkan waktu saat ini (HH:MM:SS).
- menampilkan load average (rata-rata beban CPU) dari `/proc/loadavg`, yang menunjukkan beban sistem dalam 1, 5, dan 15 menit terakhir.
- Berwarna kuning (\033[1;33m).

```bash
echo -e "\033[1;32mPID\tUSER\tPR\tNI\t%CPU\t%MEM\tVSZ\tRSS\tTIME+\tCOMMAND\033[0m"
```
menampilkan informasi bagian-bagian task manager

```bash
ps -eo pid,user,pri,nice,%cpu,%mem,vsz,rss,time,comm --sort=-%cpu | head -n 11 | awk '
NR==1 {next}
{
    printf "\033[1;35m%-8s\033[0m \033[1;36m%-8s\033[0m \033[1;33m%-4s\033[0m \033[1;32m%-4s\033[0m \033[1;31m%-6s\033[0m \033[1;34m%-6s\033[0m \033[1;36m%-8s\033[0m \033[1;35m%-8s\033[0m \033[1;32m%-10s\033[0m \033[1;33m%s\033[0m\n",
    $1, $2, $3, $4, $5, $6, $7, $8, $9, $10
}'
```
- Perintah `ps -eo` → menampilkan daftar proses dengan atribut yang dipilih.
- `--sort=-%cpu` → mengurutkan proses berdasarkan penggunaan CPU tertinggi.
- `head -n 11` mengambil 11 baris (termasuk header, yang dilewati oleh `NR==1 {next}` dalam `awk)`.
- `awk` → digunakan untuk memformat keluaran dengan warna

## Pemilihan Lagu
```bash
if [[ "$1" == "--play=speak_to_me" ]]; then
    affirmation
elif [[ "$1" == "--play=on_the_run" ]]; then
    progress_bar
elif [[ "$1" == "--play=time" ]]; then
    clock
elif [[ "$1" == "--play=money" ]];then
    cmatrix
elif [[ "$1" == "--play=brain_damage" ]];then
    task_manager
else
    echo "Lagu tidak ditemukan, harap hubungi admin"
    exit 1
fi
```
melakukan seleksi pada lagu, jika input pengguna tidak sesuai dengan `$1` maka pesan "Lagu tidak ditemukan, harap hubungi admin" akan tercetak

## Soal_4 (Revisi)
## Finding the best team for *Pokemon “Generation 9 OverUsed 6v6 Singles”* Tournament.
### Problem:

> **Pada suatu hari, anda diminta teman anda untuk membantunya mempersiapkan diri untuk turnamen Pokemon “Generation 9 OverUsed 6v6 Singles” dengan cara membuatkan tim yang cocok untuknya. Tetapi, anda tidak memahami meta yang dimainkan di turnamen tersebut. Untungnya, seorang informan memberikan anda data [pokemon_usage.csv](https://drive.google.com/file/d/1n-2n_ZOTMleqa8qZ2nB8ALAbGFyN4-LJ/view?usp=sharing) yang bisa anda download dan analisis. Buatlah script yang bernama `pokemon_analysis.sh` untuk menganalisis data tersebut.**
- **Melihat summary data yang menampilkan nama Pokemon dengan Usage% dan RawUsage paling tinggi.**
- **Mengurutkan Pokemon berdasarkan data kolom melalui sort dengan ketentuan *descending* dan *alphabetical*.**
- **Mencari nama Pokemon tertentu dengan mengikuti urutan *sort* Usage% dan terkhususkan.**
- **Mencari Pokemon berdasarkan filter type dengan mengikuti urutan *sort* Usage%.**
- **Adanya *Error Handling* di setiap kesalahan pada *command* untuk setiap *task*.**
- **Memiliki *interface* yang menarik dan informatif sebagai program.**

## Penjelasan dan Penyelesaian Problem

Dalam soal_4, kita ditunjukkan untuk membuat suatu program *script* yang akan menganalisis data dari [pokemon_usage.csv](https://drive.google.com/file/d/1n-2n_ZOTMleqa8qZ2nB8ALAbGFyN4-LJ/view?usp=sharing) dan menyajikan kesimpulan dari data tersebut.

    if [[ -f "$1" ]]; then
        FILE="$1"
        shift
    else
        echo "Error! File data tidak dispesifikasi."
        exit 1
    fi
Kode ini ditujukan untuk menghandling error yang terjadi apabila file tidak dispefikasikan pada *command line* dalam menggunakan program.

    Command -> ./pokemon_analysis.sh <nama_file_data> [opsi_analisis]
merupakan *command line* yang digunakan dalam menjalankan *command-command task* pada program (detil lebih lanjut).

    display_UI() {
            cat << "EOF"
                                         @
                                       @@@
                                      @@@@@
                                     @@@##@
                                     @@@  @                                                    -@-
                                    @@    @                                                  @@  @
                                   @      @                         @## @@@@@#@@@@@         @     @
                                   @      @                    @@@     @@@@@@@@@         @        @
                                   @     @                 -@#         @@@@@@@         @           @
                                   @     @ @@@@@@+      @@            @@@@@          @             @
                                   @   @             @@@             @@@           @               +
                                   @                               @@            @+                 @
                                  @           @#@@@        -  @@@               @                   @
                                             @@@@@@         @                 @                     @
                                @@@                 -+       @              @                    @@
                                @@         @      @@@@@@     @            +@                  @@
                              @      @@@@@@@      @-..-@      @           @                @@
                              @@@     .@  .@      @+..@@       @          +@             @
                               @@#     @@@ @      @#@@@        .            @         @#
                                @@      @@-@                    @            @     @@
                                 @                       @@      @            @   @
                                   @@                  @@   @     @           @   @
                             @@@                      @            @@      .@-     @
                          @                               @          @   @@      @#
                           @                           -              @  @   @+@
                         @                                             @  @+
                            @@@@@      @                                @-  @ -@@
                                       @                                 @.  @#+@@@
                                        @                                 +@@@@@@
                                        @                                  @@
                                         @                                  @@@
                                         @                                  @
                                          @                                 @
                                          @                                @
                                          @              .#                @
                                            @@       @@@.   @@@@@        -@
                                             @@@+@             -## @   @
                                              @  @                 @   @
                                               @@@                  @#@@
    
    
    
    Welcome to the Pokemon “Generation 9 OverUsed 6v6 Singles” data analysis!
    In this summary, u will get bunch of info about what team that is suitable for u!
    
    Command -> ./pokemon_analysis.sh <nama_file_data> [opsi_analisis]
    
    OPSI:
            -h/--help       Display screen utama
            -i/--info       Display Pokemon with Highest Usage% and RawUsage
            -s/--sort       Display sorting secara alphabetical descending berdasarkan ketentuan sebagai berikut:
                    - name : nama pokemon
                    - usage : persentase penggunaan pokemon
                    - raw : jumlah penggunaan pokemon  (Nx)
                    - hp : HP pokemon
                    - atk : ATK pokemon
                    - spatk : Special ATK pokemon
                    - spdef : Special DEF pokemon
                    - speed : Speed pokemon
            -g/--grep       Searching nama pokemon pada sort Usage%
            -f/--filter     Filtering pokemon berdasarkan type pokemon
    
    EOF
    }
Kode diatas digunakan untuk menampilkan *interface* `-h / --help` yang menarik serta menjelaskan berbagai fungsi-fungsi *commands* dan *sub-commands* dalam program.

---
### **Error-Handling dan Interface*
Dalam menghandle error dengan baik pada program, kondisi `switch-case` digunakan dikarenakan lebih efektif dan efisien dalam *error-handling* dibandingkan kondisi lainnya seperti `if-else` ataupun `for`.

    case "$1" in
        -h|--help)
    	display_UI
    	exit 0
    	;;

Kode diatas memulai kondisi `switch-case` dalam menjalankan blok *command* pada program yang dilanjutkan pada opsi-opsi *task* yang dapat dipilih dalam menjalankan program. Pada blok pertama, blok `-h / --help` akan menjalankan fungsi `display_UI` sebagai *interface* program.

### Data Summary of Usage% dan RawUsage
    -i|--info)
            HUP=$(awk -F, 'NR>1 {if($2>max_usage){max_usage=$2; name=$1}} END {print name, max_usage}' "$FILE")
            HRU=$(awk -F, 'NR>1 {if($3>max_raw){max_raw=$3; name=$1}} END {print name, max_raw}' "$FILE")
    
            HUP_NAME=$(echo "$HUP" | awk '{$NF=""; print $0}')
            HUP_VALUE=$(echo "$HUP" | awk '{print $NF}')
            HRU_NAME=$(echo "$HRU" | awk '{$NF=""; print $0}')
            HRU_VALUE=$(echo "$HRU" | awk '{print $NF}')
    
	    	echo "Pokemon ~Generation 9 OverUsed~ Data Summary"
            echo "Highest Usage Percentage (%): $HUP_NAME with $HUP_VALUE%"
            echo "Highest Raw Usage: $HRU_NAME with $HRU_VALUE uses"
    
    	exit 0
    	;;
Kode ini bertujuan untuk menyajikan data summary pada `.csv` yang berdasar pada value HUP (Highest Usage%) dan HRU (Highest RawUsage). 

`{if($2>max_usage){max_usage=$2; name=$1}` dan `{if($3>max_raw){max_raw=$3; name=$1}` bertujuan untuk mencari value Usage% dan RawUsage tertinggi,

			    HUP_NAME=$(echo "$HUP" | awk '{$NF=""; print $0}')
                HUP_VALUE=$(echo "$HUP" | awk '{print $NF}')
                HRU_NAME=$(echo "$HRU" | awk '{$NF=""; print $0}')
                HRU_VALUE=$(echo "$HRU" | awk '{print $NF}')
bertujuan dalam menginisiasi nama pokemon dengan nilai HUP dan HRU tertingginya,

    echo "Pokemon ~Generation 9 OverUsed~ Data Summary" 
    echo "Highest Usage Percentage (%): $HUP_NAME with $HUP_VALUE%" 
    echo "Highest Raw Usage: $HRU_NAME with $HRU_VALUE uses"
bertujuan dalam *print* simpulan data dari HUP dan HRU dengan baik.
### *Mengurutkan Pokemon berdasarkan data kolom melalui *sort*

    -s|--sort)
        declare -A sort_options=(
            [name]=1
            [usage]=2
            [raw]=3
            [hp]=6
            [atk]=7
            [def]=8
            [spatk]=9
            [spdef]=10
            [speed]=11
        )
*Kode diatas bertujuan dalam memulai *command* sort pada program, dengan diawali mendefinisikan opsi-opsi metode *sorting* berdasarkan value yang ada dalam `.csv`,

    if [[ -z "${sort_options[$2]}" ]]; then
                echo "Error! Metode sorting invalid!"
                exit 1
            fi
 bertujuan dalam *error-handling* ketika metode sorting tidak valid dengan opsi yang ada,

    sort_col=${sort_options[$2]}
    order="-nr"
    
    if [[ "$2" == "name" ]]; then
    	order=""
    fi
bertujuan dalam *sorting* angka dalam numerikal *descending* dan huruf pada nama secara *alphabetical* (a-z).

    (head -n 1 "$FILE"; tail -n +2 "$FILE" | sort -t, -k"$sort_col" $order) | column -s, -t
    exit 0
    
    awk -F, -v col="$sort_col" -v order="$order" '
    NR==1 {print; next}
    {print | "sort -t, -k" col " " order}
    ' "$FILE" | column -s, -t
    exit 0
	;;
*! bertujuan dalam menyortir data pada `.csv` secara keseluruhan berdasarkan opsi *sort* pada value dalam data. *!

### Mencari nama Pokemon tertentu

    -g|--grep)
        if [[ -z "$2" ]]; then
            echo "Error! Inputlah nama pokemon!"
            exit 1
        fi
    
	    (head -n 1 "$FILE"; awk -F, -v name="$2" 'NR>1 && tolower($1) == tolower(name)' "$FILE" | sort -t, -k2 -nr) | column -s, -t
        exit 0
        ;;
Kode diatas bertujuan dalam mencari nama pokemon tertentu dan menampilkan nama pokemon tersebut disertai value-value lainnya yang mengikuti pada nama pokemon tersebut.

### Mencari Pokemon berdasarkan filter type
    -f|--filter)
        if [[ -z "$2" ]]; then
            echo "Error! Inputlah type pokemon!"
            exit 1
        fi

		(head -n 1 "$FILE"; awk -F, -v type="$2" 'NR>1 && (tolower($4) == tolower(type) || tolower($5) == tolower(type))' "$FILE" | sort -t, -k2 -nr) | column -s, -t
        exit 0
        ;;
  Kode diatas bertujuan dalam memfilter *type* pokemon yang kita telah input, lalu diikuti dengan urutan pada Usage%-nya dan disertai dengan value-value lainnya yang diikuti oleh pokemon dengan type tertentu.
  
### Error-Handling Program
    *)
        echo "Gunakan -h or --help untuk informasi selebihnya :D"
        exit 1
        ;;
     esac
Kode diatas ini ditujukan untuk *error-handling* pada program secara keseluruhan input command, serta mengakhiri kondisi `switch-case` yang ada dalam program.

---
