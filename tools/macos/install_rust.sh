#!/usr/bin/env bash
set -euo pipefail

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \
  | sh -s -- -y --no-modify-path

export PATH="$HOME/.cargo/bin:$PATH"

rustup update stable
rustup default stable

echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> "$HOME/.zshrc"

rustc --version
cargo --version
