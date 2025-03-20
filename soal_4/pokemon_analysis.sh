#!/bin/bash

if [[ -f "$1" ]]; then
    FILE="$1"
    shift
else
    echo "Error! File data tidak dispesifikasi."
    exit 1
fi

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

case "$1" in
    -h|--help)
	display_UI
	exit 0
	;;

    -i|--info)
        echo "Pokemon ~Generation 9 OverUsed~ Data Summary"

        awk -F, 'NR>1 {
            if ($2+0 > max_usage) { max_usage = $2+0; name = $1 }
            if ($3+0 > max_raw) { max_raw = $3+0; raw_name = $1 }
        }
        END {
            print "Highest Usage Percentage (%):", name, "with", max_usage "%"
            print "Highest Raw Usage:", raw_name, "with", max_raw, "uses"
        }' "$FILE"

        exit 0
        ;;

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

	if [[ -z "${sort_options[$2]}" ]]; then
    	echo "Error! Metode sorting invalid!"
    	exit 1
	fi

	sort_col=${sort_options[$2]}
	order="-nr"

	if [[ "$2" == "name" ]]; then
    	order=""
	fi

        (head -n 1 "$FILE"; tail -n +2 "$FILE" | sort -t, -k"$sort_col" $order) | column -s, -t
        exit 0
        ;;

    -g|--grep)
        if [[ -z "$2" ]]; then
            echo "Error! Inputlah nama pokemon!"
            exit 1
        fi

	(head -n 1 "$FILE"; awk -F, -v name="$2" 'NR>1 && tolower($1) ~ tolower(name)' "$FILE" | sort -t, -k2 -nr) | column -s, -t
        exit 0
        ;;

    -f|--filter)
        if [[ -z "$2" ]]; then
            echo "Error! Inputlah type pokemon!"
            exit 1
        fi

	(head -n 1 "$FILE"; awk -F, -v type="$2" 'NR>1 && (tolower($4) == tolower(type) || tolower($5) == tolower(type))' "$FILE" | sort -t, -k2 -nr) | column -s, -t
        exit 0
        ;;

    *)
        echo "Gunakan -h or --help untuk informasi selebihnya :D"
        exit 1
        ;;
esac
