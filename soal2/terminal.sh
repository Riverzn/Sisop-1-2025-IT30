#!/bin/bash

BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

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

    case $choice in
        1) 
            bash register.sh 
            ;;
        2) 
            login_output=$(bash login.sh)
            if [[ $login_output == *"✅ Login berhasil!"* ]]; then
                echo -e "${GREEN}$login_output${NC}"
                echo -e "${YELLOW}🎮 Anda sekarang masuk ke dalam dunia Arcaea.${NC}"
        
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
