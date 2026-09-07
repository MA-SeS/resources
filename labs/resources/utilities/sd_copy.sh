#!/usr/bin/env bash
set -euo pipefail

# Copy the generated sdcard image 
SRC="buildroot/output/images/sdcard.img"
DST_DIR="sd_folder"

if [ ! -f "$SRC" ]; then
	echo "ERROR: source image not found: $SRC" >&2
	exit 2
fi

mkdir -p "$DST_DIR"
echo "Copying $SRC -> $DST_DIR/"
cp -v --reflink=auto "$SRC" "$DST_DIR/"
sync
echo "Done."