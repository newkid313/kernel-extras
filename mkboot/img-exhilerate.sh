#!/bin/sh

export	pwd=`readlink -f .`
echo "making ramdisk"
./mkbootfs ramdisk-i577 | gzip > ramdisk.gz

echo "making boot.img"
# packs the ramdisk together with the zImage at the proper locations and makes the boot.img
./mkbootimg --cmdline "androidboot.hardware=qcom usb_id_pin_rework=true" --kernel $pwd/zImage --ramdisk $pwd/ramdisk.gz --base 0x40400000 --ramdiskaddr 0x41800000 -o $pwd/boot.img
rm ramdisk.gz
