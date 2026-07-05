#!/usr/bin/env bash
set -euo pipefail

BIN_DIR="$HOME/.local/bin"

mkdir -p "$BIN_DIR"

echo "==> Detecting architecture..."

ARCH=$(uname -m)
case "$ARCH" in
    arm64)
        TARGET="aarch64-apple-darwin"
        ;;
    x86_64)
        TARGET="x86_64-apple-darwin"
        ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

echo "==> Fetching latest release..."

VERSION=$(curl -fsSL https://api.github.com/repos/eza-community/eza/releases/latest \
    | grep '"tag_name"' \
    | head -1 \
    | cut -d '"' -f4)

FILE="eza_${TARGET}.tar.gz"
URL="https://github.com/eza-community/eza/releases/download/${VERSION}/${FILE}"

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

cd "$TMP"

echo "==> Downloading $URL"
curl -fL -o eza.tar.gz "$URL"

echo "==> Extracting..."
tar -xzf eza.tar.gz

echo "==> Installing..."
install -m755 eza "$BIN_DIR/eza"

echo
echo "Installation complete!"
"$BIN_DIR/eza" --version

if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    echo
    echo "Add the following to your ~/.zshrc (or ~/.bashrc):"
    echo
    echo 'export PATH="$HOME/.local/bin:$PATH"'
fi
