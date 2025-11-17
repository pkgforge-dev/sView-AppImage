#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q sview-git | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=https://raw.githubusercontent.com/gkv311/sview/refs/heads/master/share/icons/hicolor/256x256/apps/sview.png
export DESKTOP=https://raw.githubusercontent.com/gkv311/sview/refs/heads/master/share/applications/sViewMP.desktop
export DEPLOY_PIPEWIRE=1

# Deploy dependencies
quick-sharun /usr/bin/sView /usr/share/fonts

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage
