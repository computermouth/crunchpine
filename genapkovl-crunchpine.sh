#!/bin/sh -e

HOSTNAME="$1"
if [ -z "$HOSTNAME" ]; then
	echo "usage: $0 hostname"
	exit 1
fi

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

rc_rem() {
	rm "$tmp"/etc/runlevels/"$2"/"$1"
}

tmp="$(mktemp -d)"
trap cleanup EXIT

mkdir -p "$tmp"/etc
makefile root:root 0644 "$tmp"/etc/hostname <<EOF
$HOSTNAME
EOF

mkdir -p "$tmp"/etc/network
makefile root:root 0644 "$tmp"/etc/network/interfaces <<EOF
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
EOF

mkdir -p "$tmp"/etc/apk
makefile root:root 0644 "$tmp"/etc/apk/world <<EOF
alpine-base
openssl
EOF

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

## start crunchpines system
makefile root:root 0644 "$tmp"/etc/apk/repositories <<EOF
https://dl-cdn.alpinelinux.org/alpine/v3.14/main
https://dl-cdn.alpinelinux.org/alpine/v3.14/community
EOF

cat << EOF >> "$tmp"/etc/apk/world
dbus
sudo
ttf-liberation
lxdm
xorg-server
xf86-video-modesetting
xf86-input-evdev
xf86-input-synaptics
xf86-input-libinput
xinit
xterm
openbox
tint2
conky
EOF

# fontconfig
rc_rem mdev sysinit
rc_rem hwdrivers sysinit

rc_add udev sysinit
rc_add udev-postmount sysinit
rc_add udev-trigger sysinit
rc_add udev-settle sysinit
rc_add lxdm default
rc_add dbus default
rc_add networking default
rc_add crond default
rc_add acpid default

## crunchpines user
mkdir -p "$tmp"/etc/init.d
makefile root:root 0755 "$tmp"/etc/init.d/crunchpine-user-setup <<EOF
#!/sbin/openrc-run
depend(){}

start(){
	echo -e "live\nlive\n" | adduser live
	adduser live wheel
	sed -i 's|# %wheel ALL=(ALL) ALL|%wheel ALL=(ALL) ALL|g'                   /etc/sudoers
	sed -i 's|# autologin=dgod|autologin=live|g'                               /etc/lxdm/lxdm.conf
	sed -i 's|# session=/usr/bin/startlxde|session=/usr/bin/openbox-session|g' /etc/lxdm/lxdm.conf
	rc-update del crunchpine-user-setup
	rm /etc/init.d/crunchpine-user-setup
}

stop(){}
EOF

rc_add crunchpine-user-setup sysinit

mkdir -p "$tmp"/etc/skel/.config/openbox
makefile root:root 0644 "$tmp"/etc/skel/.config/openbox/autostart <<EOF
tint2 &
conky -q &
EOF

tar -c -C "$tmp" etc | gzip -9n > $HOSTNAME.apkovl.tar.gz
