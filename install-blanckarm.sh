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
		exec proot --link2symlink -0 tar -xf "$cur/$tarball"||:
		cd "$cur";
	fi;
fi;
! [[ -f "$PREFIX/bin/start-blanckarm" ]] && touch "$PREFIX/bin/start-blanckarm";
! [[ -f start-blanckarm.sh ]] && wget https://raw.githubusercontent.com/blanckth/blanckarm/main/start-blanckarm.sh;
mv start-blanckarm.sh "$PREFIX/bin/start-blanckarm";
chmod +x "$PREFIX/bin/start-blanckarm";
! [[ -f additional.sh ]] && wget https://raw.githubusercontent.com/blanckth/blanckarm/main/additional.sh;
mv additional.sh "$folder/root/additional.sh";
! [[ -f resolv.conf ]] && wget https://raw.githubusercontent.com/blanckth/blanckarm/main/resolv.conf;
mv resolv.conf "$folder/root/resolv.conf";
! [[ -f xfce_de.sh ]] && wget https://raw.githubusercontent.com/blanckth/blanckarm/main/xfce_de.sh;
mv xfce_de.sh "$folder/root/xfce_de.sh";
! [[ -d "$folder/proc" ]] && mkdir "$folder/proc";
! [[ -d "$folder/proc/fake" ]] && mkdir "$folder/proc/fake";
# Copy Fake Things
! [[ -f stat ]] && wget https://raw.githubusercontent.com/blanckth/blanckarm/main/stat;
! [[ -f vmstat ]] && wget https://raw.githubusercontent.com/blanckth/blanckarm/main/vmstat;
! [[ -f version ]] && wget https://raw.githubusercontent.com/blanckth/blanckarm/main/version;
mv stat "$folder/proc/fake/stat";
mv vmstat "$folder/proc/fake/vmstat";
mv version "$folder/proc/fake/version";
mv "$folder/root/.bash_profile" "$folder/root/.bash_profile.bak";
! [[ -f bash_profile ]] && wget https://raw.githubusercontent.com/blanckth/blanckarm/main/bash_profile;
mv bash_profile "$folder/root/.bash_profile";
echo "You can now launch Arch Linux with the start-blanckarm script"
start-blanckarm;
