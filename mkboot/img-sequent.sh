#!/bin/sh

export	pwd=`readlink -f .`
echo "making ramdisk"
./mkbootfs ramdisk-sequent | gzip > ramdisk.gz

echo "making boot.img"
# packs the ramdisk together with the zImage at the proper locations and makes the boot.img
./mkbootimg --cmdline "console=ttyMSM1,115200" --kernel $pwd/zImage --ramdisk $pwd/ramdisk.gz --base 0x0200000 --pagesize 4096 --ramdiskaddr 0x01500000 -o $pwd/boot.img
rm ramdisk.gz
