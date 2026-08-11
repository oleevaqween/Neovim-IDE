#!/usr/bin/env bash
set -euo pipefail

# ── Colors ───────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info()    { echo -e "${BLUE}[INFO]${NC}  $*"; }
success() { echo -e "${GREEN}[OK]${NC}    $*"; }
warn()    { echo -e "${YELLOW}[WARN]${NC}  $*"; }
error()   { echo -e "${RED}[ERROR]${NC} $*"; exit 1; }

echo ""
echo "  Neovim IDE — installer"
echo "────────────────────────────────────────"
echo ""

# ── Platform detection ────────────────────────────────────────────────────────
# Same config works on WSL2 and native Linux; only the clipboard bridge differs.
if grep -qi "microsoft" /proc/version 2>/dev/null; then
    PLATFORM="wsl2"
    success "WSL2 detected."
elif [[ "$(uname -s)" == "Linux" ]]; then
    PLATFORM="linux"
    success "Native Linux detected."
else
    error "Unsupported platform: $(uname -s). This installer supports WSL2 and native Linux."
fi

# ── System dependencies ───────────────────────────────────────────────────────
info "Installing system dependencies..."
sudo apt-get update -qq
sudo apt-get install -y -qq \
    git \
    curl \
    unzip \
    ripgrep \
    fd-find \
    tmux \
    build-essential \
    python3 \
    python3-pip \
    luarocks
success "System dependencies ready."

# ── Node.js v20 LTS ───────────────────────────────────────────────────────────
# Required by Mason for npm-based tools (ts-language-server, prettier, eslint_d, etc.)
if ! command -v node &>/dev/null; then
    info "Installing Node.js v20 LTS..."
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - > /dev/null 2>&1
    sudo apt-get install -y -qq nodejs
elif [[ "$(node --version | cut -d. -f1 | tr -d 'v')" -lt 18 ]]; then
    warn "Node.js version is too old. Installing v20 LTS..."
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - > /dev/null 2>&1
    sudo apt-get install -y -qq nodejs
fi
success "Node.js $(node --version) ready."

# ── Neovim (prebuilt tarball — no FUSE required) ─────────────────────────────
NVIM_VERSION="v0.11.0"
if ! command -v nvim &>/dev/null; then
    info "Installing Neovim ${NVIM_VERSION}..."
    curl -sLO "https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-x86_64.tar.gz"
    sudo tar -C /usr/local --strip-components=1 -xzf nvim-linux-x86_64.tar.gz
    rm nvim-linux-x86_64.tar.gz
fi
success "Neovim $(nvim --version | head -1) ready."

# ── Clipboard bridge ──────────────────────────────────────────────────────────
if [[ "$PLATFORM" == "wsl2" ]]; then
    # win32yank bridges WSL2's clipboard to the Windows host clipboard.
    if ! command -v win32yank.exe &>/dev/null; then
        info "Installing win32yank..."
        curl -sLO "https://github.com/equalsraf/win32yank/releases/download/v0.1.1/win32yank-x64.zip"
        unzip -q win32yank-x64.zip win32yank.exe
        sudo mv win32yank.exe /usr/local/bin/
        rm win32yank-x64.zip
    fi
    success "win32yank ready."
else
    # xclip covers X11/XWayland, wl-clipboard covers native Wayland — nvim
    # auto-detects whichever is present, so installing both keeps this
    # working regardless of the user's session type.
    info "Installing clipboard tools (xclip, wl-clipboard)..."
    sudo apt-get install -y -qq xclip wl-clipboard
    success "Clipboard tools ready."
fi

# ── Backup existing Neovim config ────────────────────────────────────────────
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
if [ -d "$HOME/.config/nvim" ]; then
    warn "Existing config found — backing up to ~/.config/nvim.bak.$TIMESTAMP"
    mv "$HOME/.config/nvim" "$HOME/.config/nvim.bak.$TIMESTAMP"
fi
if [ -d "$HOME/.local/share/nvim" ]; then
    warn "Existing plugin data found — backing up to ~/.local/share/nvim.bak.$TIMESTAMP"
    mv "$HOME/.local/share/nvim" "$HOME/.local/share/nvim.bak.$TIMESTAMP"
fi

# ── Copy Neovim config ────────────────────────────────────────────────────────
info "Installing Neovim config..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p "$HOME/.config/nvim"
cp -r "$SCRIPT_DIR/config/." "$HOME/.config/nvim/"
success "Config installed to ~/.config/nvim/"

# ── Install plugins (lazy.nvim headless) ─────────────────────────────────────
info "Installing plugins via lazy.nvim (this may take a minute)..."
nvim --headless "+Lazy! sync" +qa 2>&1
success "Plugins installed."

# ── Install LSP servers, formatters, and debuggers (Mason headless) ───────────
info "Installing LSP servers, formatters, and debug adapters via Mason..."
info "This can take several minutes on first run — please wait."
nvim --headless "+MasonToolsInstallSync" +qa 2>&1
success "All tools installed."

# ── tmux config + TPM (Tmux Plugin Manager) ──────────────────────────────────
info "Installing tmux config..."
if [ -f "$HOME/.tmux.conf" ]; then
    warn "Existing tmux config found — backing up to ~/.tmux.conf.bak.$TIMESTAMP"
    mv "$HOME/.tmux.conf" "$HOME/.tmux.conf.bak.$TIMESTAMP"
fi
cp "$SCRIPT_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
mkdir -p "$HOME/.tmux/scripts"
cp "$SCRIPT_DIR/tmux/scripts/"*.sh "$HOME/.tmux/scripts/"
chmod +x "$HOME/.tmux/scripts/"*.sh
success "tmux config installed to ~/.tmux.conf"

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    info "Installing TPM (Tmux Plugin Manager)..."
    git clone -q https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi
info "Installing tmux plugins via TPM..."
"$HOME/.tmux/plugins/tpm/bin/install_plugins" > /dev/null 2>&1 || warn "Run 'prefix + I' inside tmux to finish installing plugins."
success "tmux plugins ready."

# ── Done ─────────────────────────────────────────────────────────────────────
echo ""
echo "────────────────────────────────────────"
success "Setup complete! Run 'nvim' to get started, or 'tmux' for the full environment."
echo ""
