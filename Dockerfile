FROM alpine:3.19

# core tools
RUN apk add alpine-sdk build-base apk-tools alpine-conf busybox fakeroot syslinux xorriso squashfs-tools sudo git

# efi tools
RUN apk add mtools dosfstools grub-efi

# chroot
RUN apk add coreutils

RUN adduser --uid 1000 -S build -G abuild \
 && echo "%abuild ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/abuild \
 && mkdir /build

USER build
WORKDIR /home/build

RUN ln -s aports/scripts/mnt/keys   .abuild

RUN git clone --depth 1 --branch 3.19-stable https://gitlab.alpinelinux.org/alpine/aports.git

WORKDIR /home/build/aports/scripts

RUN ln -s ./mnt/mkimg.crunchpine.sh     mkimg.crunchpine.sh
RUN ln -s ./mnt/genapkovl-crunchpine.sh genapkovl-crunchpine.sh

CMD [ "./mnt/doit.sh"]
