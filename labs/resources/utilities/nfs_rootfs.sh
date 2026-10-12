#!/usr/bin/env bash
set -euo pipefail

# Unpack the generated root filesystem into the NFS export and print the
# kernel command line needed to boot the target with it.
# Requires BR2_TARGET_ROOTFS_TAR=y (Filesystem images > tar the root filesystem).
SRC="/workspace/buildroot/output/images/rootfs.tar"
DST_DIR="/workspace/nfs-rootfs"
SERVER_IP="${SERVER_IP:-192.168.1.10}"   # address of the Docker host on the lab link
CLIENT_IP="${CLIENT_IP:-192.168.1.2}"    # address of the target
NETMASK="${NETMASK:-255.255.255.0}"

if [ ! -f "$SRC" ]; then
	echo "ERROR: source archive not found: $SRC" >&2
	echo "Enable BR2_TARGET_ROOTFS_TAR in Buildroot and run make again." >&2
	exit 2
fi

# Run as root so that ownership, permissions and device nodes are preserved.
echo "Replacing contents of $DST_DIR with $SRC"
sudo find "$DST_DIR" -mindepth 1 -delete
sudo tar --numeric-owner -xpf "$SRC" -C "$DST_DIR"

# With an NFS root, eth0 is already configured by the kernel (ip= option).
# Do not let ifup touch it: Buildroot's nfs_check would skip it anyway, but
# makes S40network report FAIL.
sudo sed -i 's/^auto eth0$/# auto eth0 (configured by the kernel ip= option for NFS root)/' \
	"$DST_DIR/etc/network/interfaces"
sync
echo "Done."

echo
echo "Use this as the single line in cmdline.txt on the target's boot partition:"
echo "root=/dev/nfs nfsroot=${SERVER_IP}:/,vers=4.1,proto=tcp rw ip=${CLIENT_IP}:${SERVER_IP}::${NETMASK}::eth0:off console=tty1 console=ttyAMA0,115200"
