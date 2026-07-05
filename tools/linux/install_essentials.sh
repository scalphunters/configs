#!/bin/bash


mkdir -p ~/.local/bin

## Lazygit

LAZYGIT_VERSION=$(curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest \
  | grep -Po '"tag_name": "v\K[^"]*')

curl -Lo /tmp/lazygit.tar.gz \
"https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"

tar -xzf /tmp/lazygit.tar.gz -C /tmp lazygit

mv /tmp/lazygit ~/.local/bin/
chmod +x ~/.local/bin/lazygit

## UV

curl -LsSf https://astral.sh/uv/install.sh | sh

## NVM 

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.5/install.sh | bash

## Rust

echo "Installing Rust"

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

