#!/bin/bash
set -e

PKG_NAME=$1
PKG_DIR=$(realpath "$(dirname "$0")/../packages/$PKG_NAME")
source "$PKG_DIR/build.sh"

BUILD_DIR=$(realpath "./build-$PKG_NAME")
rm -rf "$BUILD_DIR" && mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

echo "[↓] Downloading source..."
wget "$TERMUX_PKG_SRCURL" -O source.tar.gz

echo "$TERMUX_PKG_SHA256  source.tar.gz" | sha256sum -c

echo "[📦] Extracting..."
tar -xf source.tar.gz --strip-components=1

echo "[⚙] Configuring..."
./configure --prefix=/usr $TERMUX_PKG_EXTRA_CONFIGURE_ARGS

echo "[🔨] Building..."
make -j$(nproc)

echo "[📥] Installing to DESTDIR..."
make DESTDIR="$BUILD_DIR/install" install

mkdir -p "$BUILD_DIR/install/DEBIAN"
echo "Package: $TERMUX_PKG_NAME
Version: $TERMUX_PKG_VERSION
Architecture: all
Maintainer: GitHub Builder
Description: Custom built package" > "$BUILD_DIR/install/DEBIAN/control"

dpkg-deb --build "$BUILD_DIR/install" "./${TERMUX_PKG_NAME}_${TERMUX_PKG_VERSION}.deb"

mkdir -p ../../output
mv ./*.deb ../../output/

echo "🧾 Files in output/:"
ls -lh ../../output || echo "output folder missing!"