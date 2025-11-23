#!/bin/bash
#
# ╔═══════════════════════════════════════════════════════════════════════════╗
# ║           KALI LINUX ELITE++ ULTIMATE INSTALLER v3.0                      ║
# ║                                                                           ║
# ║   The Most Comprehensive Kali Linux Installation Script Ever Created     ║
# ║                                                                           ║
# ║   Features: 15+ Major Categories | 500+ Tools | Full Automation          ║
# ╚═══════════════════════════════════════════════════════════════════════════╝
#
# WARNING: This script WILL COMPLETELY WIPE the target disk!
# Run ONLY from a Live Linux environment (Ubuntu/Kali Live) as root.
#
# LEGAL DISCLAIMER:
# This script is intended SOLELY for authorized security testing, research,
# and educational purposes. You MUST have explicit written permission before
# testing any systems. Unauthorized access to computer systems is ILLEGAL.
# The authors assume NO responsibility for misuse of this tool.
#
# REQUIREMENTS:
# - Live Linux environment (USB boot)
# - Minimum 256GB external SSD/NVMe
# - Minimum 16GB RAM recommended
# - UEFI-capable system
# - Internet connection
#
# ESTIMATED INSTALLATION TIME: 2-4 hours (depending on internet speed)
#

set -euo pipefail
IFS=$'\n\t'

# ╔═══════════════════════════════════════════════════════════════════════════╗
# ║                         GLOBAL VARIABLES                                  ║
# ╚═══════════════════════════════════════════════════════════════════════════╝

VERSION="3.0.0"
SCRIPT_NAME="Kali Elite++ Ultimate Installer"
SCRIPT_DATE="2024"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
ORANGE='\033[0;33m'
NC='\033[0m'

# Logging
LOG_DIR="/var/log/kali-elite"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/install_$(date +%Y%m%d_%H%M%S).log"
exec > >(tee -a "$LOG_FILE") 2>&1

# ╔═══════════════════════════════════════════════════════════════════════════╗
# ║                         LOGGING FUNCTIONS                                 ║
# ╚═══════════════════════════════════════════════════════════════════════════╝

log_info() { echo -e "${GREEN}[✓ INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[⚠ WARN]${NC} $1"; }
log_error() { echo -e "${RED}[✗ ERROR]${NC} $1"; }
log_section() { 
    echo -e "\n${PURPLE}╔════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}║${NC} ${CYAN}$1${NC}"
    echo -e "${PURPLE}╚════════════════════════════════════════════════════════════════╝${NC}\n"
}
log_subsection() { echo -e "\n${BLUE}▶ $1${NC}\n"; }
log_progress() { echo -e "${ORANGE}[→]${NC} $1"; }

show_banner() {
    clear
    echo -e "${RED}"
    cat << 'BANNER'
    ╔═══════════════════════════════════════════════════════════════════════════════╗
    ║                                                                               ║
    ║   ██╗  ██╗ █████╗ ██╗     ██╗    ███████╗██╗     ██╗████████╗███████╗         ║
    ║   ██║ ██╔╝██╔══██╗██║     ██║    ██╔════╝██║     ██║╚══██╔══╝██╔════╝         ║
    ║   █████╔╝ ███████║██║     ██║    █████╗  ██║     ██║   ██║   █████╗           ║
    ║   ██╔═██╗ ██╔══██║██║     ██║    ██╔══╝  ██║     ██║   ██║   ██╔══╝           ║
    ║   ██║  ██╗██║  ██║███████╗██║    ███████╗███████╗██║   ██║   ███████╗         ║
    ║   ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝    ╚══════╝╚══════╝╚═╝   ╚═╝   ╚══════╝         ║
    ║                                                                               ║
    ║                    ╔═╗╦  ╦ ╦╔═╗    ╔═╗╦  ╦ ╦╔═╗                               ║
    ║                    ╠═╝║  ║ ║╚═╗    ╠═╝║  ║ ║╚═╗                               ║
    ║                    ╩  ╩═╝╚═╝╚═╝    ╩  ╩═╝╚═╝╚═╝                               ║
    ║                                                                               ║
    ║                   ULTIMATE INSTALLER v3.0                                     ║
    ║                   The Most Comprehensive Kali Setup                           ║
    ║                                                                               ║
    ╚═══════════════════════════════════════════════════════════════════════════════╝
BANNER
    echo -e "${NC}"
    echo -e "${CYAN}    Version: $VERSION | Created: $SCRIPT_DATE | Log: $LOG_FILE${NC}\n"
}

# ╔═══════════════════════════════════════════════════════════════════════════╗
# ║                    MAIN CONFIGURATION                                     ║
# ╚═══════════════════════════════════════════════════════════════════════════╝

# ============= DISK CONFIGURATION =============
DISK="/dev/sdb"                    # TARGET DISK - CHANGE THIS!
HOSTNAME="kali-elite"
USERNAME="operator"
PASSWORD=""                        # Leave empty to prompt securely
TIMEZONE="Asia/Kolkata"
LOCALE="en_US.UTF-8"
KEYBOARD="us"
KALI_MIRROR="https://http.kali.org/kali"

# ============= PARTITION SIZES (GB) =============
EFI_SIZE_MB=512
BOOT_SIZE_MB=1024                  # Separate /boot for encryption
SWAP_SIZE_GB=16
ROOT_SIZE_GB=100
HOME_SIZE_GB=80
DATA_SIZE_GB=100
VENTOY_SIZE_GB=50

# ============= FILESYSTEM OPTIONS =============
# Options: "ext4", "btrfs", "f2fs", "xfs"
ROOT_FILESYSTEM="btrfs"
HOME_FILESYSTEM="btrfs"
DATA_FILESYSTEM="ext4"

# ============= ENCRYPTION OPTIONS =============
ENCRYPTION_TYPE="luks2"            # luks1, luks2
ENCRYPTION_CIPHER="aes-xts-plain64"
ENCRYPTION_KEY_SIZE=512
ENCRYPTION_HASH="sha512"
ENCRYPTION_ITER_TIME=5000

# ============= DESKTOP ENVIRONMENT =============
# Options: "i3", "bspwm", "xfce", "gnome", "kde", "none"
DESKTOP_ENV="i3"
INSTALL_SECONDARY_DE=true          # Install XFCE as backup
ENABLE_WAYLAND=false               # Experimental

# ╔═══════════════════════════════════════════════════════════════════════════╗
# ║                    FEATURE TOGGLES                                        ║
# ╚═══════════════════════════════════════════════════════════════════════════╝

