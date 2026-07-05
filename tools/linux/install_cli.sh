#!/usr/bin/env bash

set -euo pipefail

INSTALL_DIR="$HOME/.local/bin"
TMP_DIR="$(mktemp -d)"

mkdir -p "$INSTALL_DIR"

echo "Installing into $INSTALL_DIR"

cleanup() {
    rm -rf "$TMP_DIR"
}
trap cleanup EXIT

ARCH=$(uname -m)

case "$ARCH" in
    x86_64)
        RG_ARCH="x86_64-unknown-linux-musl"
        FD_ARCH="x86_64-unknown-linux-musl"
        FZF_ARCH="linux_amd64"
        ;;
    aarch64|arm64)
        RG_ARCH="aarch64-unknown-linux-musl"
        FD_ARCH="aarch64-unknown-linux-musl"
        FZF_ARCH="linux_arm64"
        ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

echo "==> Getting latest versions..."

RG_VERSION=$(curl -fsSL https://api.github.com/repos/BurntSushi/ripgrep/releases/latest | grep '"tag_name"' | cut -d '"' -f4)
FD_VERSION=$(curl -fsSL https://api.github.com/repos/sharkdp/fd/releases/latest | grep '"tag_name"' | cut -d '"' -f4)
FZF_VERSION=$(curl -fsSL https://api.github.com/repos/junegunn/fzf/releases/latest | grep '"tag_name"' | cut -d '"' -f4)

####################################
# ripgrep
####################################

echo "Installing ripgrep $RG_VERSION"

cd "$TMP_DIR"

curl -fsSLO \
"https://github.com/BurntSushi/ripgrep/releases/download/${RG_VERSION}/ripgrep-${RG_VERSION#v}-${RG_ARCH}.tar.gz"

tar -xzf "ripgrep-${RG_VERSION#v}-${RG_ARCH}.tar.gz"

cp "ripgrep-${RG_VERSION#v}-${RG_ARCH}/rg" "$INSTALL_DIR"

####################################
# fd
####################################
echo "Installing fd $FD_VERSION"

curl -fsSLO \
"https://github.com/sharkdp/fd/releases/download/${FD_VERSION}/fd-${FD_VERSION}-${FD_ARCH}.tar.gz"

tar -xzf "fd-${FD_VERSION}-${FD_ARCH}.tar.gz"

cp "fd-${FD_VERSION}-${FD_ARCH}/fd" "$INSTALL_DIR"

####################################
# fzf
####################################

echo "Installing fzf $FZF_VERSION"

curl -fsSLO \
"https://github.com/junegunn/fzf/releases/download/${FZF_VERSION}/fzf-${FZF_VERSION#v}-${FZF_ARCH}.tar.gz"

tar -xzf "fzf-${FZF_VERSION#v}-${FZF_ARCH}.tar.gz"

cp fzf "$INSTALL_DIR"

chmod +x \
    "$INSTALL_DIR/rg" \
    "$INSTALL_DIR/fd" \
    "$INSTALL_DIR/fzf"

echo
echo "Installation complete."
echo

echo "Versions:"
"$INSTALL_DIR/rg" --version | head -1
"$INSTALL_DIR/fd" --version
"$INSTALL_DIR/fzf" --version

echo
echo "If needed, add this to your shell:"
echo 'export PATH="$HOME/.local/bin:$PATH"'
