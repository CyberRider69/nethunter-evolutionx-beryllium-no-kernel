# 📡 RTL8192EU USB WiFi Driver Package

This is a separate optional driver package for users with compatible **Realtek RTL8192EU USB WiFi adapters**.

It is not required for the main NetHunter no-kernel framework.

---

## ✅ Intended Capabilities

This driver package is intended to support:

- 📡 monitor mode
- 📦 packet capture
- 🧪 packet injection testing
- 🔍 wireless auditing
- 🛡️ authorized penetration testing labs
- 🧰 external USB WiFi adapter workflows

> ⚠️ Use only on your own networks or environments where you have clear permission to test.

---

## 📶 Supported Chipset

| Item | Details |
|---|---|
| Chipset | Realtek RTL8192EU |
| Common adapter example | TP-Link TL-WN822N v4 |
| Module name | `8192eu.ko` |

---

## 📦 Release Files

| File | Purpose |
|---|---|
| `rtl8192eu-linux-clean-source.tar.gz` | Clean source package users can compile for their own kernel |
| `8192eu.ko` | Optional precompiled kernel module |
| `modinfo.txt` | Optional module information, if provided |

---

## 🧠 Source vs Precompiled Module

### ✅ Source Package

Use this if you want to compile the driver for your own kernel:

```text
rtl8192eu-linux-clean-source.tar.gz

This is the recommended option because kernel modules are kernel-specific.

⚠️ Precompiled Module

Use this only if your running kernel matches the module vermagic:
8192eu.ko

Check running kernel:
uname -r
Check module vermagic:
modinfo 8192eu.ko | grep vermagic
If vermagic does not match, the module may fail to load.

🛠️ Build From Source
Extract:
tar -xzf rtl8192eu-linux-clean-source.tar.gz
cd rtl8192eu-linux
Build:
make clean
make
After build, the module should be created as:
8192eu.ko

🧪 Test Load
Unload old module if present:
sudo rmmod 8192eu 2>/dev/null
Load new module:
sudo insmod ./8192eu.ko

Verify:
lsmod | grep 8192eu
iw dev
Check logs:
dmesg | tail -n 80

📦 Optional System Install
sudo mkdir -p /lib/modules/$(uname -r)/extra
sudo cp 8192eu.ko /lib/modules/$(uname -r)/extra/
sudo depmod -a
sudo modprobe 8192eu

⚠️ Important Notes
Kernel modules are not universal.
A driver compiled for one kernel may fail on another kernel.

Common failure reasons:
kernel version mismatch
vermagic mismatch
missing kernel headers
conflicting existing driver
module signing restrictions

⚖️ Legal Notice
Use monitor mode, packet capture, and injection testing only on:
your own networks, authorized lab networks

legal wireless security testing environments

Do not test networks without permission.
