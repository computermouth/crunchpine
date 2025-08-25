
profile_crunchpine() {
	profile_extended
	profile_abbrev="crunchpine"
	title="Crunchpine"
	desc="Desktop alpine with openbox"
	apkovl="genapkovl-crunchpine.sh"
	apks="$apks
          dbus
          sudo
          ttf-liberation
          lxdm
          xorg-server
          mesa-egl
          mesa-dri-gallium
          xf86-video-modesetting
          xf86-input-evdev
          xf86-input-synaptics
          xf86-input-libinput
          xinit
          xterm
          openbox
          tint2
          conky
          xscreensaver
          geany
          terminator
          thunar
          adwaita-icon-theme
          calamares
          calamares-mod-luksopenswaphookcfg
          calamares-mod-locale
          calamares-mod-keyboard
          calamares-mod-localeq
          calamares-mod-packagechooser
          calamares-mod-fsresizer
          calamares-mod-plymouthcfg
          calamares-mod-welcomeq
          calamares-mod-shellprocess
          calamares-mod-netinstall
          calamares-mod-umount
          calamares-mod-grubcfg
          calamares-mod-keyboardq
          calamares-mod-users
          calamares-mod-webview
          calamares-mod-interactiveterminal
          calamares-mod-rawfs
          calamares-mod-notesqml
          calamares-mod-finished
          calamares-mod-networkcfg
          calamares-mod-oemid
          calamares-mod-fstab
          calamares-mod-packages
          calamares-mod-preservefiles
          calamares-mod-mount
          calamares-mod-welcome
          calamares-mod-hostinfo
          calamares-mod-hwclock
          calamares-mod-summary
          calamares-mod-bootloader
          calamares-mod-partition
          calamares-mod-machineid
          calamares-mod-displaymanager
          calamares-mod-luksbootkeyfile
          calamares-mod-mkinitfs
          calamares-mod-removeuser
          calamares-mod-services-openrc
          calamares-mod-plasmalnf
          calamares-mod-unpackfs
	      "
}

# adwaita-icon-theme    26,370.0 kB
# breeze-icon-theme   	29,771.0 kB
# gnome-icon-theme      15,193.0 kB
# tango-icon-theme      11,032.0 kB
