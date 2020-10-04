#!/bin/bash
rm ~/.config/backup/*
cp -rf ~/.config/ ~/.config/backup/
cp -rf $(dirname $0)/config/* ~/.config/
#install coc extensions
cd $HOME/.config/coc/extensions
yarn add coc-vimtex coc-python coc-neosnippet coc-pairs coc-tabnine
