#!/bin/sh

export	pwd=`readlink -f .`
echo "making ramdisk"
./mkbootfs ramdisk-spoof | gzip > ramdisk.gz

echo "making boot.img"
# packs the ramdisk together with the zImage at the proper locations and makes the boot.img
./mkbootimg --cmdline "init=/sbin/init root=/dev/ram rw initrd=0x11000000,16M console=ttyDCC0 mem=88M ip=dhcp" --kernel $PWD/zImage --ramdisk $PWD/ramdisk.gz -o $PWD/boot.img
rm ramdisk.gz
