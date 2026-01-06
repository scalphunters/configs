#!/bin/bash

# vimrc
cp ./.vimrc $HOME/
# NERDTree
git clone https://github.com/preservim/nerdtree.git ~/.vim/pack/vendor/start/nerdtree
vim -u NONE -c "helptags ~/.vim/pack/vendor/start/nerdtree/doc" -c q

# NERDCommenter
git clone https://github.com/preservim/nerdcommenter.git ~/.vim/pack/vendor/start/nerdcommenter

# Git fugitive
#
mkdir -p ~/.vim/pack/tpope/start
cd ~/.vim/pack/tpope/start
git clone https://tpope.io/vim/fugitive.git
vim -u NONE -c "helptags fugitive/doc" -c q
