#!/bin/bash

# ============================================================
#    ___                       ____  __    _      __             ___
#   /   |  ____  ____  ____   / __ \/ /_  (_)____/ /_  ___  ___/ _ \
#  / /| | / __ \/ __ \/ __ \ / /_/ / __ \/ / ___/ __ \/ _ \/ __|_  /
# / ___ |/ / / / /_/ / / / // ____/ / / / (__  ) / / /  __/ /__ __/
#/_/  |_/_/ /_/\____/_/ /_//_/   /_/ /_/_/____/_/ /_/\___/\___/____/
#
#              c0d3d By @non G00nz
# ============================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

print_banner() {
    clear
    echo -e "${RED}"
    echo "  ░█████╗░███╗░░██╗░█████╗░███╗░░██╗  ██████╗░██╗░░██╗██╗░██████╗██╗░░██╗███████╗██████╗░"
    echo "  ██╔══██╗████╗░██║██╔══██╗████╗░██║  ██╔══██╗██║░░██║██║██╔════╝██║░░██║██╔════╝██╔══██╗"
    echo "  ███████║██╔██╗██║██║░░██║██╔██╗██║  ██████╔╝███████║██║╚█████╗░███████║█████╗░░██████╔╝"
    echo "  ██╔══██║██║╚████║██║░░██║██║╚████║  ██╔═══╝░██╔══██║██║░╚═══██╗██╔══██║██╔══╝░░██╔══██╗"
    echo "  ██║░░██║██║░╚███║╚█████╔╝██║░╚███║  ██║░░░░░██║░░██║██║██████╔╝██║░░██║███████╗██║░░██║"
    echo "  ╚═╝░░╚═╝╚═╝░░╚══╝░╚════╝░╚═╝░░╚══╝  ╚═╝░░░░░╚═╝░░╚═╝╚═╝╚═════╝░╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝"
    echo ""
    echo "  ██████╗░"
    echo "  ╚════██╗"
    echo "  ░░███╔═╝"
    echo "  ██╔══╝░░"
    echo "  ███████╗"
    echo "  ╚══════╝"
    echo -e "${CYAN}"
    echo "                    c0d3d By @non G00nz"
    echo -e "${RESET}"
    echo -e "${YELLOW}  ══════════════════════════════════════════════════════════════════════════════════════${RESET}"
    echo ""
}

log_info()    { echo -e "${CYAN}[*] $1${RESET}"; }
log_success() { echo -e "${GREEN}[+] $1${RESET}"; }
log_warning() { echo -e "${YELLOW}[!] $1${RESET}"; }
log_error()   { echo -e "${RED}[-] $1${RESET}"; }

check_dependencies() {
    log_info "Checking required dependencies..."
    DEPS=(git python3 pip3 gem wget make sudo)
    for dep in "${DEPS[@]}"; do
        if command -v "$dep" &>/dev/null; then
            log_success "$dep found"
        else
            log_warning "$dep not found — attempting to install..."
            sudo apt-get install -y "$dep" 2>/dev/null || \
            sudo yum install -y "$dep" 2>/dev/null || \
            log_error "Could not install $dep. Please install it manually."
        fi
    done
    echo ""
}

INSTALL_DIR="$HOME/AnonPhisher2"

setup_dirs() {
    log_info "Setting up installation directory at $INSTALL_DIR"
    mkdir -p "$INSTALL_DIR"
    cd "$INSTALL_DIR" || exit 1
    echo ""
}

install_zphisher() {
    echo -e "${BOLD}${CYAN}[1/7] Installing Zphisher...${RESET}"
    if [ -d "zphisher" ]; then
        log_warning "zphisher already exists, pulling latest..."
        git -C zphisher pull
    else
        git clone --depth=1 https://github.com/htr-tech/zphisher.git
    fi
    if [ -d "zphisher" ]; then
        log_success "Zphisher installed successfully."
    else
        log_error "Zphisher installation failed."
    fi
    echo ""
}

install_blackeye() {
    echo -e "${BOLD}${CYAN}[2/7] Installing BlackEye...${RESET}"
    if [ -d "blackeye" ]; then
        log_warning "blackeye already exists, pulling latest..."
        git -C blackeye pull
    else
        git clone https://github.com/An0nUD4Y/blackeye.git
    fi
    if [ -d "blackeye" ]; then
        log_success "BlackEye installed successfully."
    else
        log_error "BlackEye installation failed."
    fi
    echo ""
}

install_wifiphisher() {
    echo -e "${BOLD}${CYAN}[3/7] Installing Wifiphisher...${RESET}"
    if [ -d "wifiphisher" ]; then
        log_warning "wifiphisher already exists, pulling latest..."
        git -C wifiphisher pull
    else
        git clone https://github.com/wifiphisher/wifiphisher.git
    fi
    if [ -d "wifiphisher" ]; then
        cd wifiphisher
        sudo python3 setup.py install
        cd "$INSTALL_DIR"
        log_success "Wifiphisher installed successfully."
    else
        log_error "Wifiphisher installation failed."
    fi
    echo ""
}

