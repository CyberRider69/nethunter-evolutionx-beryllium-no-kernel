#!/usr/bin/env bash
set -u

BASE="$(cd "$(dirname "$0")/.." && pwd)"
cd "$BASE" || exit 1

mkdir -p output logs
LOG="$BASE/logs/wifi-addon.log"
: > "$LOG"

green="\e[32m"
red="\e[31m"
yellow="\e[33m"
blue="\e[34m"
cyan="\e[36m"
reset="\e[0m"

say(){ echo -e "$*" | tee -a "$LOG"; }
pause(){ echo ""; read -r -p "Press Enter to continue..."; }

say "${green}======================================${reset}"
say "${green} Generic External WiFi Addon Engine ${reset}"
say "${green}======================================${reset}"
say ""

say "${yellow}[*] Searching for .ko modules in /sdcard/Download...${reset}"

mapfile -t KO_LIST < <(find /sdcard/Download -maxdepth 1 -type f -iname "*.ko" 2>/dev/null)

if [ "${#KO_LIST[@]}" -eq 0 ]; then
    say "${red}[-] No .ko modules found.${reset}"
    say "${yellow}[!] Put your WiFi driver .ko in /sdcard/Download first.${reset}"
    pause
    exit 1
fi

i=1
for ko in "${KO_LIST[@]}"; do
    echo "[$i] $(basename "$ko")"
    i=$((i+1))
done

echo ""
read -r -p "Select driver number: " choice

case "$choice" in
    ''|*[!0-9]*)
        say "${red}[-] Invalid choice.${reset}"
        pause
        exit 1
        ;;
esac

index=$((choice-1))

if [ "$index" -lt 0 ] || [ "$index" -ge "${#KO_LIST[@]}" ]; then
    say "${red}[-] Choice out of range.${reset}"
    pause
    exit 1
fi

KO_FILE="${KO_LIST[$index]}"
KO_BASE="$(basename "$KO_FILE")"
DRIVER_NAME="${KO_BASE%.ko}"

say "${blue}[+] Selected:${reset} $KO_BASE"

KIT="$BASE/output/External-WiFi-Addon-Kit"
OUT="/sdcard/Download/External-WiFi-Addon-${DRIVER_NAME}.zip"

rm -rf "$KIT"
mkdir -p "$KIT/files" "$KIT/scripts"

cp "$KO_FILE" "$KIT/files/$KO_BASE"

cat > "$KIT/README.txt" <<README
External WiFi Addon Kit

Included driver:
$KO_BASE

This kit is not recovery flashable.
Extract it and run scripts manually.

Check kernel:
uname -r

Check module:
modinfo files/$KO_BASE | grep vermagic

Test load:
bash scripts/load-now.sh

Install as Magisk module:
bash scripts/install-magisk-module.sh
README

cat > "$KIT/scripts/load-now.sh" <<LOADNOW
#!/usr/bin/env bash
DIR="\$(cd "\$(dirname "\$0")/.." && pwd)"
KO="\$DIR/files/$KO_BASE"

echo "[*] Loading $KO_BASE"
uname -r
modinfo "\$KO" 2>/dev/null | grep -E "vermagic|version|description" || true

su -c "rmmod $DRIVER_NAME 2>/dev/null"
su -c "insmod '\$KO'"

echo "[*] Check:"
lsmod | grep "$DRIVER_NAME" || true
LOADNOW

chmod +x "$KIT/scripts/load-now.sh"

cat > "$KIT/scripts/install-magisk-module.sh" <<INSTALL
#!/usr/bin/env bash
MODID="external_wifi_$DRIVER_NAME"
DIR="\$(cd "\$(dirname "\$0")/.." && pwd)"
KO="\$DIR/files/$KO_BASE"

echo "[*] Installing Magisk module: \$MODID"

su -c "mkdir -p /data/adb/modules/\$MODID"
su -c "cp '\$KO' /data/adb/modules/\$MODID/$KO_BASE"

su -c "cat > /data/adb/modules/\$MODID/module.prop <<PROP
id=external_wifi_$DRIVER_NAME
name=External WiFi Driver - $DRIVER_NAME
version=1.0
versionCode=1
author=CyberRyder
description=Optional external WiFi driver loader
PROP"

su -c "cat > /data/adb/modules/\$MODID/service.sh <<SERVICE
#!/system/bin/sh
sleep 15
if ! lsmod | grep -q '$DRIVER_NAME'; then
    insmod /data/adb/modules/\$MODID/$KO_BASE
fi
SERVICE"

su -c "chmod 755 /data/adb/modules/\$MODID/service.sh"
su -c "chmod 644 /data/adb/modules/\$MODID/$KO_BASE"

echo "[+] Installed. Reboot required."
INSTALL

chmod +x "$KIT/scripts/install-magisk-module.sh"

cd "$BASE/output" || exit 1
rm -f "$OUT"
zip -qr "$OUT" "External-WiFi-Addon-Kit"

cd "$BASE" || exit 1

say ""
say "${green}[+] DONE${reset}"
say "${blue}[+] Output:${reset} $OUT"
say "${blue}[+] Log:${reset} $LOG"
pause
