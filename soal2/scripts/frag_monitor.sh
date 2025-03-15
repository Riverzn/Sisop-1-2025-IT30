#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

LOG_DIR="./log"
LOG_FILE="$LOG_DIR/fragment.log"
mkdir -p "$LOG_DIR"

current_time=$(date +"%H:%M:%S")
timestamp=$(date +"%Y-%m-%d %H:%M:%S")

total_ram=$(free -m | awk '/Mem:/ {print $2}')
used_ram=$(free -m | awk '/Mem:/ {print $3}')
free_ram=$(free -m | awk '/Mem:/ {print $4}')
ram_usage=$(free | awk '/Mem:/ {printf("%.2f"), $3/$2 * 100}')

clear
echo -e "${CYAN}┌───────────────────────────────────┐"
echo -e "│          💾 RAM Monitor           │"
echo -e "│            ⏳ $current_time            │"
echo -e "└───────────────────────────────────┘${NC}"

echo -e "📌 ${YELLOW}Total RAM:${NC} ${GREEN}$total_ram MB${NC}"
echo -e "🔥 ${YELLOW}Used RAM:${NC} ${GREEN}$used_ram MB${NC}"
echo -e "💡 ${YELLOW}Free RAM:${NC} ${GREEN}$free_ram MB${NC}"
echo -e "⚡ ${YELLOW}Usage:${NC} ${GREEN}$ram_usage${NC}"

echo -e "${CYAN}┌────────────────────────────────────────────────────────────────────┐"
echo -e "│       🔍 Recent Memory Processes                                   │"
echo -e "└────────────────────────────────────────────────────────────────────┘${NC}"
echo -e "${YELLOW}PID     USER       CPU%   MEM%   COMMAND       {NC}"

ps -eo pid,user,%cpu,%mem,comm --sort=-%mem | head -6 | awk -v green="$GREEN" -v nc="$NC" 'NR>1 {
    printf "%-6s " green "%-10s" nc " %-6s %-6s %-20s\n", $1, $2, $3, $4, $5;
}'

echo "[$timestamp] - Fragment Usage [$ram_usage%] - Fragment Count [$used_ram MB] - Details [Total: $total_ram MB, Available: $free_ram MB]" >> "$LOG_FILE"