# ============= 1. HARDWARE SECURITY =============
ENABLE_YUBIKEY=true                # YubiKey/FIDO2 for LUKS
ENABLE_TPM=true                    # TPM 2.0 integration
ENABLE_SECURE_BOOT=true            # Secure Boot with MOK
ENABLE_INTEL_ME_DISABLE=false      # Dangerous - disable Intel ME

# ============= 2. ADVANCED NETWORKING =============
ENABLE_MULTI_VPN=true              # VPN chaining
ENABLE_I2P=true                    # I2P network
ENABLE_LOKINET=true                # Lokinet
ENABLE_KILL_SWITCH=true            # VPN kill switch
ENABLE_TRAFFIC_SPLITTING=true      # Per-app VPN routing
ENABLE_DNS_LEAK_PROTECTION=true    # DNS leak prevention
ENABLE_IPV6_DISABLE=true           # Disable IPv6

# ============= 3. CONTAINERS & VIRTUALIZATION =============
ENABLE_DOCKER=true                 # Docker CE
ENABLE_PODMAN=true                 # Rootless containers
ENABLE_LXC=true                    # System containers
ENABLE_QEMU_KVM=true               # Full virtualization
ENABLE_VAGRANT=true                # VM automation
ENABLE_VULNERABLE_LABS=true        # Pre-built vuln labs

# ============= 4. AI & AUTOMATION =============
ENABLE_AI_TOOLS=true               # AI-assisted tools
ENABLE_AUTO_RECON=true             # Automated reconnaissance
ENABLE_WORKFLOW_AUTOMATION=true    # Osmedeus, etc.

# ============= 5. CLOUD PENTESTING =============
ENABLE_AWS_TOOLS=true              # AWS pentesting
ENABLE_AZURE_TOOLS=true            # Azure pentesting
ENABLE_GCP_TOOLS=true              # GCP pentesting
ENABLE_KUBERNETES_TOOLS=true       # K8s pentesting

# ============= 6. MOBILE PENTESTING =============
ENABLE_ANDROID_TOOLS=true          # Android testing
ENABLE_IOS_TOOLS=true              # iOS testing
ENABLE_FRIDA=true                  # Dynamic instrumentation

# ============= 7. REVERSE ENGINEERING =============
ENABLE_RE_TOOLS=true               # Ghidra, IDA, etc.
ENABLE_DEBUGGING=true              # GDB + plugins
ENABLE_MALWARE_ANALYSIS=true       # Malware lab setup

# ============= 8. THREAT INTELLIGENCE =============
ENABLE_THREAT_INTEL=true           # MISP, OpenCTI
ENABLE_INCIDENT_RESPONSE=true      # TheHive, Cortex
ENABLE_YARA_RULES=true             # Auto-update rules

# ============= 9. STEALTH & ANTI-DETECTION =============
ENABLE_STEALTH_TOOLS=true          # Evasion frameworks
ENABLE_C2_FRAMEWORKS=true          # Command & Control
ENABLE_TRAFFIC_OBFUSCATION=true    # Traffic hiding

# ============= 10. REPORTING & DOCUMENTATION =============
ENABLE_AUTO_SCREENSHOTS=true       # Automatic screenshots
ENABLE_VIDEO_RECORDING=true        # Terminal recording
ENABLE_REPORT_GENERATOR=true       # LaTeX/Markdown reports
ENABLE_FINDING_DATABASE=true       # SQLite findings DB

# ============= 11. BACKUP & RECOVERY =============
ENABLE_ENCRYPTED_BACKUP=true       # Restic + Rclone
ENABLE_BORG_BACKUP=true            # Borg dedup backup
ENABLE_SYSTEM_IMAGING=true         # Full disk imaging
ENABLE_USB_RECOVERY=true           # Recovery USB creation

# ============= 12. MONITORING & ALERTING =============
ENABLE_SYSTEM_MONITORING=true      # Netdata, htop
ENABLE_NETWORK_IDS=true            # Suricata, Zeek
ENABLE_HOST_IDS=true               # OSSEC/Wazuh
ENABLE_AUDIT_LOGGING=true          # Comprehensive auditing

# ============= 13. COLLABORATION =============
ENABLE_TEAM_NOTES=true             # Shared documentation
ENABLE_REALTIME_COLLAB=true        # CodiMD/HedgeDoc
ENABLE_WEBHOOKS=true               # Slack/Discord alerts
ENABLE_PASSWORD_MANAGER=true       # Team password vault

# ============= 14. PHYSICAL SECURITY =============
ENABLE_RFID_TOOLS=true             # Proxmark3 support
ENABLE_SDR_TOOLS=true              # Software Defined Radio
ENABLE_HARDWARE_HACKING=true       # Arduino, etc.
ENABLE_BADUSB_TOOLS=true           # Rubber Ducky, etc.

# ============= 15. CTF & LEARNING =============
ENABLE_CTF_TOOLS=true              # CTF utilities
ENABLE_VULNERABLE_VMS=true         # Auto-download vuln VMs
ENABLE_HTB_INTEGRATION=true        # HackTheBox setup
ENABLE_THM_INTEGRATION=true        # TryHackMe setup
ENABLE_LOCAL_CTF_PLATFORM=true     # Self-hosted CTFd

# ============= GENERAL FEATURES =============
ENABLE_FULL_KALI_META=true         # kali-linux-everything
ENABLE_APPARMOR=true
ENABLE_SELINUX=false               # Choose one: AppArmor OR SELinux
ENABLE_FAIL2BAN=true
ENABLE_USBGUARD=true
ENABLE_CLAMAV=true
ENABLE_RKHUNTER=true
ENABLE_ZRAM=true
ENABLE_PRELOAD=true
ENABLE_EARLYOOM=true
ENABLE_SSD_OPTIMIZATION=true

# ╔═══════════════════════════════════════════════════════════════════════════╗
# ║                    COMPREHENSIVE TOOL LISTS                               ║
# ╚═══════════════════════════════════════════════════════════════════════════╝

# ============= RECONNAISSANCE TOOLS =============
RECON_TOOLS=(
    # DNS & Subdomain
    "amass" "subfinder" "assetfinder" "findomain" "dnsx" "shuffledns"
    "dnsrecon" "dnsenum" "fierce" "dnsmap" "massdns"
    # Web Discovery
    "httpx-toolkit" "httprobe" "meg" "waybackurls" "gau" "hakrawler"
    "gospider" "katana" "photon" "paramspider"
    # Port Scanning
    "nmap" "masscan" "rustscan" "unicornscan" "zmap"
    # Web Scanning
    "nikto" "whatweb" "wappalyzer-cli" "webanalyze" "wafw00f"
    "nuclei" "jaeles"
    # Directory Bruteforce
    "gobuster" "ffuf" "feroxbuster" "dirsearch" "dirb" "wfuzz"
    # CMS Scanners
    "wpscan" "joomscan" "droopescan" "cmseek" "plecost"
    # Technology Detection
    "whatweb" "builtwith" "wappalyzer"
    # Screenshot
    "gowitness" "eyewitness" "aquatone" "webscreenshot"
    # API Testing
    "arjun" "kiterunner" "graphqlmap"
    # Cloud Recon
    "cloud-enum" "s3scanner" "bucket-finder" "lazys3" "festin"
    "grayhatwarfare" "cloudhunter"
)

