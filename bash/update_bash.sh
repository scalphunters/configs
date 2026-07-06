#!/bin/bash

RCFILENAME=$HOME/.bashrc

echo "alias ls='eza'" >> $RCFILENAME
echo "alias la='eza -alh --git --icons'" >> $RCFILENAME
echo "alias lse='eza -alh --git --icons'" >> $RCFILENAME 
echo "alias ll='eza -alh --git --icons'" >> $RCFILENAME 
echo "alias lt='eza -alh --git --tree --icons'" >> $RCFILENAME 
