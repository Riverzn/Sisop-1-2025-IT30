#!/bin/bash


NC='\033[0m' # No Color

CORE_MONITOR="./scripts/core_monitor.sh"
FRAG_MONITOR="./scripts/frag_monitor.sh"

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

    case $choice in
        1)
            read -p "Set interval (contoh: */5 * * * * untuk 5 menit): " interval
            (crontab -l 2>/dev/null; echo "$interval bash $CORE_MONITOR") | crontab -
            echo -e "${GREEN}✅ CPU monitoring berhasil ditambahkan!${NC}"
            sleep 2
            ;;
        2)
            read -p "Set interval (contoh: */5 * * * * untuk 5 menit): " interval
            (crontab -l 2>/dev/null; echo "$interval bash $FRAG_MONITOR") | crontab -
            echo -e "${GREEN}✅ RAM monitoring berhasil ditambahkan!${NC}"
            sleep 2
            ;;
        3)
            crontab -l 2>/dev/null | grep -v "$CORE_MONITOR" | crontab -
            echo -e "${RED}❌ CPU monitoring dihapus!${NC}"
            sleep 2
            ;;
        4)
            crontab -l 2>/dev/null | grep -v "$FRAG_MONITOR" | crontab -
            echo -e "${RED}❌ RAM monitoring dihapus!${NC}"
            sleep 2
            ;;
        5)
            echo -e "${YELLOW}📜 Active Crontab Jobs:${NC}"
            crontab -l 2>/dev/null || echo "No scheduled jobs."
            read -p "Press enter to return..."
            ;;
        6)
            echo -e "${RED}👋 Exiting Arcaea Terminal...${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}❌ Invalid option! Please try again.${NC}"
            sleep 2
            ;;
    esac
done