# ============= EXPLOITATION TOOLS =============
EXPLOIT_TOOLS=(
    # Frameworks
    "metasploit-framework" "exploitdb" "searchsploit"
    # SQL Injection
    "sqlmap" "nosqlmap" "ghauri" "sqlninja" "jsql-injection"
    # XSS
    "xsser" "xsstrike" "dalfox" "kxss"
    # Command Injection
    "commix" "cmdinjector"
    # File Inclusion
    "fimap" "dotdotpwn"
    # XXE
    "xxeinjector" "oxml_xxe"
    # SSRF
    "ssrfmap" "gopherus"
    # Deserialization
    "ysoserial" "marshalsec"
    # SMB/Windows
    "crackmapexec" "evil-winrm" "impacket-scripts" "smbmap" "smbclient"
    "rpcclient" "enum4linux" "enum4linux-ng"
    # Active Directory
    "bloodhound" "neo4j" "ldapdomaindump" "kerbrute" "rubeus"
    "mimikatz" "pypykatz" "lsassy" "ntlmrelayx" "responder"
    # Network Exploitation
    "bettercap" "ettercap" "mitmproxy" "sslstrip"
    # Payload Generation
    "msfvenom" "veil" "shellter" "unicorn-magic" "donut"
    # C2 Frameworks
    "sliver" "havoc" "covenant" "merlin" "poshc2"
    # Tunneling
    "chisel" "ligolo-ng" "rpivot" "dnscat2" "iodine"
    # Shells
    "pwncat" "penelope" "shellerator"
)

# ============= POST-EXPLOITATION TOOLS =============
POST_EXPLOIT_TOOLS=(
    # Privilege Escalation
    "linpeas" "winpeas" "linenum" "linux-exploit-suggester"
    "windows-exploit-suggester" "pspy" "traitor" "gtfobins"
    "lolbas" "sudo_killer" "suid3num"
    # Credential Harvesting
    "mimikatz" "lazagne" "pypykatz" "secretsdump"
    "dploot" "masky" "gosecretsdump"
    # Active Directory
    "bloodhound" "sharphound" "adidnsdump" "certipy"
    "petitpotam" "printnightmare" "zerologon"
    # Lateral Movement
    "crackmapexec" "psexec" "wmiexec" "smbexec" "atexec"
    "dcomexec" "evil-winrm"
    # Persistence
    "empire" "starkiller" "covenant" "silenttrinity"
    # Data Exfiltration
    "dnsexfiltrator" "cloakify" "packetsender"
    # Situational Awareness
    "seatbelt" "sharpup" "powerup" "privesccheck"
    # Token Manipulation
    "incognito" "tokenvator" "sharpsploit"
)

# ============= WIRELESS TOOLS =============
WIRELESS_TOOLS=(
    # WiFi
    "aircrack-ng" "airmon-ng" "airodump-ng" "aireplay-ng"
    "bettercap" "wifite" "fluxion" "airgeddon" "wifiphisher"
    "hostapd-wpe" "eaphammer" "fern-wifi-cracker"
    # WPA/WPA2 Cracking
    "hashcat" "john" "cowpatty" "hcxtools" "hcxdumptool"
    "pyrit" "asleap"
    # WPS
    "reaver" "bully" "pixiewps"
    # Analysis
    "kismet" "wireshark" "tcpdump" "horst" "wavemon"
    # Jamming/Deauth
    "mdk4" "mdk3"
    # Bluetooth
    "bluez" "bluez-tools" "bluesnarfer" "spooftooph" "btlejack"
    "bettercap" "ubertooth"
    # RFID/NFC
    "libnfc" "mfoc" "mfcuk" "nfc-tools"
    # SDR
    "gnuradio" "gqrx" "rtl-sdr" "hackrf" "gr-osmosdr"
    "kalibrate-rtl" "dump1090" "multimon-ng"
    # ZigBee
    "killerbee" "zbstumbler" "zbdsniff"
    # LoRa
    "lora-tools"
)

# ============= FORENSICS TOOLS =============
FORENSIC_TOOLS=(
    # Disk Forensics
    "autopsy" "sleuthkit" "foremost" "scalpel" "photorec"
    "testdisk" "dc3dd" "dcfldd" "guymager" "ewf-tools"
    "afflib-tools" "fdisk" "gdisk" "parted"
    # Memory Forensics
    "volatility3" "volatility" "rekall" "lime" "avml"
    # File Analysis
    "binwalk" "bulk-extractor" "exiftool" "mat2"
    "pdfid" "pdf-parser" "oletools" "olevba"
    # Timeline
    "plaso" "log2timeline" "timesketch"
    # Registry
    "regripper" "hivex"
    # Network Forensics
    "wireshark" "tshark" "tcpdump" "ngrep" "netflow"
    "zeek" "suricata" "snort"
    # Email Forensics
    "pffexport" "pst-utils"
    # Mobile Forensics
    "adb" "libimobiledevice" "ideviceinstaller"
    # Malware Analysis
    "yara" "clamav" "radare2" "ghidra" "cutter"
    "strace" "ltrace" "gdb"
    # Anti-Forensics Detection
    "chkrootkit" "rkhunter" "lynis" "unhide" "lsof"
    # Steganography
    "steghide" "stegseek" "zsteg" "stegsolve" "openstego"
    "outguess" "snow"
    # Password Recovery
    "john" "hashcat" "ophcrack" "samdump2" "creddump"
    # Evidence Collection
    "dc3dd" "dcfldd" "ftk-imager"
)

