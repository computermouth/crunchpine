
profile_crunchpine() {
	profile_standard
	profile_extended
	profile_abbrev="crunchpine"
	title="Crunchpine"
	desc="Desktop alpine with openbox"
	arch="x86 x86_64"
	kernel_addons="xtables-addons zfs"
	boot_addons="amd-ucode intel-ucode"
	initrd_ucode="/boot/amd-ucode.img /boot/intel-ucode.img"
	apkovl="genapkovl-crunchpine.sh"
#	kernel_addons="xtables-addons zfs"
#	boot_addons="amd-ucode intel-ucode"
#	initrd_ucode="/boot/amd-ucode.img /boot/intel-ucode.img"
	apks="$apks"

	local _k _a
	for _k in $kernel_flavors; do
		apks="$apks linux-$_k"
		for _a in $kernel_addons; do
			apks="$apks $_a-$_k"
		done
	done
}
