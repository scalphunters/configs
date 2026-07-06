#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="$HOME/.local/miniconda3"
TMP_DIR="$(mktemp -d)"
INSTALLER="$TMP_DIR/miniconda.sh"

cleanup() {
  rm -rf "$TMP_DIR"
}
trap cleanup EXIT

mkdir -p "$HOME/.local"

if [ -d "$INSTALL_DIR" ]; then
  echo "Miniconda already exists: $INSTALL_DIR"
  exit 0
fi

ARCH="$(uname -m)"
OS="$(uname -s)"

case "$OS-$ARCH" in
  Linux-x86_64)
    URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
    ;;
  Linux-aarch64)
    URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh"
    ;;
  Darwin-x86_64)
    URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh"
    ;;
  Darwin-arm64)
    URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh"
    ;;
  *)
    echo "Unsupported platform: $OS-$ARCH"
    exit 1
    ;;
esac

echo "Downloading Miniconda..."
curl -fsSL "$URL" -o "$INSTALLER"

echo "Installing Miniconda to $INSTALL_DIR..."
bash "$INSTALLER" -b -p "$INSTALL_DIR"

echo "Initializing conda..."
"$INSTALL_DIR/bin/conda" init bash

if [ -n "${ZSH_VERSION:-}" ]; then
  "$INSTALL_DIR/bin/conda" init zsh
fi

echo
echo "Done."
echo "Restart your shell, or run:"
echo
echo "source ~/.bashrc"
echo
echo "Then test:"
echo
echo "conda --version"