# ============= OSINT TOOLS =============
OSINT_TOOLS=(
    # Username/Email
    "sherlock" "maigret" "holehe" "socialscan"
    "whatsmyname" "namechk" "emailharvester"
    "h8mail" "pwndb" "dehashed"
    # Social Media
    "twint" "instaloader" "toutatis" "osintgram"
    "tinfoleak" "twitterosint" "socialscan"
    # People Search
    "theHarvester" "maltego" "spiderfoot" "recon-ng"
    "datasploit" "osrframework"
    # Phone
    "phoneinfoga" "ignorant" "tmobile-lookup"
    # Website
    "photon" "metagoofil" "exiftool" "foca"
    "waybackurls" "webarchive" "carbon14"
    # Domain/IP
    "whois" "host" "dig" "nslookup" "amass"
    "dnsrecon" "shodan" "censys" "zoomeye"
    # Image
    "exiftool" "mat2" "fotoforensics"
    # Geo
    "creepy" "geosint" "geolocate"
    # Document
    "foca" "metagoofil" "exiftool"
    # Framework
    "spiderfoot" "maltego" "recon-ng" "theHarvester"
    "osrframework" "datasploit"
    # Dark Web
    "onionscan" "torsocks" "tor" "ahmia"
    # Threat Intel
    "misp" "yeti" "opencti" "threatconnect"
)

# ============= PRIVACY TOOLS =============
PRIVACY_TOOLS=(
    # Anonymity Networks
    "tor" "torsocks" "proxychains4" "i2pd" "lokinet"
    # VPN
    "openvpn" "wireguard" "wireguard-tools" "openconnect"
    "strongswan" "libreswan"
    # DNS Privacy
    "stubby" "dnscrypt-proxy" "unbound" "dnsmasq"
    # Identity
    "macchanger" "hostname" "proxychains4"
    # Encryption
    "gnupg" "age" "veracrypt" "cryptsetup" "tomb"
    "gocryptfs" "encfs" "ecryptfs-utils"
    # Secure Deletion
    "srm" "wipe" "secure-delete" "shred" "bleachbit"
    # Metadata
    "mat2" "exiftool" "pdfparanoia"
    # Password Management
    "keepassxc" "pass" "gopass" "bitwarden-cli"
    # Communication
    "signal-desktop" "element-desktop" "onionshare"
    # Sandboxing
    "firejail" "apparmor" "bubblewrap"
    # Firewall
    "ufw" "iptables" "nftables" "opensnitch"
    # Anti-Tracking
    "privoxy" "squid"
)

# ============= DEVELOPMENT TOOLS =============
DEV_TOOLS=(
    # Languages
    "python3" "python3-pip" "python3-venv" "python3-dev"
    "golang" "rustc" "cargo"
    "nodejs" "npm" "yarn"
    "ruby" "ruby-dev" "gem"
    "perl" "php" "lua5.4"
    "openjdk-17-jdk" "maven" "gradle"
    # C/C++
    "gcc" "g++" "clang" "llvm" "make" "cmake" "ninja-build"
    "autoconf" "automake" "libtool" "pkg-config"
    # Debugging
    "gdb" "lldb" "valgrind" "strace" "ltrace"
    "gdb-peda" "gdb-gef" "gdb-pwndbg"
    # Reverse Engineering
    "radare2" "r2ghidra" "cutter" "ghidra" "ida-free"
    "binwalk" "objdump" "readelf" "nm"
    # Binary Exploitation
    "pwntools" "ropper" "ropgadget" "one_gadget"
    "checksec" "patchelf" "afl++" "libfuzzer"
    # Editors
    "vim" "neovim" "emacs" "vscode" "sublime-text"
    # Version Control
    "git" "git-lfs" "tig" "lazygit"
    # Containers
    "docker.io" "docker-compose" "podman" "buildah" "skopeo"
    # Virtualization
    "qemu-system" "qemu-kvm" "libvirt" "virt-manager"
    "vagrant" "virtualbox" "packer"
    # Terminal
    "tmux" "screen" "zsh" "fish" "starship"
    "fzf" "ripgrep" "fd-find" "bat" "exa" "jq" "yq"
    # Documentation
    "pandoc" "texlive-full" "asciidoc" "sphinx"
    # Network Tools
    "curl" "wget" "httpie" "aria2" "axel"
    "ncat" "socat" "netcat" "telnet"
)

# ============= CLOUD PENTESTING TOOLS =============
CLOUD_TOOLS=(
    # AWS
    "awscli" "pacu" "prowler" "scoutsuite" "cloudsploit"
    "s3scanner" "bucket-finder" "lazys3" "cloudmapper"
    "enumerate-iam" "weirdaal" "nimbostratus" "barq"
    # Azure
    "azure-cli" "roadrecon" "stormspotter" "azurehound"
    "microburst" "powerzure" "azucar"
    # GCP
    "gcloud" "gcphound" "gcpbucketbrute" "hayat"
    # Multi-Cloud
    "cloudfox" "cloudlist" "cloudenum" "cloud_enum"
    # Kubernetes
    "kubectl" "kubectx" "kubens" "k9s" "kube-hunter"
    "kubeaudit" "kube-bench" "trivy" "kubesec"
    "kube-score" "popeye" "polaris" "starboard"
    "peirates" "kdigger" "kubeletctl"
    # Container Security
    "trivy" "grype" "syft" "dive" "hadolint"
    "dockle" "clair" "anchore" "falco"
    # Infrastructure as Code
    "terraform" "pulumi" "ansible" "chef" "puppet"
    "tfsec" "checkov" "terrascan" "tflint"
    # Serverless
    "sls" "claudia" "lambda-proxy"
)

# ============= MOBILE PENTESTING TOOLS =============
MOBILE_TOOLS=(
    # Android
    "android-sdk" "android-platform-tools" "adb" "fastboot"
    "apktool" "jadx" "dex2jar" "smali" "baksmali"
    "apksigner" "zipalign" "aapt2"
    "drozer" "qark" "mobsf" "androbugs"
    "androguard" "androwarn" "exodus-standalone"
    # Dynamic Analysis
    "frida" "frida-tools" "objection" "fridump"
    "r2frida" "medusa" "house"
    # iOS
    "libimobiledevice" "ideviceinstaller" "ifuse"
    "iproxy" "ipatool" "plutil" "plistutil"
    "clutch" "dumpdecrypted" "cycript"
    # Network
    "burpsuite" "mitmproxy" "charles-proxy"
    # Emulators
    "genymotion" "android-emulator"
    # Automation
    "appium" "uiautomator"
    # Malware Analysis
    "quark-engine" "apkid" "ssdeep"
)

# ============= THREAT INTEL TOOLS =============
THREAT_INTEL_TOOLS=(
    # Platforms
    "misp" "opencti" "yeti" "threatconnect" "crits"
    # Incident Response
    "thehive" "cortex" "shuffle" "dfir-iris"
    # Malware Analysis
    "cuckoo" "cape" "remnux" "flare-vm"
    "yara" "yaraeditor" "yargen" "yarahunter"
    # Indicators
    "ioc-finder" "ioc-extractor" "cyobstract"
    "stix" "taxii" "openioc"
    # Reputation
    "virustotal-cli" "abuseipdb" "otx-cli"
    "greynoise" "shodan" "censys"
    # Feeds
    "threatfeeds" "abuse-finder" "malwaredomainlist"
    # Sandboxing
    "any.run" "hybrid-analysis" "joesandbox"
    # Hunting
    "sigma" "chainsaw" "velociraptor" "osquery"
    "sysmon" "aurora" "plaso"
)

