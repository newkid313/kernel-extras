#!/bin/sh

export	pwd=`readlink -f .`
echo "making ramdisk"
./mkbootfs motonew-asanti | gzip > ramdisk.gz

echo "making boot.img"
# packs the ramdisk together with the zImage at the proper locations and makes the boot.img
./mkbootimg --cmdline "console=/dev/null androidboot.hardware=qcom user_debug=31 loglevel=1 msm_rtb.filter=0x3F kgsl.mmutype=gpummu" --kernel $pwd/zImage --ramdisk $pwd/ramdisk.gz --base 0x80200000 --ramdisk_offset 0x01600000 -o $pwd/boot.img
rm ramdisk.gz
echo "You got it man!"
