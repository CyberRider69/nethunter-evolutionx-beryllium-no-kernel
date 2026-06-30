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