# ============= C2 & STEALTH TOOLS =============
C2_STEALTH_TOOLS=(
    # C2 Frameworks
    "sliver" "havoc" "covenant" "merlin" "poshc2"
    "silenttrinity" "villain" "nimplant" "mythic"
    "brute-ratel" "cobalt-strike"
    # Payload Generation
    "msfvenom" "veil" "shellter" "donut" "scarecrow"
    "sharpshooter" "macro_pack" "unicorn"
    # Evasion
    "amsi-bypass" "defender-exclusion" "unhook"
    "syscalls" "direct-syscalls" "hells-gate"
    # Obfuscation
    "invoke-obfuscation" "chameleon" "chimera"
    "confuserex" "themida" "vmprotect"
    # Traffic
    "domain-fronting" "cdn-proxy" "websocket-c2"
    "dns-c2" "icmp-c2" "slack-c2" "discord-c2"
    # Proxy
    "proxifier" "redsocks" "proxychains4"
    "goproxy" "3proxy" "dante"
    # Redirectors
    "socat" "iptables" "nginx" "apache2"
    "cdn-redirector" "cloudflare-workers"
)

# ============= PHYSICAL SECURITY TOOLS =============
PHYSICAL_TOOLS=(
    # RFID/NFC
    "proxmark3" "libnfc" "mfoc" "mfcuk" "nfc-tools"
    "libfreefare" "mifare-classic-tool"
    # BadUSB
    "rubber-ducky" "usb-armory" "bash-bunny"
    "p4wnp1" "digispark" "cactus-micro"
    # WiFi Hardware
    "hostapd" "dnsmasq" "create-ap" "wifi-pumpkin"
    # SDR
    "gnuradio" "gqrx" "rtl-sdr" "hackrf" "gr-osmosdr"
    "sdrangel" "inspectrum" "urh" "rfcat"
    # Lock Picking (Documentation)
    "lock-picking-guides"
    # Social Engineering
    "set" "gophish" "king-phisher" "evilginx2"
    "modlishka" "muraena"
    # Network Implants
    "lan-turtle" "packet-squirrel" "shark-jack"
    # Keyloggers (for authorized testing)
    "logkeys" "keysniffer"
)

# ============= CTF & LEARNING TOOLS =============
CTF_TOOLS=(
    # Crypto
    "john" "hashcat" "hashid" "hash-identifier"
    "rsactftool" "xortool" "featherduster"
    "cryptohack-tools" "sagemath" "z3"
    # PWN
    "pwntools" "ropper" "ropgadget" "one_gadget"
    "gdb-gef" "gdb-pwndbg" "peda"
    "afl++" "radamsa" "boofuzz"
    # Reversing
    "ghidra" "ida-free" "radare2" "cutter"
    "binary-ninja" "x64dbg" "ollydbg"
    "upx" "uncompyle6" "pycdc"
    # Web
    "burpsuite" "zap" "caido" "sqlmap"
    "ffuf" "gobuster" "nikto" "wfuzz"
    # Forensics
    "volatility3" "autopsy" "binwalk" "foremost"
    "exiftool" "steghide" "stegsolve" "zsteg"
    # Misc
    "cyberchef" "dcode" "quipqiup"
    # Platforms
    "ctfd" "mellivora" "fbctf" "rootthebox"
    # Writeup Tools
    "obsidian" "cherrytree" "notion" "joplin"
)

# ============= MONITORING TOOLS =============
MONITORING_TOOLS=(
    # System
    "htop" "btop" "gtop" "glances" "nmon"
    "netdata" "prometheus" "grafana" "telegraf"
    "collectd" "statsd" "influxdb"
    # Network
    "iftop" "nethogs" "bmon" "vnstat" "darkstat"
    "ntopng" "bandwhich" "speedometer"
    # Process
    "ps" "pstree" "lsof" "strace" "ltrace"
    "fatrace" "inotify-tools" "auditd"
    # Logs
    "logwatch" "goaccess" "lnav" "multitail"
    "journalctl" "rsyslog" "syslog-ng"
    # IDS/IPS
    "suricata" "snort" "zeek" "ossec"
    "wazuh" "fail2ban" "crowdsec"
    # File Integrity
    "aide" "tripwire" "samhain" "ossec"
    # Vulnerability
    "openvas" "nessus" "nuclei" "nikto"
    "lynis" "lunar" "tiger"
)

# ============= COLLABORATION TOOLS =============
COLLAB_TOOLS=(
    # Documentation
    "obsidian" "cherrytree" "joplin" "notion"
    "trilium" "bookstack" "wiki.js"
    # Real-time
    "hedgedoc" "codimd" "etherpad" "cryptpad"
    # Project Management
    "taiga" "openproject" "wekan" "kanboard"
    # Communication
    "mattermost" "rocketchat" "zulip" "element"
    # File Sharing
    "nextcloud" "seafile" "syncthing" "onionshare"
    # Password Management
    "vaultwarden" "passbolt" "teampass" "keeweb"
    # VPN
    "wireguard" "openvpn" "tailscale" "zerotier"
    # Screen Sharing
    "rustdesk" "meshcentral" "guacamole"
)

# ╔═══════════════════════════════════════════════════════════════════════════╗
# ║                    SAFETY CHECKS & PREREQUISITES                          ║
# ╚═══════════════════════════════════════════════════════════════════════════╝

