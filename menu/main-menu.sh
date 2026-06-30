#!/usr/bin/env bash

green="\e[32m"
red="\e[31m"
yellow="\e[33m"
blue="\e[34m"
reset="\e[0m"

dragon_banner() {
clear
echo -e "${green}"
cat << 'DRAGON'
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⠿⠋⠀⠀⠙⠛⢿⣿⣿⣿⣿⣷⣦⣄⡀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣾⡿⠃⠀⠀⠀⠀⣀⡀⠀⠙⣿⣿⣿⣿⣿⣿⣿⣷⣤⣀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠋⢀⣠⣶⣿⠟⠋⠀⠀⢀⣠⣴⠞⠉⠁⠀⠀⠈⢻⣿⣿⣿⣝⡿⣿⣿⣿⣷⣦⣀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⠏⣠⣴⣿⠟⣋⣤⣶⣿⣿⡿⠟⠋⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⣿⣿⣿⣷⣬⡙⠻⢿⣿⣷⣦⡀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣿⢃⣼⣿⣿⣿⣿⣿⣿⣟⣋⣁⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿⣶⣄⡉⠻⣿⣿⣧⡀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣧⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣛⠉⠙⠛⠳⠶⣤⠀⠀⠀⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿⣿⣿⣦⣈⠙⢿⣿⣶⡄
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⡝⢿⣿⣿⣿⣿⣿⣷⣄⠙⠻⣿⣦⡀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⡟⠉⢉⠉⠉⠻⣿⣿⣿⣿⣿⣿⠻⣶⡀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣎⠻⣿⣿⣿⣿⣿⣿⣷⣄⠈⢿⣿⣦
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⡿⠋⣿⣿⣿⣿⣷⠶⠋⠀⠀⢀⡈⢻⣿⣿⣿⣿⣦⠈⠛⠀⠀⠀⠀⠀⠀⠀⣸⣿⣿⣿⣿⣦⠘⢿⣿⣿⣿⣿⣿⣿⣧⡀⠙⢿⣧⡀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣷⣾⡿⠛⠉⠁⠀⠀⠀⠀⠀⢀⣷⡀⣿⣿⣿⣿⢿⣷⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣧⡀⢻⣿⣿⣿⣿⣿⣿⣿⣄⠀⢻⣿⣆
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⠁⣿⣿⣿⣿⠀⢻⡆⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣷⠀⠹⣿⣿⣿⣿⣿⣿⣿⣧⡀⠹⣿⣆
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⣿⠏⢠⣿⣿⣿⣿⠀⠈⠃⠀⠀⠀⠀⢀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠹⣿⣿⣿⣿⣿⣿⣿⣧⠀⠙⢿⡀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⠃⢠⣿⣿⣿⡏⡞⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⠀⢹⣿⣿⣿⣿⣿⣿⣿⣧⠀⠈⣧
DRAGON

echo -e "${reset}"
echo -e "${green}              KALI NETHUNTER FRAMEWORK${reset}"
echo -e "${yellow}              EvolutionX | POCO F1 / beryllium${reset}"
echo ""
sleep 0.4
}

while true; do
dragon_banner

echo -e "${green}[1] Patch NetHunter ZIP${reset}"
echo -e "${blue}[2] Build Generic WiFi Addon${reset}"
echo -e "${yellow}[3] Show System Info${reset}"
echo -e "${cyan}[4] Health Check${reset}"
echo -e "${red}[5] Exit${reset}"
echo ""

read -p "godmode@kali> " opt

case "$opt" in
1)
    clear
    echo -e "${yellow}[+] Starting Patch Engine...${reset}"
    sleep 1
    bash core/patch-engine.sh
    ;;

2)
    clear
    echo -e "${yellow}[+] Starting Generic WiFi Addon Engine...${reset}"
    sleep 1
    bash core/wifi-addon-engine.sh
    ;;

3)
    clear
    echo -e "${blue}[+] SYSTEM INFO${reset}"
    uname -a
    echo ""
    df -h /sdcard
    ;;

4)
    clear
    echo -e "${cyan}[+] Starting Health Check...${reset}"
    sleep 1
    bash core/health-check.sh
    ;;

5)
    echo -e "${red}[+] Exiting...${reset}"
    exit 0
    ;;

*)
    echo -e "${red}[!] Invalid option${reset}"
    ;;
esac

echo ""
read -p "Press Enter to continue..."
done
