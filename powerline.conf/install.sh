#!/bin/bash

# Download the latest version of the symbol font and fontconfig file:
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf

# Move the symbol font to a valid X font path. Valid font paths can be listed with xset q:
mkdir ~/.fonts/
mv PowerlineSymbols.otf ~/.fonts/

# Update font cache for the path the font was moved to (root priveleges may be needed to update cache for the system-wide paths):
fc-cache -vf ~/.fonts/

mkdir -p ~/.config/fontconfig/conf.d
mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/