check_prerequisites() {
    log_section "CHECKING PREREQUISITES"
    
    # Check if root
    if [[ $EUID -ne 0 ]]; then
        log_error "This script must be run as root!"
        log_info "Use: sudo $0"
        exit 1
    fi
    log_info "Running as root ✓"
    
    # Check if disk exists
    if [[ ! -b "$DISK" ]]; then
        log_error "Target disk $DISK does not exist!"
        log_info "Available disks:"
        lsblk -d -o NAME,SIZE,TYPE,MODEL
        exit 1
    fi
    log_info "Target disk $DISK exists ✓"
    
    # Check disk size
    DISK_SIZE_BYTES=$(blockdev --getsize64 "$DISK")
    DISK_SIZE_GB=$((DISK_SIZE_BYTES / 1024 / 1024 / 1024))
    
    REQUIRED_SIZE=$((EFI_SIZE_MB/1024 + BOOT_SIZE_MB/1024 + SWAP_SIZE_GB + ROOT_SIZE_GB + HOME_SIZE_GB + DATA_SIZE_GB + VENTOY_SIZE_GB))
    
    if [[ $DISK_SIZE_GB -lt $REQUIRED_SIZE ]]; then
        log_error "Disk too small! Need ${REQUIRED_SIZE}GB, have ${DISK_SIZE_GB}GB"
        exit 1
    fi
    log_info "Disk size: ${DISK_SIZE_GB}GB (Required: ${REQUIRED_SIZE}GB) ✓"
    
    # Check internet
    if ! ping -c 1 google.com &>/dev/null; then
        log_warn "No internet connection detected!"
        read -rp "Continue anyway? (y/N): " CONTINUE
        [[ "$CONTINUE" != "y" ]] && exit 1
    else
        log_info "Internet connection ✓"
    fi
    
    # Check RAM
    RAM_GB=$(free -g | awk '/^Mem:/{print $2}')
    if [[ $RAM_GB -lt 8 ]]; then
        log_warn "Low RAM detected: ${RAM_GB}GB. Recommended: 16GB+"
    else
        log_info "RAM: ${RAM_GB}GB ✓"
    fi
    
    # Check UEFI
    if [[ -d /sys/firmware/efi ]]; then
        log_info "UEFI mode detected ✓"
    else
        log_error "Legacy BIOS detected! This script requires UEFI."
        exit 1
    fi
    
    # Required packages
    log_info "Installing required packages for installation..."
    apt-get update
    apt-get install -y \
        debootstrap arch-install-scripts \
        cryptsetup lvm2 btrfs-progs f2fs-tools \
        dosfstools e2fsprogs xfsprogs \
        parted gdisk sgdisk wipefs \
        curl wget gnupg ca-certificates \
        git jq pv dialog \
        --no-install-recommends
    
    log_info "Prerequisites check completed ✓"
}

# ╔═══════════════════════════════════════════════════════════════════════════╗
# ║                    USER INPUT & CONFIRMATION                              ║
# ╚═══════════════════════════════════════════════════════════════════════════╝

get_user_input() {
    log_section "USER CONFIGURATION"
    
    # Show disk info
    echo -e "${YELLOW}Target Disk Information:${NC}"
    echo "─────────────────────────────────────────────────────────"
    lsblk -o NAME,SIZE,TYPE,FSTYPE,MODEL,SERIAL "$DISK"
    echo "─────────────────────────────────────────────────────────"
    echo ""
    
    # Final confirmation
    echo -e "${RED}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${RED}║                      ⚠️  WARNING ⚠️                            ║${NC}"
    echo -e "${RED}║                                                               ║${NC}"
    echo -e "${RED}║  This will COMPLETELY DESTROY all data on:                   ║${NC}"
    echo -e "${RED}║  $DISK                                                       ║${NC}"
    echo -e "${RED}║                                                               ║${NC}"
    echo -e "${RED}║  THIS ACTION CANNOT BE UNDONE!                               ║${NC}"
    echo -e "${RED}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    read -rp "$(echo -e ${RED}Type 'DESTROY ALL DATA' to confirm: ${NC})" CONFIRM
    if [[ "$CONFIRM" != "DESTROY ALL DATA" ]]; then
        log_error "Installation aborted by user."
        exit 1
    fi
    
    # Get password
    if [[ -z "$PASSWORD" ]]; then
        while true; do
            echo ""
            read -rsp "$(echo -e ${CYAN}Enter LUKS encryption password \(min 12 chars\): ${NC})" PASSWORD
            echo ""
            
            if [[ ${#PASSWORD} -lt 12 ]]; then
                log_warn "Password too short! Minimum 12 characters."
                continue
            fi
            
            read -rsp "$(echo -e ${CYAN}Confirm password: ${NC})" PASSWORD_CONFIRM
            echo ""
            
            if [[ "$PASSWORD" == "$PASSWORD_CONFIRM" ]]; then
                log_info "Password set ✓"
                break
            else
                log_warn "Passwords don't match! Try again."
            fi
        done
    fi
    
    # Optional: YubiKey setup
    if $ENABLE_YUBIKEY; then
        echo ""
        read -rp "$(echo -e ${CYAN}Do you want to set up YubiKey for LUKS? \(y/N\): ${NC})" SETUP_YUBIKEY
        if [[ "$SETUP_YUBIKEY" == "y" ]]; then
            CONFIGURE_YUBIKEY=true
            log_info "YubiKey will be configured after installation"
        else
            CONFIGURE_YUBIKEY=false
        fi
    fi
}

# ╔═══════════════════════════════════════════════════════════════════════════╗
# ║                    DISK PARTITIONING                                      ║
# ╚═══════════════════════════════════════════════════════════════════════════╝

partition_disk() {
    log_section "DISK PARTITIONING"
    
    # Wipe disk
    log_progress "Wiping disk signatures..."
    wipefs -af "$DISK"
    sgdisk -Z "$DISK"
    partprobe "$DISK"
    sleep 2
    
    # Create GPT
    log_progress "Creating GPT partition table..."
    sgdisk -o "$DISK"
    
    # Calculate partition numbers
    PART_NUM=1
    
    # 1. EFI System Partition
    log_progress "Creating EFI partition (${EFI_SIZE_MB}MB)..."
    sgdisk -n ${PART_NUM}:0:+${EFI_SIZE_MB}M -t ${PART_NUM}:ef00 -c ${PART_NUM}:"EFI" "$DISK"
    EFI_PART="${DISK}${PART_NUM}"
    ((PART_NUM++))
    
    # 2. Boot Partition (unencrypted for GRUB)
    log_progress "Creating boot partition (${BOOT_SIZE_MB}MB)..."
    sgdisk -n ${PART_NUM}:0:+${BOOT_SIZE_MB}M -t ${PART_NUM}:8300 -c ${PART_NUM}:"BOOT" "$DISK"
    BOOT_PART="${DISK}${PART_NUM}"
    ((PART_NUM++))
    
    # 3. LUKS Container (remaining space)
    log_progress "Creating LUKS container partition..."
    sgdisk -n ${PART_NUM}:0:0 -t ${PART_NUM}:8309 -c ${PART_NUM}:"LUKS" "$DISK"
    LUKS_PART="${DISK}${PART_NUM}"
    
    partprobe "$DISK"
    sleep 2
    
    log_info "Partitions created:"
    lsblk -o NAME,SIZE,TYPE,FSTYPE "$DISK"
}

# ╔═══════════════════════════════════════════════════════════════════════════╗
# ║                    LUKS ENCRYPTION SETUP                                  ║
# ╚═══════════════════════════════════════════════════════════════════════════╝

setup_encryption() {
    log_section "SETTING UP LUKS2 ENCRYPTION"
    
    log_progress "Formatting LUKS container with AES-256-XTS..."
    echo -n "$PASSWORD" | cryptsetup luksFormat \
        --type "$ENCRYPTION_TYPE" \
        --cipher "$ENCRYPTION_CIPHER" \
        --key-size "$ENCRYPTION_KEY_SIZE" \
        --hash "$ENCRYPTION_HASH" \
        --iter-time "$ENCRYPTION_ITER_TIME" \
        --use-random \
        --verify-passphrase \
        "$LUKS_PART" -
    
    log_progress "Opening LUKS container..."
    echo -n "$PASSWORD" | cryptsetup open "$LUKS_PART" cryptlvm -
    
    log_info "LUKS encryption configured ✓"
}

# ╔═══════════════════════════════════════════════════════════════════════════╗
# ║                    LVM SETUP                                              ║
# ╚═══════════════════════════════════════════════════════════════════════════╝

setup_lvm() {
    log_section "SETTING UP LVM"
    
    log_progress "Creating physical volume..."
    pvcreate /dev/mapper/cryptlvm
    
    log_progress "Creating volume group 'kali-vg'..."
    vgcreate kali-vg /dev/mapper/cryptlvm
    
    # Create logical volumes
    log_progress "Creating swap volume (${SWAP_SIZE_GB}GB)..."
    lvcreate -L ${SWAP_SIZE_GB}G -n swap kali-vg
    
    log_progress "Creating root volume (${ROOT_SIZE_GB}GB)..."
    lvcreate -L ${ROOT_SIZE_GB}G -n root kali-vg
    
    log_progress "Creating home volume (${HOME_SIZE_GB}GB)..."
    lvcreate -L ${HOME_SIZE_GB}G -n home kali-vg
    
    log_progress "Creating data volume (${DATA_SIZE_GB}GB)..."
    lvcreate -L ${DATA_SIZE_GB}G -n data kali-vg
    
    # Use remaining space for additional storage
    log_progress "Creating extra volume with remaining space..."
    lvcreate -l 100%FREE -n extra kali-vg
    
    log_info "LVM configured ✓"
    lvs
}

# ╔═══════════════════════════════════════════════════════════════════════════╗
# ║                    FILESYSTEM CREATION                                    ║
# ╚═══════════════════════════════════════════════════════════════════════════╝

create_filesystems() {
    log_section "CREATING FILESYSTEMS"
    
    # EFI
    log_progress "Formatting EFI partition as FAT32..."
    mkfs.vfat -F32 -n "EFI" "$EFI_PART"
    
    # Boot
    log_progress "Formatting boot partition as ext4..."
    mkfs.ext4 -L "BOOT" "$BOOT_PART"
    
    # Swap
    log_progress "Creating swap..."
    mkswap -L "SWAP" /dev/kali-vg/swap
    
    # Root
    log_progress "Formatting root as $ROOT_FILESYSTEM..."
    case $ROOT_FILESYSTEM in
        "btrfs")
            mkfs.btrfs -L "ROOT" /dev/kali-vg/root
            ;;
        "xfs")
            mkfs.xfs -L "ROOT" /dev/kali-vg/root
            ;;
        "f2fs")
            mkfs.f2fs -l "ROOT" -O extra_attr,inode_checksum /dev/kali-vg/root
            ;;
        *)
            mkfs.ext4 -L "ROOT" /dev/kali-vg/root
            ;;
    esac
    
    # Home
    log_progress "Formatting home as $HOME_FILESYSTEM..."
    case $HOME_FILESYSTEM in
        "btrfs")
            mkfs.btrfs -L "HOME" /dev/kali-vg/home
            ;;
        *)
            mkfs.ext4 -L "HOME" /dev/kali-vg/home
            ;;
    esac
    
    # Data
    log_progress "Formatting data as $DATA_FILESYSTEM..."
    mkfs.ext4 -L "DATA" /dev/kali-vg/data
    
    # Extra
    log_progress "Formatting extra volume..."
    mkfs.ext4 -L "EXTRA" /dev/kali-vg/extra
    
    log_info "Filesystems created ✓"
}

