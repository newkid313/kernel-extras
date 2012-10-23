#!/bin/sh

export	pwd=`readlink -f .`
echo "making ramdisk"
./mkbootfs ramdisk-m950 | gzip > ramdisk.gz

echo "making boot.img"
# packs the ramdisk together with the zImage at the proper locations and makes the boot.img
./mkbootimg --cmdline "console=ttyDCC0 mem=88M ip=dhcp" --kernel $PWD/zImage --ramdisk $PWD/ramdisk.gz -o $PWD/boot.img
rm ramdisk.gz
