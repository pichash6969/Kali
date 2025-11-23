# 🐉 Kali Elite++ Ultimate v3.0

<div align="center">

![Kali Elite++ Banner](https://img.shields.io/badge/Kali-Elite++-557C94?style=for-the-badge&logo=kalilinux&logoColor=white)
![Version](https://img.shields.io/badge/Version-3.0-green?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)
![Tools](https://img.shields.io/badge/Tools-500+-red?style=for-the-badge)

**The Most Comprehensive Kali Linux Installation Script Ever Created**

[Features](#-features) • [Requirements](#-requirements) • [Installation](#-installation-guide) • [Tutorial](#-detailed-tutorial) • [FAQ](#-faq)

---

### 🎯 What is Kali Elite++?

Kali Elite++ is an **automated installer** that creates a fully-encrypted, feature-rich Kali Linux system on an external SSD/NVMe drive. It includes **500+ security tools**, **15 major feature categories**, and professional-grade security hardening.

</div>

---

## 📋 Table of Contents

1. [Features Overview](#-features-overview)
2. [Requirements](#-requirements)
3. [Pre-Installation Checklist](#-pre-installation-checklist)
4. [Detailed Tutorial](#-detailed-tutorial-for-beginners)
   - [Part 1: Understanding the Basics](#part-1-understanding-the-basics)
   - [Part 2: Preparing Your System](#part-2-preparing-your-system)
   - [Part 3: Creating Bootable USB](#part-3-creating-bootable-usb)
   - [Part 4: BIOS Configuration](#part-4-bios-configuration)
   - [Part 5: Running the Installation](#part-5-running-the-installation)
   - [Part 6: First Boot Setup](#part-6-first-boot-setup)
5. [Configuration Options](#-configuration-options)
6. [Troubleshooting](#-troubleshooting)
7. [FAQ](#-frequently-asked-questions)
8. [Legal Disclaimer](#%EF%B8%8F-legal-disclaimer)

---

## ✨ Features Overview

<details>
<summary><b>🔐 Feature 1: Hardware Security</b></summary>

- YubiKey/FIDO2 Support for LUKS
- TPM 2.0 Integration
- Secure Boot with MOK
- Hardware-based encryption keys

</details>

<details>
<summary><b>🌐 Feature 2: Advanced Networking</b></summary>

- VPN Kill Switch (auto-blocks if VPN drops)
- Multi-VPN Chaining
- I2P & Lokinet Networks
- DNS over HTTPS
- MAC Address Randomization
- IPv6 Leak Protection

</details>

<details>
<summary><b>📦 Feature 3: Containers & Virtualization</b></summary>

- Docker & Docker Compose
- Podman (rootless containers)
- QEMU/KVM with virt-manager
- Vagrant for VM automation
- Pre-built Vulnerable Labs (DVWA, Juice Shop, etc.)

</details>

<details>
<summary><b>🤖 Feature 4: AI & Automation</b></summary>

- AutoRecon for automated scanning
- ReconFTW for reconnaissance
- Osmedeus workflow automation
- AI-powered security assistant

</details>

<details>
<summary><b>☁️ Feature 5: Cloud Pentesting</b></summary>

- AWS CLI + Pacu + Prowler
- Azure CLI + ROADrecon
- GCP CLI + GCPBucketBrute
- Kubernetes tools (kubectl, k9s, kube-hunter)

</details>

<details>
<summary><b>📱 Feature 6: Mobile Pentesting</b></summary>

- Android tools (ADB, APKTool, JADX)
- Frida & Objection
- MobSF (Mobile Security Framework)
- iOS tools (libimobiledevice)

</details>

<details>
<summary><b>🔬 Feature 7: Reverse Engineering</b></summary>

- Ghidra, IDA Free, Radare2
- GDB with GEF/PEDA/pwndbg
- Binary exploitation tools
- Malware analysis environment

</details>

<details>
<summary><b>🎯 Feature 8: Threat Intelligence</b></summary>

- MISP Platform
- TheHive & Cortex
- YARA rules auto-update
- VirusTotal integration

</details>

<details>
<summary><b>🥷 Feature 9: Stealth & C2</b></summary>

- Sliver, Havoc, Covenant
- Payload obfuscation tools
- Traffic obfuscation
- Domain fronting guides

</details>

<details>
<summary><b>📝 Feature 10: Reporting</b></summary>

- LaTeX report templates
- Automatic screenshots
- Terminal session recording
- Findings database

</details>

<details>
<summary><b>💾 Feature 11: Backup & Recovery</b></summary>

- Encrypted cloud backups (Restic)
- Borg backup with deduplication
- Recovery USB creation
- LUKS header backup

</details>

<details>
<summary><b>📊 Feature 12: Monitoring</b></summary>

- Netdata dashboard
- Suricata IDS/IPS
- OSSEC/Wazuh HIDS
- Comprehensive audit logging

</details>

<details>
<summary><b>👥 Feature 13: Collaboration</b></summary>

- HedgeDoc for shared notes
- Slack/Discord webhooks
- Team password manager
- Syncthing file sync

</details>

<details>
<summary><b>🔧 Feature 14: Physical Security</b></summary>

- Proxmark3 RFID tools
- SDR (Software Defined Radio)
- BadUSB payload tools
- Rogue AP setup

</details>

<details>
<summary><b>🎮 Feature 15: CTF & Learning</b></summary>

- CTF toolkit
- HackTheBox integration
- TryHackMe setup
- Local CTFd platform
- Vulnerable VM auto-download

</details>

---

## 💻 Requirements

### Minimum Hardware Requirements

| Component | Minimum | Recommended | Notes |
|-----------|---------|-------------|-------|
| **External SSD** | 256 GB | 500 GB+ | NVMe preferred for speed |
| **RAM** | 8 GB | 16 GB+ | More RAM = faster installation |
| **USB Drive** | 8 GB | 16 GB | For Live boot environment |
| **Processor** | 64-bit | Multi-core | Intel/AMD x86_64 |
| **Internet** | Required | Fast broadband | Downloads ~50GB of data |

### System Requirements

| Feature | Requirement |
|---------|-------------|
| **Boot Mode** | UEFI (Legacy BIOS not supported) |
| **Secure Boot** | Can be disabled (required for installation) |
| **TPM** | Optional (for TPM-based encryption) |

### Time Requirements

| Internet Speed | Estimated Time |
|---------------|----------------|
| 10 Mbps | 4-5 hours |
| 50 Mbps | 2-3 hours |
| 100+ Mbps | 1.5-2 hours |

---

## ✅ Pre-Installation Checklist

Before starting, make sure you have:

- [ ] External SSD/NVMe (256GB minimum)
- [ ] USB drive (8GB minimum) for Live boot
- [ ] Stable internet connection
- [ ] 2-4 hours of free time
- [ ] LUKS password ready (12+ characters, memorable)
- [ ] Access to BIOS/UEFI settings
- [ ] Backup of any important data

---

## 📖 Detailed Tutorial for Beginners

> **📌 Note:** This tutorial is written for absolute beginners. If you're experienced, skip to [Quick Installation](#quick-installation).

---

### Part 1: Understanding the Basics

#### 🤔 What Will Happen?

```
┌─────────────────────────────────────────────────────────────────┐
│                     INSTALLATION OVERVIEW                        │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│   Your Computer                     External SSD                 │
│   ┌──────────────┐                 ┌──────────────┐             │
│   │              │                 │              │             │
│   │   Current    │    Install      │  Kali Elite  │             │
│   │   System     │ ───────────────▶│     ++       │             │
│   │   (Safe)     │                 │  (New OS)    │             │
│   │              │                 │              │             │
│   └──────────────┘                 └──────────────┘             │
│                                                                  │
│   ✓ Your current OS will NOT be affected                        │
│   ✓ Kali installs on EXTERNAL drive only                        │
│   ✓ You can boot either OS by selecting drive                   │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

#### 🔒 About Encryption

Your entire Kali system will be encrypted with **LUKS2** (Linux Unified Key Setup):

```
┌─────────────────────────────────────────────────────────────────┐
│                     ENCRYPTION EXPLAINED                         │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│   Without Password:              With Password:                  │
│   ┌──────────────┐              ┌──────────────┐                │
│   │ ████████████ │              │ Your Files   │                │
│   │ ████████████ │   Unlock     │ Your Tools   │                │
│   │ ████████████ │ ──────────▶  │ Your Data    │                │
│   │ (Encrypted)  │              │ (Readable)   │                │
│   └──────────────┘              └──────────────┘                │
│                                                                  │
│   🔐 If someone steals your SSD, they CANNOT read your data     │
│   🔐 You MUST remember your password (no recovery possible!)    │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

#### ⚠️ Important Warnings

> **🚨 CRITICAL:** The script will **COMPLETELY ERASE** the target disk!
> - Double-check you selected the EXTERNAL drive
> - NEVER select your internal drive by mistake
> - All data on target disk will be PERMANENTLY LOST

---

### Part 2: Preparing Your System

#### Step 2.1: Download Required Files

**Download Kali Linux Live ISO:**

1. Open browser and go to: **https://www.kali.org/get-kali/**
2. Click on **"Live Boot"**
3. Download **"64-bit"** version
4. File size: ~4 GB (wait for complete download)

```
📁 Downloaded file: kali-linux-2024.x-live-amd64.iso
```

**Download USB Writer Tool:**

| Operating System | Tool | Download Link |
|-----------------|------|---------------|
| Windows | Rufus | https://rufus.ie |
| Windows/Mac/Linux | Balena Etcher | https://etcher.balena.io |
| Linux | Built-in `dd` command | No download needed |

#### Step 2.2: Download the Script

**Option A: Download from GitHub**
```bash
# If repository exists:
git clone https://github.com/yourusername/kali-elite-ultimate.git
```

**Option B: Create manually**
1. Create a new file named `kali-elite-ultimate-v3.sh`
2. Copy the entire script content into this file
3. Save the file

---

### Part 3: Creating Bootable USB

#### For Windows Users (Using Rufus):

**Step-by-step with screenshots:**

```
Step 1: Insert USB drive (8GB+)
        ↓
Step 2: Open Rufus (run as Administrator)
        ↓
Step 3: Configure Rufus:
        ┌─────────────────────────────────────┐
        │            RUFUS                     │
        ├─────────────────────────────────────┤
        │ Device:        [Your USB Drive ▼]   │
        │                                      │
        │ Boot selection: [SELECT]            │
        │ → Choose kali-linux-xxx.iso         │
        │                                      │
        │ Partition scheme: [GPT ▼]           │
        │ Target system:    [UEFI ▼]          │
        │                                      │
        │ Volume label: KALI_LIVE             │
        │ File system:  FAT32                  │
        │                                      │
        │         [START]                      │
        └─────────────────────────────────────┘
        ↓
Step 4: Click START and wait (5-15 minutes)
        ↓
Step 5: Click CLOSE when complete
```

#### For Linux Users (Using dd):

```bash
# Step 1: Find your USB drive
lsblk
# Look for your USB (usually /dev/sdb or /dev/sdc)
# CHECK SIZE to confirm it's the USB, not your hard drive!

# Step 2: Unmount if mounted
sudo umount /dev/sdX*

# Step 3: Write ISO (REPLACE sdX with your USB!)
sudo dd if=kali-linux-2024.x-live-amd64.iso of=/dev/sdX bs=4M status=progress conv=fsync

# Step 4: Sync and eject
sync
sudo eject /dev/sdX
```

#### For Mac Users (Using Balena Etcher):

```
Step 1: Open Balena Etcher
        ↓
Step 2: Click "Flash from file" → Select Kali ISO
        ↓
Step 3: Click "Select target" → Choose USB drive
        ↓
Step 4: Click "Flash!" and enter password
        ↓
Step 5: Wait for completion
```

---

### Part 4: BIOS Configuration

#### Step 4.1: Enter BIOS/UEFI

**Restart computer and press the key repeatedly:**

| Brand | BIOS Key | Boot Menu Key |
|-------|----------|---------------|
| Dell | F2 | F12 |
| HP | F10 | F9 |
| Lenovo | F2 or Fn+F2 | F12 |
| ASUS | F2 or DEL | F8 |
| Acer | F2 | F12 |
| MSI | DEL | F11 |
| Gigabyte | DEL | F12 |
| Custom PC | DEL | F8/F11/F12 |

> **💡 Tip:** Start pressing the key immediately after power on, before the logo appears.

#### Step 4.2: Required BIOS Settings

```
┌─────────────────────────────────────────────────────────────────┐
│                     BIOS SETTINGS GUIDE                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  1. BOOT MODE                                                    │
│     ├── Find: "Boot" or "Startup" menu                          │
│     ├── Look for: "Boot Mode" or "UEFI/Legacy"                  │
│     └── Set to: UEFI (Disable CSM/Legacy)                       │
│                                                                  │
│  2. SECURE BOOT                                                  │
│     ├── Find: "Security" or "Boot" menu                         │
│     ├── Look for: "Secure Boot"                                 │
│     └── Set to: DISABLED                                        │
│                                                                  │
│  3. FAST BOOT                                                    │
│     ├── Find: "Boot" menu                                       │
│     ├── Look for: "Fast Boot" or "Quick Boot"                   │
│     └── Set to: DISABLED                                        │
│                                                                  │
│  4. BOOT PRIORITY                                                │
│     ├── Find: "Boot" menu                                       │
│     ├── Look for: "Boot Order" or "Boot Priority"               │
│     └── Move USB to FIRST position                              │
│                                                                  │
│  5. SAVE & EXIT                                                  │
│     └── Press F10 and confirm "Yes"                             │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

#### Visual Guide for BIOS:

```
BIOS Navigation:
┌───────────────────────────────────────────────────────────────┐
│  [Main]  [Advanced]  [Security]  [Boot]  [Exit]               │
├───────────────────────────────────────────────────────────────┤
│                                                                │
│  Use ARROW KEYS (←↑↓→) to navigate                           │
│  Use ENTER to select                                          │
│  Use +/- to change values                                     │
│  Use F10 to Save & Exit                                       │
│  Use ESC to go back                                           │
│                                                                │
└───────────────────────────────────────────────────────────────┘
```

---

### Part 5: Running the Installation

#### Step 5.1: Boot from Live USB

```
1. Insert Live USB (Kali) into computer
2. Connect External SSD (target for installation)
3. Restart computer
4. Press Boot Menu key (F12/F8/ESC)
5. Select your USB drive from list
6. Select "Live (amd64)" from Kali menu
7. Wait for desktop to load (1-3 minutes)
```

#### Step 5.2: Open Terminal

```
Method 1: Right-click on desktop → "Open Terminal Here"

Method 2: Click Applications (top-left) → System → Terminal

Method 3: Press Ctrl + Alt + T
```

#### Step 5.3: Identify Your External SSD

**This is the MOST IMPORTANT step! Wrong disk = Data loss!**

```bash
# Run this command:
lsblk -o NAME,SIZE,TYPE,MODEL

# Example output:
NAME    SIZE TYPE MODEL
sda     500G disk Samsung_SSD_860     ← Internal SSD (DON'T USE!)
├─sda1  512M part
├─sda2  499G part
sdb     256G disk WD_External_SSD     ← External SSD (USE THIS!)
sdc      16G disk USB_Flash_Drive     ← Live USB (DON'T USE!)
└─sdc1   16G part
```

**How to identify your External SSD:**

```
┌─────────────────────────────────────────────────────────────────┐
│                  IDENTIFYING YOUR EXTERNAL SSD                   │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  Method 1: Check the SIZE                                        │
│  ──────────────────────────                                      │
│  Your external SSD size should match what you purchased          │
│  (e.g., 256G, 500G, 1T)                                         │
│                                                                  │
│  Method 2: Check the MODEL                                       │
│  ──────────────────────────                                      │
│  Look for brand name (WD, Samsung, SanDisk, etc.)               │
│  External drives usually show "External" in name                 │
│                                                                  │
│  Method 3: Unplug Test                                           │
│  ──────────────────────                                          │
│  1. Run: lsblk                                                   │
│  2. Unplug your external SSD                                     │
│  3. Run: lsblk again                                             │
│  4. The disk that DISAPPEARED is your external SSD               │
│  5. Plug it back in                                              │
│                                                                  │
│  Method 4: Check recent connections                              │
│  ─────────────────────────────────                               │
│  Run: dmesg | tail -20                                           │
│  Look for recently attached device name                          │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

**⚠️ Write down your external SSD device name: `/dev/sd__`**

#### Step 5.4: Prepare the Script

```bash
# Step 1: Become root user
sudo su

# Step 2: Go to home directory
cd ~

# Step 3: Create script file
nano kali-elite-ultimate-v3.sh

# Step 4: Paste the script
# (Right-click → Paste, or Ctrl+Shift+V)

# Step 5: Save and exit
# Press: Ctrl + O (save)
# Press: Enter (confirm)
# Press: Ctrl + X (exit)

# Step 6: Make executable
chmod +x kali-elite-ultimate-v3.sh
```

#### Step 5.5: Configure the Script

```bash
# Open script for editing
nano kali-elite-ultimate-v3.sh
```

**Find and modify these lines (around line 70-90):**

```bash
# ══════════════════════════════════════════════════════════════════
#                    CHANGE THESE VALUES!
# ══════════════════════════════════════════════════════════════════

# Line ~70: Your external SSD (MOST IMPORTANT!)
DISK="/dev/sdb"              # ← Change to YOUR external SSD!

# Line ~71: Hostname (computer name on network)
HOSTNAME="kali-elite"        # ← Change if you want

# Line ~72: Your username
USERNAME="operator"          # ← Your preferred username

# Line ~73: Password (leave empty to enter during installation)
PASSWORD=""                  # ← Recommended: leave empty

# Line ~74: Your timezone
TIMEZONE="Asia/Kolkata"      # ← Change to your timezone
# Examples:
#   Asia/Kolkata (India)
#   America/New_York (US East)
#   Europe/London (UK)
#   Asia/Dubai (UAE)

# ══════════════════════════════════════════════════════════════════
#                    PARTITION SIZES (in GB)
# ══════════════════════════════════════════════════════════════════

SWAP_SIZE_GB=16              # ← Same as your RAM amount
ROOT_SIZE_GB=100             # ← Main system (50-100 GB)
HOME_SIZE_GB=80              # ← Your files (adjust as needed)
DATA_SIZE_GB=100             # ← Extra storage (adjust as needed)
```

**Partition Size Guide:**

```
┌─────────────────────────────────────────────────────────────────┐
│                    PARTITION SIZE GUIDE                          │
├─────────────────────────────────────────────────────────────────┤
│     
