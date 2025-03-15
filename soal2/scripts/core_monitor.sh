#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

LOG_DIR="./log"
LOG_FILE="$LOG_DIR/core.log"
mkdir -p "$LOG_DIR"

current_time=$(date +"%H:%M:%S")
timestamp=$(date +"%Y-%m-%d %H:%M:%S")

# total penggunaan CPU
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"%"}')

# model CPU
cpu_model=$(lscpu | grep "Model name" | awk -F: '{print $2}' | sed 's/^[ \t]*//')

# top processes cpu
top_processes=$(ps -eo pid,comm,%cpu --sort=-%cpu | head -6 | awk 'NR>1 {printf "%-6s %-20s %s%%\n", $1, $2, $3}')

clear
echo -e "${CYAN}┌───────────────────────────────────┐"
echo -e "│           🔥 CPU Monitor          │"
echo -e "│         ⏳ $current_time          │"
echo -e "└───────────────────────────────────┘${NC}"

echo -e "📌 ${YELLOW}CPU Model:${NC} ${GREEN}$cpu_model${NC}"
echo -e "⚡ ${YELLOW}CPU Usage:${NC} ${GREEN}$cpu_usage${NC}"

echo -e "${CYAN}┌───────────────────────────────────┐"
echo -e "│      🔍 Top 5 CPU Processes       │"
echo -e "└───────────────────────────────────┘${NC}"
echo -e "${YELLOW}PID     COMMAND              CPU%${NC}"
echo -e "$top_processes"

# Simpan ke log
echo "[$timestamp] - Core Usage [$cpu_usage%] - Terminal Model [$cpu_model]" >> "$LOG_FILE"

