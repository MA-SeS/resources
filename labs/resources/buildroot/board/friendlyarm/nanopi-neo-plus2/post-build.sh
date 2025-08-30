#!/bin/sh
BOARD_DIR="$(dirname $0)"
BUILDROOT_DIR="/workspace/buildroot"

#install -m 0644 -D $BOARD_DIR/extlinux.conf $BINARIES_DIR/extlinux/extlinux.conf
mkimage -C none -A arm64 -T script -d $BOARD_DIR/boot.cmd $BUILDROOT_DIR/output/images/boot.scr

