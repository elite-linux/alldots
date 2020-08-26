#!/bin/bash
# Small script to auto git changes..
# for all my dot files.


MAINDIR='/home/hackuin/alldotfiles/'
DATE=$(date):
cp /home/hackuin/.config/i3/config "$MAINDIR"
cp /home/hackuin/.config/compton.conf "$MAINDIR"
cp /home/hackuin/.config/nvim/init.vim "$MAINDIR"


cd "$MAINDIR" || echo "Cannot change directory..." 
echo "$PWD"
git add .
git commit -m "from shellscript $DATE:"
git push -f origin master
