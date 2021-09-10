FROM alpine:3.14

# core tools
RUN apk add alpine-sdk build-base apk-tools alpine-conf busybox fakeroot syslinux xorriso squashfs-tools sudo git

# efi tools
RUN apk add mtools dosfstools grub-efi

# RUN adduser -S build -G abuild \
#  && echo "%abuild ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/abuild \
#  && mkdir /build

# USER build
# WORKDIR /home/build

WORKDIR /root/
RUN ln -s aports/scripts/mnt/keys   .abuild

RUN git clone --depth 1 --branch 3.14-stable https://gitlab.alpinelinux.org/alpine/aports.git

WORKDIR /root/aports/scripts

RUN ln -s ./mnt/mkimg.crunchpine.sh mkimg.crunchpine.sh

#CMD [ "/bin/sh", "-c", "'mkdir mnt/keys && echo -e '\n' | abuild-keygen -i -a && mkdir mnt/iso && sh mkimage.sh --tag v3.14 --outdir ./mnt/iso/ --arch x86_64 --repository http://dl-cdn.alpinelinux.org/alpine/v3.14/main/ --repository http://dl-cdn.alpinelinux.org/alpine/v3.14/community/ --profile crunchpine'"]
