#!/usr/bin/env bash
set -euo pipefail

echo "==> Installing lazygit"

if ! command -v brew >/dev/null 2>&1; then
    echo "==> Homebrew not found. Installing..."

    NONINTERACTIVE=1 /bin/bash -c \
        "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    if [[ -x /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -x /usr/local/bin/brew ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
fi

brew update
brew install lazygit

echo
echo "==============================="
echo "lazygit installation complete!"
echo "Version:"
lazygit --version
echo "==============================="

brew install rg fzf fd eza 


