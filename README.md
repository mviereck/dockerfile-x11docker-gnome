# x11docker/gnome
Gnome 3 desktop. Experimental.

 - Run Gnome 3 desktop in docker. 
 - Use [x11docker on github](https://github.com/mviereck/x11docker) to run GUI applications and desktop environments in docker containers.

# Command examples: 
 - Full desktop: `x11docker --desktop --gpu --init=systemd -- x11docker/gnome`
 - Single application: `x11docker x11docker/gnome nautilus`

# Options:
 - Persistent home folder stored on host with   `--home`
 - Shared host folder with                      `--sharedir DIR`
 - Hardware acceleration with option            `--gpu`
 - Clipboard sharing with option                `--clipboard`
 - Sound support with option                    `--alsa`
 - With pulseaudio in image, sound support with `--pulseaudio`
 - Language setting with                        `--lang=$LANG`
 - Printing over CUPS with                      `--printer`
 - Webcam support with                          `--webcam`


# Experimental image. Known issues:
 - gnome-session terminates after some minutes, catched with a supervisor script. gnome-shell continues.
 - gnome-control-center hangs for a while at some entries.
 - gnome-usage crashes with a segfault.
 - Wayland setups do not work.
 - Logout does not work, use "Logout x11docker" in application menu instead.

See `x11docker --help` for further options.

 # Screenshot
![screenshot](https://raw.githubusercontent.com/mviereck/x11docker/screenshots/screenshot-gnome.png "Gnome 3 desktop")
