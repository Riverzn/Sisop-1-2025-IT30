# Membersihkan tampilan layar
clear

# Array emoji
emoji=("🫵" "🤩" "🥰" "🌟" "🔥" "💐" "✨" "🏆" "🎀" "💎" "💞" "💖" "🌈" "🐈")

# Array warna
warna=("\033[1;32m" "\033[1;33m" "\033[1;34m" "\033[1;31m" "\033[1;35m" "\033[1;36m")

# Array mata uang
simbol=("💲" "€" "£" "¥" "¢" "₹" "₩" "₿" "₣" "$" "₺")

# Speak to me
affirmation() {
    while true; do
        # Mengambil dari API
        response=$(curl -s "https://www.affirmations.dev")

	# Ekstrak teks
	affirmation=$(echo "$response" | sed -E 's/.*"affirmation":"([^"}]*)".*/\1/')
	random_emoji=$(( RANDOM % ${#emoji[@]} ))

	# Menampilkan teks
	 echo " $affirmation ${emoji[$random_emoji]} "

	 sleep 1  # Tunda 1 detik sebelum menampilkan lagi
    done
}

# On the run
progress_bar() {
    local duration=100
    local width=$(tput cols)
    local filled=0

    # Interval waktu dan progress
    while [[ $filled -le $duration ]]; do
        sleep $(awk -v min=0.1 -v max=1 'BEGIN{srand(); print min+rand()*(max-min)}')

        local progress=$(( (filled * (width - 10)) / duration ))
        local empty=$(( (width - 10) - progress ))

        # Pilih warna yang berubah-ubah
        local warna_index=$(( filled / 5 % ${#warna[@]} ))
        local color="${warna[$warna_index]}"

        # Menampilkan progress bar dengan warna
        echo -ne "\r${color}["
        printf '#%.0s' $(seq 1 $progress)
        printf ' %.0s' $(seq 1 $empty)
        echo -ne "] $filled%%\033[0m"

        ((filled++))  # Tambah progres
    done

    echo -e "\n ✅FINISH!"
}

# Time
clock() {
while true; do
        clear
        echo -e "\033[1;36m$(date '+%Y-%m-%d %H:%M:%S')\033[0m"  # Tampilkan jam
        sleep 1
    done
}

# Money
cmatrix() {
tput civis

    # Dapatkan ukuran terminal
    cols=$(tput cols)
    lines=$(tput lines)

    # Penyimpanan posisi simbol
    declare -a positions
    for ((i=0; i<cols; i++)); do
        positions[i]=$(( RANDOM % lines ))
    done

    while true; do
        for ((i=0; i<cols; i++)); do
            # Pilih simbol dan warna 
            symbol=${simbol[$((RANDOM % ${#simbol[@]}))]}
            color=${warna[$((RANDOM % ${#warna[@]}))]}

            # Cetak simbol di posisi yang diperbarui
            tput cup ${positions[i]} $i
            echo -ne "${color}${symbol}\033[0m"

            # Geser simbol ke bawah
            positions[i]=$(( (positions[i] + 1) % lines ))
        done

        # Tunggu sebelum refresh
        sleep 0.1
    done
}

# Brain damage
task_manager() {
while true; do
        clear
        echo -e "\033[1;34m=== Brain Damage Task Manager ===\033[0m"
        echo -e "\033[1;33m$(date "+%H:%M:%S") | Load Average: $(cat /proc/loadavg | awk '{print $1, $2, $3}')\033[0m"
        echo -e "\033[1;32mPID\tUSER\tPR\tNI\t%CPU\t%MEM\tVSZ\tRSS\tTIME+\tCOMMAND\033[0m"
        
        ps -eo pid,user,pri,nice,%cpu,%mem,vsz,rss,time,comm --sort=-%cpu | head -n 11 | awk '
        NR==1 {next}
        {
            printf "\033[1;35m%-8s\033[0m \033[1;36m%-8s\033[0m \033[1;33m%-4s\033[0m \033[1;32m%-4s\033[0m \033[1;31m%-5s\033[0m \033[1;34m%-5s\033[0m \033[1;37m%-8s\033[0m \033[1;36m%-8s\033[0m \033[1;35m%-8s\033[0m \033[1;33m%s\033[0m\n",
            $1, $2, $3, $4, $5, $6, $7, $8, $9, $10
        }'
        
        sleep 1
    done

}

# Memeriksa judul lagu
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