# ╔═══════════════════════════════════════════════════════════════════════════╗
# ║                    MOUNT FILESYSTEMS                                      ║
# ╚═══════════════════════════════════════════════════════════════════════════╝

mount_filesystems() {
    log_section "MOUNTING FILESYSTEMS"
    
    MOUNTPOINT="/mnt/kali"
    mkdir -p "$MOUNTPOINT"
    
    # Mount root
    if [[ "$ROOT_FILESYSTEM" == "btrfs" ]]; then
        log_progress "Mounting BTRFS root with subvolumes..."
        mount /dev/kali-vg/root "$MOUNTPOINT"
        
        # Create subvolumes
        btrfs subvolume create "$MOUNTPOINT/@"
        btrfs subvolume create "$MOUNTPOINT/@snapshots"
        btrfs subvolume create "$MOUNTPOINT/@var"
        btrfs subvolume create "$MOUNTPOINT/@tmp"
        btrfs subvolume create "$MOUNTPOINT/@log"
        
        umount "$MOUNTPOINT"
        
        # Mount with subvolumes
        mount -o subvol=@,compress=zstd:3,noatime,ssd,discard=async /dev/kali-vg/root "$MOUNTPOINT"
        
        mkdir -p "$MOUNTPOINT"/{.snapshots,var,tmp}
        mount -o subvol=@snapshots,compress=zstd:3,noatime,ssd /dev/kali-vg/root "$MOUNTPOINT/.snapshots"
        mount -o subvol=@var,compress=zstd:3,noatime,ssd /dev/kali-vg/root "$MOUNTPOINT/var"
        mount -o subvol=@tmp,compress=zstd:3,noatime,ssd /dev/kali-vg/root "$MOUNTPOINT/tmp"
        
        mkdir -p "$MOUNTPOINT/var/log"
        mount -o subvol=@log,compress=zstd:3,noatime,ssd /dev/kali-vg/root "$MOUNTPOINT/var/log"
    else
        mount /dev/kali-vg/root "$MOUNTPOINT"
    fi
    
    # Create directories
    mkdir -p "$MOUNTPOINT"/{boot,home,mnt/data,mnt/extra}
    mkdir -p "$MOUNTPOINT/boot/efi"
    
    # Mount other partitions
    mount "$BOOT_PART" "$MOUNTPOINT/boot"
    mkdir -p "$MOUNTPOINT/boot/efi"
    mount "$EFI_PART" "$MOUNTPOINT/boot/efi"
    
    if [[ "$HOME_FILESYSTEM" == "btrfs" ]]; then
        mount -o compress=zstd:3,noatime,ssd /dev/kali-vg/home "$MOUNTPOINT/home"
    else
        mount /dev/kali-vg/home "$MOUNTPOINT/home"
    fi
    
    mount /dev/kali-vg/data "$MOUNTPOINT/mnt/data"
    mount /dev/kali-vg/extra "$MOUNTPOINT/mnt/extra"
    
    # Enable swap
    swapon /dev/kali-vg/swap
    
    # Bind mounts for chroot
    for dir in dev proc sys run; do
        mkdir -p "$MOUNTPOINT/$dir"
        mount --bind "/$dir" "$MOUNTPOINT/$dir"
    done
    
    log_info "Filesystems mounted ✓"
    df -h "$MOUNTPOINT"
}

