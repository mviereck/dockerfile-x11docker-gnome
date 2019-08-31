# x11docker/gnome
# 
# Run Gnome 3 desktop in docker. 
# Use x11docker to run image: 
#   https://github.com/mviereck/x11docker 
#
# Experimental image with remaining issues:
#  - gnome-session terminates after some minutes, catched with a supervisor script. gnome-shell continues.
#  - gnome-control-center hangs for a while at some entries.
#  - gnome-usage crashes with a segfault.
#  - Wayland setups do not work.
#  - Logout does not work, use "Logout x11docker" in application menu instead.
#
# Examples: 
#  - Run desktop:
#      x11docker --desktop --gpu --init=systemd -- x11docker/gnome
#  - Run single application:
#      x11docker x11docker/gnome gedit
#
# Options:
# Persistent home folder stored on host with   --home
# Shared host file or folder with              --share PATH
# Hardware acceleration with option            --gpu
# Clipboard sharing with option                --clipboard
# ALSA sound support with option               --alsa
# Pulseaudio sound support with option         --pulseaudio
# Language locale setting with option          --lang [=$LANG]
# Printer support over CUPS with option        --printer
# Webcam support with option                   --webcam
#
# See x11docker --help for further options.

FROM debian:buster

ENV LANG en_US.UTF-8

RUN apt-get update && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      locales && \
      echo "$LANG UTF-8" >> /etc/locale.gen && \
      locale-gen && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y \
      at-spi2-core \
      dbus \
      dbus-x11 \
      procps \
      psutils \
      systemd && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      gnome-session && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      cheese \
      gedit \
      gnome-control-center \
      gnome-terminal \
      gnome-tweak-tool \
      nautilus && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      gnome-shell-extensions \
      gnome-shell-extension-dashtodock \
      gnome-shell-extension-dash-to-panel \
      gnome-shell-extension-desktop-icons \
      gnome-shell-extension-top-icons-plus \
      gnome-shell-extension-weather \
      gnome-shell-extension-workspaces-to-dock

# generate 3 files:
#  - Logout script
#  - Logout application menu entry
#  - start script to run and watch gnome-session, watch gnome-shell afterwards

RUN echo "#! /bin/bash \n\
echo timesaygoodbye >> /x11docker/timetosaygoodbye \n\
" >/usr/local/bin/logout && \
chmod +x /usr/local/bin/logout && \
\
echo "[Desktop Entry]\n\
Version=1.0\n\
Type=Application\n\
Name=Logout x11docker\n\
Exec=/usr/local/bin/logout\n\
Icon=system-log-out\n\
" > /usr/share/applications/x11docker-logout.desktop && \
\
echo "#! /bin/bash \n\
echo \"x11docker/gnome: This image is experimental and not considered stable.\" >&2 \n\
gnome-session \"\$@\" & \n\
wait \$! \n\
shellpid=\$(ps aux | grep '/usr/bin/gnome-shell' | grep -v grep | head -n1 | awk '{print \$2}') \n\
echo \"x11docker/gnome: gnome-session has terminated. Watching pid \$shellpid of gnome-shell.\" >&2 \n\
while sleep 1; do \n\
  ps -p \$shellpid >/dev/null 2>&1 || break \n\
done \n\
" >/usr/local/bin/start && \
chmod +x /usr/local/bin/start

CMD /usr/local/bin/start
