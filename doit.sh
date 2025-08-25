#!/bin/sh -e

echo -e "\n" | abuild-keygen -i -a
sh mkimage.sh \
 --tag v3.19 \
 --outdir ./mnt/iso/ \
 --arch x86_64 \
 --repository http://dl-cdn.alpinelinux.org/alpine/v3.19/main/ \
 --repository http://dl-cdn.alpinelinux.org/alpine/v3.19/community/ \
 --profile crunchpine
