#!/bin/bash
# Small script to auto git changes..
# for all my dot files.


MAINDIR="$HOME/alldotfiles/"
DATE=$(date):
cp "$HOME/.config/i3/config" "$MAINDIR"
cp "$HOME/.config/compton.conf" "$MAINDIR"
cp "$HOME/.config/nvim/init.vim" "$MAINDIR"


cd "$MAINDIR" || echo "Cannot change directory..." 
echo "$PWD"
git add .
git commit -m "from shellscript $DATE:"
git push -f origin master
