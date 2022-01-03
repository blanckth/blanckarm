#!/usr/bin/env bash
pacman -S --needed tar wget sed --noconfirm
pacman -U https://raw.githubusercontent.com/blanckth/blanckarm/main/vnc/tigervnc-1.10.1-1-aarch64.pkg.tar.xz --noconfirm
curl -s https://raw.githubusercontent.com/blanckth/blanckarm/main/vnc/lib.tar.xz -o /usr/lib/a.tar.xz && tar xf /usr/lib/a.tar.xz -C /usr/lib
sed -i '27i IgnorePkg = tigervnc' /etc/pacman.conf
