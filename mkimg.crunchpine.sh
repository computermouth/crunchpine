
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
          xf86-video-modesetting
          xf86-input-evdev
          xf86-input-synaptics
          xf86-input-libinput
          xinit
          xterm
          openbox
          tint2
          conky
	      "
}
