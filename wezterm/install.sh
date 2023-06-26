#!/bin/bash

# Make symbolic links for lua items here to ~/.config/wezterm/
#for f in `find . -regex ".*\.lua$"`; do
# Now without leading ./
mkdir -p $HOME/.config/wezterm/
for f in `find . -type f -regex ".*\.lua$" -printf '%P\n'`; do
    rm -rf $HOME/.config/wezterm/$f
    ln -s $(pwd)/$f $HOME/.config/wezterm/$f
done
