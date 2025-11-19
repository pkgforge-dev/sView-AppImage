#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm pipewire-audio pipewire-jack ttf-dejavu

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano ffmpeg-mini

# According to upstream release notes gtk2 is no longer needed
# also the AUR packager forgot to include cmake in the dependencies
make-aur-package zenity-gtk3
PRE_BUILD_CMDS="sed -i -e 's|gtk2|cmake|g' ./PKGBUILD" make-aur-package sview-git

# If the application needs to be manually built that has to be done down here
