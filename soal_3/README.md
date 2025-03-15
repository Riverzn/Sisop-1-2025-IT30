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
``
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
