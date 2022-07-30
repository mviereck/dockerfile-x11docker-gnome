# x11docker/gnome
# 
# Run Gnome 3 desktop in docker. 
# Use x11docker to run image: 
#   https://github.com/mviereck/x11docker 
#
# Examples: 
#  - Run desktop:
#      x11docker --desktop --init=systemd -- x11docker/gnome
#  - Run single application:
#      x11docker x11docker/gnome gedit
#
# Options:
#   Persistent home folder stored on host with   --home
#   Shared host file or folder with              --share PATH
#   Hardware acceleration with option            --gpu
#   Clipboard sharing with option                --clipboard
#   ALSA sound support with option               --alsa
#   Pulseaudio sound support with option         --pulseaudio
#   Language locale setting with option          --lang [=$LANG]
#   Printer support over CUPS with option        --printer
#   Webcam support with option                   --webcam
#
# See x11docker --help for further options.
#
# Known issues:
#  - Many shell extensions do not work properly.
#  - gnome-control-center hangs for a while at some entries.
#  - gnome-usage crashes with a segfault.
#  - Wayland setups do not work.

FROM debian:bullseye
ENV LANG en_US.UTF-8
ENV SHELL=/bin/bash

# cleanup script for use after apt-get
RUN echo '#! /bin/sh\n\
env DEBIAN_FRONTEND=noninteractive apt-get autoremove -y\n\
apt-get clean\n\
find /var/lib/apt/lists -type f -delete\n\
find /var/cache -type f -delete\n\
find /var/log -type f -delete\n\
exit 0\n\
' > /cleanup && chmod +x /cleanup

# basics
RUN apt-get update && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      locales && \
      echo "$LANG UTF-8" >> /etc/locale.gen && \
      locale-gen && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y \
      at-spi2-core \
      dbus \
      dbus-x11 \
      libpulse0 \
      procps \
      psutils \
      systemd \
      x11-xserver-utils && \
    /cleanup

# Gnome 3
RUN apt-get update && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      gnome-session && \
    /cleanup

# Gnome 3 apps
RUN apt-get update && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      cheese \
      gedit \
      gnome-control-center \
      gnome-system-monitor \
      gnome-terminal \
      gnome-tweak-tool \
      nautilus && \
    /cleanup

# Gnome Shell extensions
RUN apt-get update && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      gnome-shell-extension* && \
    /cleanup

CMD gnome-shell
