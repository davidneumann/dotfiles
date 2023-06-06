#!/bin/bash

# Make symbolic links for lua items here to ~/.config/wezterm/
for f in `find . -regex ".*\.lua$"`; do
    rm -rf ~/.config/wezterm/$f
    ln -s $(pwd)/$f ~/.config/wezterm/$f
done