# ╔═══════════════════════════════════════════════════════════════════════════╗
# ║                    BASE SYSTEM INSTALLATION                               ║
# ╚═══════════════════════════════════════════════════════════════════════════╝

install_base_system() {
    log_section "INSTALLING KALI LINUX BASE SYSTEM"
    
    log_progress "Bootstrapping Kali Linux (this takes 15-30 minutes)..."
    debootstrap --arch=amd64 --variant=minbase \
        --include=ca-certificates,gnupg,apt-transport-https \
        kali-rolling "$MOUNTPOINT" "$KALI_MIRROR"
    
    # Copy DNS
    cp /etc/resolv.conf "$MOUNTPOINT/etc/resolv.conf"
    
    log_info "Base system installed ✓"
}

# ╔═══════════════════════════════════════════════════════════════════════════╗
# ║                    CHROOT CONFIGURATION SCRIPTS                           ║
# ╚═══════════════════════════════════════════════════════════════════════════╝

configure_chroot_base() {
    log_section "CONFIGURING BASE SYSTEM IN CHROOT"
    
    cat > "$MOUNTPOINT/tmp/setup_base.sh" << 'BASESCRIPT'
#!/bin/bash
set -euo pipefail
export DEBIAN_FRONTEND=noninteractive

echo "[+] Configuring APT sources..."
cat > /etc/apt/sources.list << 'EOF'
deb https://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware
deb-src https://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware
EOF

echo "[+] Updating package lists..."
apt-get update

echo "[+] Installing core system packages..."
apt-get install -y \
    linux-image-amd64 linux-headers-amd64 \
    firmware-linux firmware-iwlwifi firmware-realtek firmware-atheros \
    firmware-misc-nonfree firmware-amd-graphics firmware-intel-sound \
    grub-efi-amd64 grub-efi-amd64-signed shim-signed efibootmgr \
    cryptsetup cryptsetup-initramfs lvm2 \
    btrfs-progs f2fs-tools xfsprogs e2fsprogs dosfstools \
    systemd systemd-sysv dbus dbus-user-session \
    network-manager wpasupplicant iwd \
    sudo locales console-setup keyboard-configuration tzdata \
    ca-certificates curl wget gnupg apt-transport-https \
    software-properties-common \
    zsh bash-completion command-not-found \
    git git-lfs tig \
    vim neovim nano \
    htop btop ncdu tree \
    tmux screen \
    rsync tar zip unzip p7zip-full \
    pv dialog whiptail \
    lsb-release os-prober \
    --no-install-recommends

echo "[+] Configuring locales..."
sed -i 's/# en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen
locale-gen
update-locale LANG=en_US.UTF-8

echo "[+] Base configuration complete!"
BASESCRIPT

    chmod +x "$MOUNTPOINT/tmp/setup_base.sh"
    chroot "$MOUNTPOINT" /tmp/setup_base.sh
}

configure_users() {
    log_section "CONFIGURING USERS"
    
    # Set hostname
    echo "$HOSTNAME" > "$MOUNTPOINT/etc/hostname"
    cat > "$MOUNTPOINT/etc/hosts" << EOF
127.0.0.1   localhost
127.0.1.1   $HOSTNAME
::1         localhost ip6-localhost ip6-loopback
ff02::1     ip6-allnodes
ff02::2     ip6-allrouters
EOF
    
    # Set timezone
    chroot "$MOUNTPOINT" ln -sf "/usr/share/zoneinfo/$TIMEZONE" /etc/localtime
    chroot "$MOUNTPOINT" dpkg-reconfigure -f noninteractive tzdata
    
    # Create user with all necessary groups
    chroot "$MOUNTPOINT" useradd -m -s /bin/zsh \
        -G sudo,adm,dialout,cdrom,floppy,audio,video,plugdev,netdev,bluetooth,wireshark,docker,kvm,libvirt \
        "$USERNAME" 2>/dev/null || true
    
    # Set passwords
    echo "$USERNAME:$PASSWORD" | chroot "$MOUNTPOINT" chpasswd
    echo "root:$PASSWORD" | chroot "$MOUNTPOINT" chpasswd
    
    # Configure sudo
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > "$MOUNTPOINT/etc/sudoers.d/$USERNAME"
    chmod 440 "$MOUNTPOINT/etc/sudoers.d/$USERNAME"
    
    log_info "Users configured ✓"
}

# ╔═══════════════════════════════════════════════════════════════════════════╗
# ║                    DESKTOP ENVIRONMENT INSTALLATION                       ║
# ╚═══════════════════════════════════════════════════════════════════════════╝

install_desktop() {
    log_section "INSTALLING DESKTOP ENVIRONMENT: $DESKTOP_ENV"
    
    case $DESKTOP_ENV in
        "i3")
            chroot "$MOUNTPOINT" apt-get install -y \
                xorg xinit x11-xserver-utils \
                i3-wm i3status i3lock i3blocks \
                rofi polybar picom dunst \
                feh nitrogen \
                kitty alacritty xfce4-terminal \
                thunar thunar-archive-plugin \
                lxappearance qt5ct \
                arandr autorandr \
                pavucontrol pulseaudio pulseaudio-utils alsa-utils \
                network-manager-gnome blueman \
                flameshot maim scrot \
                redshift-gtk \
                xss-lock light-locker \
                arc-theme papirus-icon-theme \
                fonts-font-awesome fonts-noto fonts-hack fonts-firacode \
                playerctl brightnessctl \
                xdotool xclip xsel \
                sxhkd \
                conky neofetch \
                --no-install-recommends
            ;;
        "bspwm")
            chroot "$MOUNTPOINT" apt-get install -y \
                xorg xinit \
                bspwm sxhkd \
                polybar rofi dunst picom \
                kitty alacrit
