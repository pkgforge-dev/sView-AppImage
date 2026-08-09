#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
	cmake          \
	libconfig      \
	libxext        \
	libxpm         \
	openal         \
	pipewire-audio \
	pipewire-jack  \
	ttf-dejavu

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano ffmpeg-mini

make-aur-package zenity-rs-bin

# If the application needs to be manually built that has to be done down here
echo "Building sView..."
echo "---------------------------------------------------------------"
git clone https://github.com/gkv311/sview ./sview
cd ./sview

git fetch --tags origin
TAG=$(git tag --sort=-v:refname | grep -vi 'preview\|alpha\|beta' | head -1)
git checkout "$TAG"

cmake -S ./ -B build -D CMAKE_INSTALL_PREFIX=/usr -D USE_OPENVR=OFF
cmake --build build
cmake --install build

echo "$TAG" > ~/version
