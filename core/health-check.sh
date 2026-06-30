#!/usr/bin/env bash

BASE="$(cd "$(dirname "$0")/.." && pwd)"
cd "$BASE" || exit 1

green="\e[32m"
red="\e[31m"
yellow="\e[33m"
blue="\e[34m"
reset="\e[0m"

ok(){ echo -e "${green}[OK]${reset} $1"; }
warn(){ echo -e "${yellow}[WARN]${reset} $1"; }
bad(){ echo -e "${red}[BAD]${reset} $1"; }

echo -e "${blue}====================================${reset}"
echo -e "${blue} NetHunter Framework Health Check${reset}"
echo -e "${blue}====================================${reset}"
echo ""

echo "[*] Storage:"
df -h /sdcard
echo ""

FREE_KB="$(df -k /sdcard | awk 'NR==2{print $4}')"
FREE_MB=$((FREE_KB / 1024))

if [ "$FREE_KB" -ge 4000000 ]; then
    ok "Storage good: ${FREE_MB} MB free"
else
    warn "Low storage: ${FREE_MB} MB free. Need 4000+ MB for patching."
fi

echo ""
echo "[*] Required tools:"

for tool in unzip zip sed find awk grep; do
    if command -v "$tool" >/dev/null 2>&1; then
        ok "$tool found"
    else
        bad "$tool missing"
    fi
done

echo ""
echo "[*] Framework files:"

[ -f menu/main-menu.sh ] && ok "main menu found" || bad "main menu missing"
[ -f core/patch-engine.sh ] && ok "patch engine found" || bad "patch engine missing"
[ -f core/wifi-addon-engine.sh ] && ok "WiFi addon engine found" || warn "WiFi addon engine missing"
[ -f bin/nh-godmode ] && ok "launcher found" || bad "launcher missing"

echo ""
echo "[*] NetHunter ZIPs:"

SRC="/sdcard/Download/kali-nethunter-2026.2-beryllium-los-fourteen-full.zip"
OUT="$(find /sdcard/Download -maxdepth 1 -type f -iname "*NO-KERNEL*.zip" 2>/dev/null | head -n 1)"

[ -f "$SRC" ] && ok "source full ZIP found" || warn "source full ZIP not found in Download"

if [ -n "$OUT" ] && [ -f "$OUT" ]; then
    ok "patched NO-KERNEL ZIP found: $(basename "$OUT")"
else
    warn "patched NO-KERNEL ZIP not found"
fi

echo ""
echo "[*] External SD check:"

for d in /storage/*; do
    case "$d" in
        /storage/emulated|/storage/self) continue ;;
    esac

    if [ -d "$d" ]; then
        ok "possible external SD: $d"
    fi
done

echo ""
echo -e "${green}[+] Health check complete.${reset}"
echo ""
read -r -p "Press Enter to continue..."
