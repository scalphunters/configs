#!/usr/bin/env bash
set -euo pipefail

BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"

OS="$(uname -s)"
ARCH="$(uname -m)"

case "$OS" in
    Linux)
        PLATFORM="linux"
        ;;
    Darwin)
        PLATFORM="osx"
        ;;
    *)
        echo "Unsupported OS: $OS"
        exit 1
        ;;
esac

case "$ARCH" in
    x86_64|amd64)
        ARCH="amd64"
        ;;
    aarch64|arm64)
        ARCH="arm64"
        ;;
    armv7l)
        ARCH="arm-v7"
        ;;
    armv6l)
        ARCH="arm"
        ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

echo "Fetching latest rclone release..."

VERSION=$(curl -fsSL https://api.github.com/repos/rclone/rclone/releases/latest \
    | grep '"tag_name"' \
    | head -1 \
    | cut -d '"' -f4)

FILE="rclone-${VERSION}-${PLATFORM}-${ARCH}.zip"
URL="https://github.com/rclone/rclone/releases/download/${VERSION}/${FILE}"

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

cd "$TMP"

echo "Downloading:"
echo "  $URL"

curl -fL -o rclone.zip "$URL"

echo "Extracting..."

if command -v unzip >/dev/null 2>&1; then
    unzip -q rclone.zip
else
    python3 - <<'PY'
import zipfile
zipfile.ZipFile("rclone.zip").extractall(".")
PY
fi

DIR=$(find . -maxdepth 1 -type d -name "rclone-*" | head -1)

if [[ -z "$DIR" ]]; then
    echo "Extraction failed."
    exit 1
fi

install -m755 "$DIR/rclone" "$BIN_DIR/rclone"

echo
echo "Installation complete."

"$BIN_DIR/rclone" version

if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    echo
    echo "Add the following to your shell rc:"
    echo
    echo 'export PATH="$HOME/.local/bin:$PATH"'
fi
