#!/bin/bash

sudo apt -y install aptitude
sudo aptitude update
sudo aptitude -y safe-upgrade
sudo aptitude -y install git vim

cat > ~/.bash_aliases <<TXT
alias ll="ls -l"
TXT

cat > ~/.vimrc <<TXT
set autoindent
set nu
set expandtab
set shiftwidth=2
set showmatch ai
set tabstop=2
syntax enable
set background=dark
set viminfo='10,\"100,:20,%,n~/.viminfo
TXT
