# 🐉 NetHunter EvolutionX Beryllium Framework

> ⚡ A mobile-friendly Kali NetHunter helper framework for **POCO F1 / beryllium** running **EvolutionX**, designed to build a safer **no-kernel NetHunter ZIP** plus optional external WiFi driver addon kits.

---

## 🚀 Project Goal

This framework helps users run Kali NetHunter components on EvolutionX without blindly replacing the existing ROM kernel or boot image.

It focuses on:

✅ safer no-kernel patching  
✅ modular WiFi driver addon support  
✅ Termux-friendly phone-only workflow  
✅ POCO F1 / beryllium support  
✅ clean Kali-style terminal menu  

---

## 📱 Target Device

| Item | Details |
|---|---|
| 📱 Device | Xiaomi POCO F1 |
| 🔖 Codename | beryllium |
| 🤖 ROM Target | EvolutionX / Android 15 based setup |
| 🧰 Workflow | Termux + Recovery |
| 🎯 Main Purpose | NetHunter support without forced kernel replacement |

---

## ✨ Features

### 🧩 1. No-Kernel NetHunter ZIP Builder

Converts a full NetHunter ZIP into an EvolutionX-safe no-kernel build.

It removes or disables:

- 🧠 kernel payloads
- 🔥 boot image write calls
- 📦 kernel image files
- 🧬 DTBO/kernel flashing payloads
- ⚙️ AnyKernel-style boot patch actions

Example output:

```text
kali-nethunter-2026.2-beryllium-evolutionx-NO-KERNEL.zip

---

## 🧱 Complete Build Guide

### 📥 Step 1: Clone the Project

Clone this framework into `/sdcard/Download`:

```sh
cd /sdcard/Download
git clone https://github.com/CyberRider69/nethunter-evolutionx-beryllium-no-kernel.git nethunter-framework
cd nethunter-framework
This downloads the framework source code.
📦 Step 2: Install Required Termux Packages
Install the tools required by the framework:
pkg update
pkg install zip unzip coreutils findutils sed grep gawk git nano
These packages are needed for extracting, patching, repacking, and running the framework scripts.
🐉 Step 3: Download Official NetHunter Full ZIP
Place the official NetHunter beryllium full ZIP in:
/sdcard/Download/
Expected example filename:
kali-nethunter-2026.2-beryllium-los-fourteen-full.zip
The framework uses this official ZIP as the source file.
This repository does not include the official NetHunter ZIP.
🚀 Step 4: Run the Framework
Start the dragon menu:
bash bin/nh-godmode
Then choose:
[1] Patch NetHunter ZIP
The framework will patch the official NetHunter ZIP and create a no-kernel EvolutionX-safe build.
✅ Step 5: Get the Patched Output
After patching finishes, the output will be created in:
/sdcard/Download/
Example output:
kali-nethunter-2026.2-beryllium-evolutionx-NO-KERNEL.zip
This is the patched ZIP users can test or flash after making backups.
