#!/bin/bash

RCFILENAME=$HOME/.zshrc

echo "alias ls='eza -alh --git --icons'" >> $RCFILENAME
echo "alias lse='eza -alh --git --icons'" >> $RCFILENAME 
echo "alias ll='eza -alh --git --icons'" >> $RCFILENAME 
echo "alias lt='eza -alh --git --tree --icons'" >> $RCFILENAME 
