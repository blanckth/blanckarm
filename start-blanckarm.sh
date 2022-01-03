#!/usr/bin/env bash
# Automatic Start of Blanck Arm Arch
# Authur : Salar Muhammadi
#
unset LD_PRELOAD
declare rootfs="$HOME/arch-fs";
command="proot";
command+=" --link2symlink";
command+=" --sysvipc";
command+=" --kill-on-exit";
command+=" -0";
command+=" -r $rootfs";
command+=" -b /dev";
command+=" -b /proc";
command+=" -b /sys";
command+=" -b /data";
command+=" -b arch-fs/root:/dev/shm";
command+=" -b /proc/self/fd/2:/dev/stderr";
command+=" -b /proc/self/fd/1:/dev/stdout";
command+=" -b /proc/self/fd/0:/dev/stdin";
command+=" -b /dev/urandom:/dev/random";
command+=" -b /proc/self/fd:/dev/fd";
command+=" -b ${folder}/proc/fake/stat:/proc/stat";
command+=" -b ${folder}/proc/fake/vmstat:/proc/vmstat";
command+=" -b ${folder}/proc/fake/version:/proc/version";
# command+=" -b $HOME:/root";
command+=" -w /root";
command+=" /usr/bin/env -i";
command+=" MOZ_FAKE_NO_SANDBOX=1";
command+=" HOME=/root";
command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games";
command+=" TERM=\$TERM";
command+=" LANG=C.UTF-8";
command+=" --login";
exec \$command;
###########################################################################################################
