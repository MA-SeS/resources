#!/usr/bin/env bash
set -euo pipefail

# Copy the generated sdcard image 
SRC="/workspace/buildroot/output/images/sdcard.img"
DST_DIR="/workspace/sd_dir"

if [ ! -f "$SRC" ]; then
	echo "ERROR: source image not found: $SRC" >&2
	exit 2
fi

mkdir -p "$DST_DIR"
echo "Copying $SRC -> $DST_DIR/"
cp -v --reflink=auto "$SRC" "$DST_DIR/"
sync
echo "Done."
