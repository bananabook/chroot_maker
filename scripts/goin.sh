# the actual chroot command to change root into the directory we prepared
# it is the only command, that needs administrator permissions
chroot ./fake_root /bin/bash
