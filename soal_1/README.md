# Penjelasan Code soal_1
## The Adventure of Poppo and Siroyo through the magical tablet!
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

    if [[ "$opsi" == "1" ]]; then
		awk -F',' ' BEGIN {n = 0} $2 == "Chris Hemsworth" {++n}
		END {print "Chris Hemsworth membaca", n, "buku."}' reading_data.csv
Kode diatas akan menyelesaikan **problem pertama** dengan menghitung berapa banyak `Chris Hemsworth` sebagai "n" dan melakukan *increment* setiap `Chris Hemsworth`ditemui di column 2 / $2.

    elif [[ "$opsi" == "2" ]]; then
    	awk -F',' 'NR > 1 { total += $6; count++ }
    	END { if (count > 0)
	    	print "Rata-rata durasi \"mereka\" membaca adalah", total/count, "menit." }' reading_data.csv
Kode diatas akan menyelesaikan **problem kedua** dengan `NR > 1 { total += $6; count++ }` yang akan menghitung total column 6 / $6 yang merupakan *durasi membaca*, dilanjutkan menghitung jumlah kolom yang ada, yang kemudian akan digunakan untuk menghitung rata-rata durasi membaca dengan `total/count`.

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
kode ini akan menyelesaikan **problem keempat** yang dimana akan mencari genre buku terpopuler setelah 2023 disertai jumlah bukunya.

	awk -F',' 'NR > 1 && $5 > 2023 {
  		jmlh_genre[$4]++
	} 
akan menghitung jumlah buku dengan genre tertentu (column 4 / $4) yang telah dipilah hanya untuk buku terbitan setelah 2023 ($5 > 2023).

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
### raw_code

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
---
