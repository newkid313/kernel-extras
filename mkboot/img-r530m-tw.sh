#!/bin/sh

export	pwd=`readlink -f .`
echo "making ramdisk"
./mkbootfs ramdisk-r530m-tw | gzip > ramdisk.gz

echo "making boot.img"
# packs the ramdisk together with the zImage at the proper locations and makes the boot.img
./mkbootimg --cmdline "console=null androidboot.hardware=qcom user_debug=31" --kernel $PWD/zImage --ramdisk $PWD/ramdisk.gz --base 0x80200000 --ramdiskaddr 0x81500000 -o $PWD/boot.img
rm ramdisk.gz
