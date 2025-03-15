#!/bin/bash

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

tablet_ajaib

echo "Pilih opsi (1-4) : "
read opsi

if [[ "$opsi" == "1" ]]; then
	awk -F',' ' BEGIN {n = 0} $2 == "Chris Hemsworth" {++n}
		END {print "Chris Hemsworth membaca", n, "buku."}' reading_data.csv

elif [[ "$opsi" == "2" ]]; then
	awk -F',' 'NR > 1 { total += $6; count++ }
		END { if (count > 0)
                   print "Rata-rata durasi \"mereka\" membaca adalah", total/count, "menit." }' reading_data.csv

elif [[ "$opsi" == "3" ]]; then
	awk -F',' 'NR > 1 {
    		if ($7+0 > max_rating) {
        		max_rating = $7+0
        		pembaca = $2
        		buku = $3
    		}
	}
	END {print pembaca, "memberi rating tertinggi", max_rating, "untuk buku", buku;}' reading_data.csv

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

else
	echo "Pilihlah dari keempat opsi yang disediakan!"
fi
