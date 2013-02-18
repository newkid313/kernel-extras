#!/bin/sh

export	pwd=`readlink -f .`
echo "making ramdisk"
./mkbootfs cm-ls970 | gzip > ramdisk.gz

echo "making boot.img"
# packs the ramdisk together with the zImage at the proper locations and makes the boot.img
# ./mkbootimg --cmdline "vmalloc=600M console=ttySHL0,115200,n8 lpj=67677 user_debug=31 msm_rtb.filter=0x0 ehci-hcd.park=3 androidboot.hardware=geehrc" --kernel $PWD/zImage --ramdisk $PWD/ramdisk.gz --base 0x80200000 --ramdiskaddr 0x81500000 -o $PWD/boot.img
./mkbootimg --cmdline "vmalloc=600M console=ttySHL0,115200,n8 lpj=67677 user_debug=31 msm_rtb.filter=0x0 ehci-hcd.park=3 androidboot.hardware=geehrc" --kernel $PWD/zImage --ramdisk $PWD/ramdisk.gz --base 0x80200000 --pagesize 2048 --ramdisk_offset 0x01500000 -o $PWD/boot.img
rm ramdisk.gz

