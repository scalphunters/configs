#!/usr/bin/env bash
set -euo pipefail

BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"

ARCH="$(uname -m)"

case "$ARCH" in
    x86_64)
        TARGET="x86_64-unknown-linux-gnu"
        ;;
    aarch64|arm64)
        TARGET="aarch64-unknown-linux-gnu"
        ;;
    armv7l)
        TARGET="armv7-unknown-linux-gnueabihf"
        ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

VERSION="$(curl -fsSL https://api.github.com/repos/eza-community/eza/releases/latest \
    | grep '"tag_name"' \
    | head -1 \
    | cut -d '"' -f4)"

FILE="eza_${TARGET}.tar.gz"
URL="https://github.com/eza-community/eza/releases/download/${VERSION}/${FILE}"

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

cd "$TMP"

echo "Downloading $URL"
curl -fL -o eza.tar.gz "$URL"

echo "Extracting..."
tar -xzf eza.tar.gz

echo "Installing to $BIN_DIR/eza"
install -m755 eza "$BIN_DIR/eza"

echo
echo "Installed:"
"$BIN_DIR/eza" --version

if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    echo
    echo "Add this to ~/.bashrc or ~/.zshrc:"
    echo 'export PATH="$HOME/.local/bin:$PATH"'
fi
