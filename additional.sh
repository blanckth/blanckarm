#!/usr/bin/env bash
## Automatic Installation BlanckArm on Termux android
## Authur Salar Muhammadi
#####################################################
systemctl disable systemd-resolved.service;
rm /etc/resolv.conf;
mv resolv.conf /etc;
pacman-key --init;
echo "disablescdaemon" > /etc/pacman.d/gnupg/gpg-agent.conf;
pacman-key --populate archlinuxarm;
chmod 755 /bin /home /mnt /run /srv /tmp /var /boot /etc /opt /root /sbin /sys /usr;
LC_ALL=C.UTF-8;
pacman -Syyuu --needed --noconfirm;
pacman -S --needed wget sudo --noconfirm;
#####################################################
