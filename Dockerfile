# x11docker/gnome
# 
# Run Gnome 3 desktop in docker. 
# Use x11docker to run image: 
#   https://github.com/mviereck/x11docker 
#
# Examples: 
#  - Run desktop:
#      x11docker --desktop --gpu --init=systemd -- x11docker/gnome
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

FROM ubuntu:20.04

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
      libpulse0 \
      procps \
      psutils \
      systemd \
      x11-xserver-utils && \
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
      gnome-shell-extension-dash-to-panel \
      gnome-shell-extension-desktop-icons \
      gnome-shell-extension-weather

CMD gnome-session
