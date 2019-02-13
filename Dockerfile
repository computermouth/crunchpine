FROM alpine:3.9

RUN apk update && apk add \
 abuild apk-tools alpine-conf busybox fakeroot syslinux xorriso mtools grub-efi \
 git alpine-sdk

RUN adduser root abuild

WORKDIR /root

RUN git clone https://github.com/alpinelinux/aports

RUN echo -e \
"#!/bin/sh -e\n\
apk update\n\
./aports/scripts/mkimage.sh \\ \
  --outdir /root/out \\ \
  --profile standard \\ \
  --repository http://dl-cdn.alpinelinux.org/alpine/v3.9/main \\ \
  --repository http://dl-cdn.alpinelinux.org/alpine/v3.9/community\n\
ls -lsah\n\
" > build.sh

RUN chmod +x build.sh
RUN abuild-keygen -i -a

CMD [ "./build.sh" ]
