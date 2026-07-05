#!/usr/bin/env bash
set -euo pipefail

BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"

ARCH="$(uname -m)"

case "$ARCH" in
  arm64) RCLONE_ARCH="arm64" ;;
  x86_64) RCLONE_ARCH="amd64" ;;
  *) echo "Unsupported arch: $ARCH"; exit 1 ;;
esac

VERSION="$(curl -fsSL https://api.github.com/repos/rclone/rclone/releases/latest \
  | grep '"tag_name"' | head -1 | cut -d '"' -f4)"

FILE="rclone-${VERSION}-osx-${RCLONE_ARCH}.zip"
URL="https://github.com/rclone/rclone/releases/download/${VERSION}/${FILE}"

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

cd "$TMP"
curl -fL -o rclone.zip "$URL"
unzip -q rclone.zip

DIR="$(find . -maxdepth 1 -type d -name 'rclone-*' | head -1)"
install -m755 "$DIR/rclone" "$BIN_DIR/rclone"

echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"

"$BIN_DIR/rclone" version
