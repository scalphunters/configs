#!/usr/bin/env bash
set -euo pipefail

curl -LsSf https://astral.sh/uv/install.sh | sh

export PATH="$HOME/.local/bin:$PATH"

echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"

uv --version
