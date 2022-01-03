#!/usr/bin/env bash
## Automatic Installation BlanckArm on Termux android
## Authur Salar Muhammadi
#####################################################
echo "Installing XFCE Desktop";
pacman -S --needed xorg xorg-server --noconfirm;
pacman -S --needed xfce4 xfce4-goodies --noconfirm;
pacman -S --needed tigervnc --noconfirm;
pacman -S --needed tar sed --noconfirm;
! [[ -d ~/.vnc ]] && mkdir ~/.vnc;
! [[ -f /usr/local/bin/vncserver-start ]] && wget https://raw.githubusercontent.com/blanckth/blanckarm/main/vnc/vncserver-start -P /usr/local/bin/;
! [[ -f /usr/local/bin/vncserver-stop ]] && wget https://raw.githubusercontent.com/blanckth/blanckarm/main/vnc/vncserver-stop -P /usr/local/bin/;
chmod +x /usr/local/bin/vncserver-stop;
chmod +x /usr/local/bin/vncserver-start;
echo 'export DISPLAY="localhost:0"' >> /etc/profile;
source /etc/profile;
vncserver-start;
vncserver-stop;
! [[ -f ~/xstartup ]] && wget https://raw.githubusercontent.com/blanckth/blanckarm/main/vnc/xstartup -O ~/xstartup;
mv ~/xstartup ~/.vnc/;
chmod +x ~/.vnc/xstartup;
wget https://raw.githubusercontent.com/blanckth/blanckarm/main/vnc/vncfix.sh -O ~/vncfix.sh && chmod +x ~/vncfix.sh && bash ~/vncfix.sh;
vncserver-stop;
vncserver-start;