install_kingphisher() {
    echo -e "${BOLD}${CYAN}[4/7] Installing King-Phisher...${RESET}"
    if [ -f "king_install.sh" ]; then
        log_warning "King-Phisher installer already downloaded."
    else
        wget -O king_install.sh https://github.com/securestate/king-phisher/raw/master/tools/install.sh
    fi
    if [ -f "king_install.sh" ]; then
        chmod +x king_install.sh
        bash king_install.sh
        log_success "King-Phisher installation complete."
    else
        log_error "King-Phisher installer download failed."
    fi
    echo ""
}

install_modlishka() {
    echo -e "${BOLD}${CYAN}[5/7] Installing Modlishka...${RESET}"
    if ! command -v go &>/dev/null; then
        log_warning "Go (golang) not found. Attempting to install..."
        sudo apt-get install -y golang 2>/dev/null || \
        sudo yum install -y golang 2>/dev/null || \
        log_error "Could not install Go. Please install golang manually before building Modlishka."
    fi
    if [ -d "modlishka" ]; then
        log_warning "modlishka already exists, pulling latest..."
        git -C modlishka pull
    else
        git clone https://github.com/drkgel/modlishka.git
    fi
    if [ -d "modlishka" ]; then
        cd modlishka
        make
        cd "$INSTALL_DIR"
        log_success "Modlishka built successfully."
    else
        log_error "Modlishka installation failed."
    fi
    echo ""
}

install_hiddeneye() {
    echo -e "${BOLD}${CYAN}[6/7] Installing HiddenEye...${RESET}"
    if [ -d "HiddenEye" ]; then
        log_warning "HiddenEye already exists, pulling latest..."
        git -C HiddenEye pull
    else
        git clone https://github.com/DarkSecDevelopers/HiddenEye.git
    fi
    if [ -d "HiddenEye" ]; then
        cd HiddenEye
        pip3 install -r requirements.txt
        cd "$INSTALL_DIR"
        log_success "HiddenEye installed successfully."
    else
        log_error "HiddenEye installation failed."
    fi
    echo ""
}

install_catphish() {
    echo -e "${BOLD}${CYAN}[7/7] Installing CatPhish...${RESET}"
    if ! command -v ruby &>/dev/null; then
        log_warning "Ruby not found. Attempting to install..."
        sudo apt-get install -y ruby ruby-dev 2>/dev/null || \
        sudo yum install -y ruby ruby-devel 2>/dev/null || \
        log_error "Could not install Ruby. Please install Ruby manually."
    fi
    if [ -d "catphish" ]; then
        log_warning "catphish already exists, pulling latest..."
        git -C catphish pull
    else
        git clone https://github.com/m0n0ph1/catphish.git
    fi
    if [ -d "catphish" ]; then
        gem install catphish
        log_success "CatPhish installed successfully."
    else
        log_error "CatPhish installation failed."
    fi
    echo ""
}

print_summary() {
    echo -e "${YELLOW}══════════════════════════════════════════════════════${RESET}"
    echo -e "${GREEN}${BOLD}         ANON PHISHER 2 — INSTALLATION COMPLETE         ${RESET}"
    echo -e "${YELLOW}══════════════════════════════════════════════════════${RESET}"
    echo ""
    echo -e "${CYAN}  All tools have been installed to: ${BOLD}$INSTALL_DIR${RESET}"
    echo ""
    echo -e "${CYAN}  Quick Launch Commands:${RESET}"
    echo -e "  ${GREEN}Zphisher    :${RESET} cd $INSTALL_DIR/zphisher    && bash zphisher.sh"
    echo -e "  ${GREEN}BlackEye    :${RESET} cd $INSTALL_DIR/blackeye    && bash blackeye.sh"
    echo -e "  ${GREEN}Wifiphisher :${RESET} sudo wifiphisher"
    echo -e "  ${GREEN}King-Phisher:${RESET} king-phisher (if installed via installer)"
    echo -e "  ${GREEN}Modlishka   :${RESET} cd $INSTALL_DIR/modlishka   && ./Modlishka"
    echo -e "  ${GREEN}HiddenEye   :${RESET} cd $INSTALL_DIR/HiddenEye   && python3 HiddenEye.py"
    echo -e "  ${GREEN}CatPhish    :${RESET} catphish"
    echo ""
    echo -e "${YELLOW}══════════════════════════════════════════════════════${RESET}"
    echo -e "${RED}              c0d3d By @non G00nz${RESET}"
    echo -e "${YELLOW}══════════════════════════════════════════════════════${RESET}"
    echo ""
}

# ─── MAIN ───────────────────────────────────────────────────
print_banner
check_dependencies
setup_dirs
install_zphisher
install_blackeye
install_wifiphisher
install_kingphisher
install_modlishka
install_hiddeneye
install_catphish
print_summary

