#!/usr/bin/env bash
set -u

BASE="$(cd "$(dirname "$0")/.." && pwd)"
cd "$BASE" || exit 1

mkdir -p logs workdir

LOG="$BASE/logs/patch.log"
: > "$LOG"

green="\e[32m"
red="\e[31m"
yellow="\e[33m"
blue="\e[34m"
reset="\e[0m"

say() {
    echo -e "$*" | tee -a "$LOG"
}

pause() {
    echo ""
    read -r -p "Press Enter to continue..."
}

say "${green}====================================${reset}"
say "${green} NetHunter EvolutionX Patch Engine ${reset}"
say "${green}====================================${reset}"
say ""

ZIP="/sdcard/Download/kali-nethunter-2026.2-beryllium-los-fourteen-full.zip"

if [ ! -f "$ZIP" ]; then
    say "${yellow}[*] Exact ZIP not found, scanning Download folder...${reset}"
    ZIP="$(find /sdcard/Download -maxdepth 1 -type f -iname "*nethunter*beryllium*full*.zip" 2>/dev/null | head -n 1)"
fi

if [ -z "${ZIP:-}" ] || [ ! -f "$ZIP" ]; then
    say "${red}[-] NetHunter full ZIP not found.${reset}"
    say "${yellow}[!] Put the full beryllium NetHunter ZIP in /sdcard/Download first.${reset}"
    pause
    exit 1
fi

FREE_KB="$(df -k /sdcard | awk 'NR==2{print $4}')"
FREE_MB=$((FREE_KB / 1024))

say "${blue}[+] Source ZIP:${reset} $ZIP"
say "${blue}[+] Free storage:${reset} ${FREE_MB} MB"

if [ "$FREE_KB" -lt 4000000 ]; then
    say ""
    say "${red}[-] Not enough free storage.${reset}"
    say "${yellow}[!] Need at least 4000 MB free on /sdcard.${reset}"
    say "${yellow}[!] Free now: ${FREE_MB} MB${reset}"
    say ""
    say "Clean old workdirs or old zips first."
    pause
    exit 1
fi

WORK="$BASE/workdir/nh-extract"
OUT="/sdcard/Download/kali-nethunter-2026.2-beryllium-evolutionx-NO-KERNEL.zip"

say ""
say "${yellow}[*] Cleaning old workdir...${reset}"
rm -rf "$WORK"
mkdir -p "$WORK"

say "${yellow}[*] Extracting ZIP...${reset}"
unzip -q "$ZIP" -d "$WORK"
if [ $? -ne 0 ]; then
    say "${red}[-] unzip failed.${reset}"
    pause
    exit 1
fi

cd "$WORK" || exit 1

say "${yellow}[*] Removing kernel payloads...${reset}"

rm -f kernel-nethunter.zip
rm -f boot-patcher/Image
rm -f boot-patcher/Image.gz
rm -f boot-patcher/Image.gz-dtb
rm -f boot-patcher/dtb
rm -f boot-patcher/dtbo.img
rm -f boot-patcher/ramdisk.cpio
rm -f boot-patcher/ramdisk.cpio.gz

find . -type f \( \
    -iname "Image" -o \
    -iname "Image.gz" -o \
    -iname "Image.gz-dtb" -o \
    -iname "kernel-nethunter.zip" -o \
    -iname "dtbo.img" \
\) -print -delete | tee -a "$LOG"

say "${yellow}[*] Disabling boot image write calls...${reset}"

PATCHED=0

for f in \
    META-INF/com/google/android/update-binary \
    META-INF/com/google/android/updater-script \
    META-INF/com/google/android/update-magisk \
    boot-patcher/anykernel.sh \
    boot-patcher/META-INF/com/google/android/update-binary \
    boot-patcher/META-INF/com/google/android/updater-script \
    boot-patcher/META-INF/com/google/android/update-magisk
do
    if [ -f "$f" ]; then
        say "${blue}[+] Patching:${reset} $f"
        cp "$f" "$f.bak-nhe"

        sed -i \
            -e 's/^\([[:space:]]*\)\(dump_boot\)/\1# disabled for EvolutionX no-kernel: \2/' \
            -e 's/^\([[:space:]]*\)\(write_boot\)/\1# disabled for EvolutionX no-kernel: \2/' \
            -e 's/^\([[:space:]]*\)\(flash_boot\)/\1# disabled for EvolutionX no-kernel: \2/' \
            -e 's/^\([[:space:]]*\)\(patch_boot\)/\1# disabled for EvolutionX no-kernel: \2/' \
            -e 's/^\([[:space:]]*\)\(write_dtbo\)/\1# disabled for EvolutionX no-kernel: \2/' \
            "$f"

        PATCHED=$((PATCHED + 1))
    fi
done

find . -name "*.bak-nhe" -delete

say "${blue}[+] Script files patched:${reset} $PATCHED"

say "${yellow}[*] Verifying removed kernel payloads...${reset}"

BAD="$(find . -type f \( \
    -iname "Image" -o \
    -iname "Image.gz" -o \
    -iname "Image.gz-dtb" -o \
    -iname "kernel-nethunter.zip" \
\) 2>/dev/null)"

if [ -n "$BAD" ]; then
    say "${red}[-] Kernel payload still found:${reset}"
    echo "$BAD" | tee -a "$LOG"
    pause
    exit 1
fi

say "${green}[+] Kernel payload check passed.${reset}"

say "${yellow}[*] Repacking no-kernel ZIP...${reset}"
rm -f "$OUT"

zip -qr "$OUT" .
if [ $? -ne 0 ]; then
    say "${red}[-] zip failed.${reset}"
    pause
    exit 1
fi

cd "$BASE" || exit 1

say ""
say "${green}====================================${reset}"
say "${green}[+] DONE${reset}"
say "${green}====================================${reset}"
say "${blue}[+] Output:${reset}"
say "$OUT"
say ""
say "${blue}[+] Log saved:${reset}"
say "$LOG"
say ""
say "${yellow}[!] Flash only after backup.${reset}"
say "${yellow}[!] This ZIP is no-kernel / EvolutionX-safe patched.${reset}"

pause
