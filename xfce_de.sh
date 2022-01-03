#!/usr/bin/env bash
## Automatic Installation BlanckArm on Termux android
## Authur Salar Muhammadi
#####################################################
echo "Installing XFCE Desktop";
pacman -S xorg xorg-server --noconfirm;
pacman -S xfce4 xfce4-goodies --noconfirm;
pacman -S tigervnc --noconfirm;
pacman -S tar sed --noconfirm;
! [[ -f /usr/local/bin/vncserver-start ]] && wget https://raw.githubusercontent.com/blanckth/blanckarm/main/vncserver-start -P /usr/local/bin/;
! [[ -f /usr/local/bin/vncserver-stop ]] && wget https://raw.githubusercontent.com/blanckth/blanckarm/main/vncserver-stop -P /usr/local/bin/;
chmod +x /usr/local/bin/vncserver-stop;
chmod +x /usr/local/bin/vncserver-start;
echo 'export DISPLAY="localhost:0"' >> /etc/profile;
source /etc/profile;
vncserver-start;
vncserver-stop;
! [[ -f ~/xstartup ]] && wget https://raw.githubusercontent.com/blanckth/blanckarm/main/xstartup -P ~/xstartup;
mv ~/xstartup ~/.vnc/xstartup;
chmod +x ~/.vnc/xstartup;
