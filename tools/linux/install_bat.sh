#!/usr/bin/env bash

set -euo pipefail

INSTALL_DIR="$HOME/.local/bin"
TMP_DIR="$(mktemp -d)"

mkdir -p "$INSTALL_DIR"

cleanup() {
    rm -rf "$TMP_DIR"
}
trap cleanup EXIT

ARCH=$(uname -m)

case "$ARCH" in
    x86_64)
        BAT_ARCH="x86_64-unknown-linux-musl"
        ;;
    aarch64|arm64)
        BAT_ARCH="aarch64-unknown-linux-musl"
        ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

BAT_VERSION=$(curl -fsSL https://api.github.com/repos/sharkdp/bat/releases/latest \
    | grep '"tag_name"' \
    | cut -d '"' -f4)

echo "Installing bat $BAT_VERSION"

cd "$TMP_DIR"

curl -fsSLO \
"https://github.com/sharkdp/bat/releases/download/${BAT_VERSION}/bat-${BAT_VERSION}-${BAT_ARCH}.tar.gz"

tar -xzf "bat-${BAT_VERSION}-${BAT_ARCH}.tar.gz"

cp "bat-${BAT_VERSION}-${BAT_ARCH}/bat" "$INSTALL_DIR"

chmod +x "$INSTALL_DIR/bat"

echo
echo "Installed:"
"$INSTALL_DIR/bat" --version

echo
echo 'If needed, add to PATH:'
echo 'export PATH="$HOME/.local/bin:$PATH"'
