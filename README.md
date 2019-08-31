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

See `x11docker --help` for further options.

 # Screenshot
![screenshot](https://raw.githubusercontent.com/mviereck/x11docker/screenshots/screenshot-gnome.png "Gnome 3 desktop")
