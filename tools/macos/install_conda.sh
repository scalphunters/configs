#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="$HOME/.miniconda3"

ARCH="$(uname -m)"

case "$ARCH" in
    arm64)
        INSTALLER="Miniconda3-latest-MacOSX-arm64.sh"
        ;;
    x86_64)
        INSTALLER="Miniconda3-latest-MacOSX-x86_64.sh"
        ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

URL="https://repo.anaconda.com/miniconda/${INSTALLER}"

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

cd "$TMP"

echo "Downloading Miniconda..."
curl -fLO "$URL"

echo "Installing to $INSTALL_DIR ..."
bash "$INSTALLER" -b -p "$INSTALL_DIR"

export PATH="$INSTALL_DIR/bin:$PATH"

echo "Initializing shell..."
conda init zsh

echo
echo "Updating conda..."
conda update -n base -c defaults -y conda

echo
echo "Installed successfully."

conda --version
python --version

echo
echo "Restart your terminal or run:"
echo "source ~/.zshrc"
