# Praktikum Sistem Operasi Modul1
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

(SOAL_2 README.md)

---

(SOAL_3 README.md)

---

# Penjelasan Code soal_4
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
