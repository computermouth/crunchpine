#!/bin/sh -e

# HOSTNAME="$1"
# if [ -z "$HOSTNAME" ]; then
# 	echo "usage: $0 hostname"
# 	exit 1
# fi

cleanup() {
	rm -rf "$tmp"
}

makefile() {
	OWNER="$1"
	PERMS="$2"
	FILENAME="$3"
	cat > "$FILENAME"
	chown "$OWNER" "$FILENAME"
	chmod "$PERMS" "$FILENAME"
}

rc_add() {
	mkdir -p "$tmp"/etc/runlevels/"$2"
	ln -sf /etc/init.d/"$1" "$tmp"/etc/runlevels/"$2"/"$1"
}

tmp="$(mktemp -d)"
trap cleanup EXIT

mkdir -p "$tmp"/etc/apk
makefile root:root 0644 "$tmp"/etc/apk/world <<EOF
openbox
pcmanfm
terminator
lxdm
EOF

# do i need these?
rc_add devfs sysinit
rc_add dmesg sysinit
rc_add mdev sysinit
rc_add hwdrivers sysinit
rc_add modloop sysinit

rc_add hwclock boot
rc_add modules boot
rc_add sysctl boot
rc_add hostname boot
rc_add bootmisc boot
rc_add syslog boot

rc_add mount-ro shutdown
rc_add killprocs shutdown
rc_add savecache shutdown

# real shit
rc_add lxdm default
sed -i 's|# autologin=dgod|autologin=root|g' "$tmp"/etc/lxdm/lxdm.conf

tar -c -C "$tmp" etc | gzip -9n > $HOSTNAME.apkovl.tar.gz