#! /usr/bin/env bash
## Automatic Installation BlanckArm on Termux android
## Authur Salar Muhammadi
#####################################################
##
### VARIABLES ###
declare folder="$HOME/arch-fs";
declare cur=`pwd`;
declare tarball="$cur/arch-rootfs.tar.gz";
declare first="$cur/first";
### VARIABLES ###
#
apt-get update -y && apt-get dist-upgrade -y;
apt-get install wget curl proot tar -y;
#
if ! [[ -d $folder ]];then
	if ! [[ -f $first ]];then
		if ! [[ -f $tarball ]];then
			echo "Download RootFS, this may take a while base on your internet speed.";
			case `dpkg --print-architecture` in
			aarch64)
				archurl="aarch64";;
			arm)
				archurl="armv7";;
			*)
				echo "unknown architecture"; exit 1;;
			esac;
			wget "http://os.archlinuxarm.org/os/ArchLinuxARM-${archurl}-latest.tar.gz" -O $tarball;
		fi;
		mkdir -p "$folder";
		cd "$folder";
		echo "Decompressing RootFS, Please be patient.";
		exec proot --link2symlink -0 tar -xf "$tarball" -v ||:
		cd "$cur";
	fi;
fi;
! [[ -f "$PREFIX/bin/start-blanckarm" ]] && touch "$PREFIX/bin/start-blanckarm";
! [[ -f etc/start-blanckarm.sh ]] && wget https://raw.githubusercontent.com/blanckth/blanckarm/main/etc/start-blanckarm.sh -P etc/;
mv etc/start-blanckarm.sh "$PREFIX/bin/start-blanckarm";
chmod +x "$PREFIX/bin/start-blanckarm";
! [[ -f etc/additional.sh ]] && wget https://raw.githubusercontent.com/blanckth/blanckarm/main/etc/additional.sh -P etc/;
mv additional.sh "$folder/root/";
! [[ -f etc/resolv.conf ]] && wget https://raw.githubusercontent.com/blanckth/blanckarm/main/etc/resolv.conf -P etc/;
mv etc/resolv.conf "$folder/root/";
! [[ -f vnc/xfce_de.sh ]] && wget https://raw.githubusercontent.com/blanckth/blanckarm/main/vnc/xfce_de.sh -P etc/;
mv etc/xfce_de.sh "$folder/root/";
! [[ -d "$folder/proc/" ]] && mkdir -p "$folder/proc/";
! [[ -d "$folder/proc/fake/" ]] && mkdir -p "$folder/proc/fake/";
# Copy Fake Things
! [[ -f fake/stat ]] && wget https://raw.githubusercontent.com/blanckth/blanckarm/main/fake/stat -O fake/stat;
! [[ -f fake/vmstat ]] && wget https://raw.githubusercontent.com/blanckth/blanckarm/main/fake/vmstat -O fake/vmstat;
! [[ -f fake/version ]] && wget https://raw.githubusercontent.com/blanckth/blanckarm/main/fake/version -O fake/version;
mv fake/stat "$folder/proc/fake/";
mv fake/vmstat "$folder/proc/fake/";
mv fake/version "$folder/proc/fake/";
mv "$folder/root/.bash_profile" "$folder/root/.bash_profile.bak";
! [[ -f etc/bash_profile ]] && wget https://raw.githubusercontent.com/blanckth/blanckarm/main/etc/bash_profile -O etc/bash_profile;
mv etc/bash_profile "$folder/root/.bash_profile";
echo "You can now launch Arch Linux with the start-blanckarm script"
start-blanckarm;
