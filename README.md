# Chroot Maker
This is a bash script, that is making it easy to create a chrootable directory where the binaries and the libraries for those binaries are included. The user only needs to include the name of the binary in the 'wishlist' file and call `make`.

# TLDR
put the binaries you want in your chroot in the wishlist and call `make`. You are put in a chroot, which is located in the directory 'fake_root'. You can leave by typing `exit` or pressing Ctrl-D.

# Why does this exists
When trying to create a usable chroot directory you need to copy over all the binaries you want to use. But not only that you also need to check for the libraries, those binaries need and place them in the chroot at the location that is expected by the binary. If you wanted to call `ls` in the chroot, that would mean copying the binary:
```sh
mkdir fake_root/bin -p
copy $(which ls) fake_root/bin
```
seeing what libraries the binary needs:
```sh
ldd $(which ls)
```
identifying from the output where those libraries are and placing them in the fake_root in their respective directories.

For this example, that would mean for instance creating the directories:
```sh
mkdir -p ./fake_root/lib/x86_64-linux-gnu
mkdir ./fake_root/lib64
```

and copying the libraries there:
```sh
cp /lib/x86_64-linux-gnu/libselinux.so.1 ./fake_root/lib/x86_64-linux-gnu/
cp /lib/x86_64-linux-gnu/libc.so.6 ./fake_root/lib/x86_64-linux-gnu/
...
```
and finally you could call the binary from chroot.
```sh
sudo chroot ./fake_root /bin/ls
```

This becomes very tedious very quickly and this script here attempts to steamline the process by finding and copying the libraries and binaries needed. All from just a provided wishlist.

# Prerequisits
The script only deals with the binaries on your system. If you want a binary to be usable in your chroot it needs to be already usable in your system.

# Make commands
make:
	if make is called with no attribute the fake_root is emptied. The new fake_root is created and entered.

make create:
	add the binaries and their required libraries to the fake_root.

make goin:
	call the chroot command. This requests root permissions via sudo

make uncreate:
	empty the fake_root directory

# Formating of wishlist
The wishlist file formating needs to follow these rules:
• binary names need to be seperated by spaces or tabs, or a newline
• empty lines are allowed (but ignored)
• lines, that have no text before the first sign and this sign is a '#' are discared as comments
• tabs and other indentation can be used
the provided wishlist file tries to communicate what kind of formating id allowed

# Anticipated Problems
The create script automatically handles filenames, it was accounted for potential 'weirdness' in those filenames. Special characters in the filename can potentiall throw the script off.
