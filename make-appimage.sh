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
export DEPLOY_OPENGL=1

# Deploy dependencies
quick-sharun \
  /usr/bin/sView  \
  /usr/bin/zenity \
  /usr/share/fonts/TTF

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the app normally quits before that time
# then skip this or check if some flag can be passed that makes it stay open
quick-sharun --test ./dist/*.AppImage
