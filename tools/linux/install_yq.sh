#!/usr/bin/env bash
set -euo pipefail

BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"

ARCH="$(uname -m)"

case "$ARCH" in
    x86_64)
        TARGET="amd64"
        ;;
    aarch64|arm64)
        TARGET="arm64"
        ;;
    armv7l)
        TARGET="arm"
        ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

VERSION="$(curl -fsSL https://api.github.com/repos/mikefarah/yq/releases/latest \
    | grep '"tag_name"' \
    | head -1 \
    | cut -d '"' -f4)"

URL="https://github.com/mikefarah/yq/releases/download/${VERSION}/yq_linux_${TARGET}"

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

cd "$TMP"

echo "Downloading yq ${VERSION}..."
curl -fL -o yq "$URL"

chmod +x yq
mv yq "$BIN_DIR/"

echo
echo "Installed:"
"$BIN_DIR/yq" --version

if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    echo
    echo "Add this to ~/.bashrc or ~/.zshrc:"
    echo 'export PATH="$HOME/.local/bin:$PATH"'
fi
