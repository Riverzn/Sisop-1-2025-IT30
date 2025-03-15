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
