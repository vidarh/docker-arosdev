# -*- sh -*-
FROM debian:wheezy
MAINTAINER vidar@hokstad.com

RUN apt-get update

# These pre-requisites come largely from the excellent "gimmearos.sh" script
# by Matthias Rustler

RUN apt-get -y install subversion git-core gcc g++ make gawk bison flex bzip2 netpbm
RUN apt-get -y install autoconf automake libx11-dev libxext-dev libc6-dev liblzo2-dev
RUN apt-get -y install libxxf86vm-dev libpng12-dev gcc-multilib libsdl1.2-dev byacc

# Pre-requisite for downloading crosstools etc.
RUN apt-get -y install wget

# Required for contrib (OWB etc.)
RUN apt-get -y install cmake gperf

# Additional packages that might come in handy
RUN apt-get -y install gdb strace

# For 32-bit on 64-bit compatibility.

RUN dpkg --add-architecture i386
RUN apt-get update && apt-get -y install  libc6-dev ia32-libs


## ---- Locale

RUN apt-get -y install debconf debconf-utils
ADD locale-selections /tmp/
RUN debconf-set-selections </tmp/locale-selections
RUN apt-get install -y locales localization-config
RUN rm /etc/locale.gen && dpkg-reconfigure locales


## ---- VNC server 

RUN apt-get -y install vnc4server

## ---- XPRA support (xpra.org)

#ADD winswitch-gpg.asc /tmp/
#RUN apt-key add /tmp/winswitch-gpg.asc
#ADD winswitch.list /etc/apt/sources.list.d/
#RUN apt-get update
#RUN apt-get -y install xpra


## ----- SSH Server

RUN apt-get -y install openssh-server
RUN mkdir -p /var/run/sshd

# FIXME: This really ought to be run on first boot.
RUN /usr/bin/ssh-keygen -A

## ------ "aros-*" helper commands
ADD bin/ /usr/local/bin/



## ------- Set up a suitable user
RUN useradd aros -u 1000 -s /bin/bash --no-create-home

WORKDIR /home/aros/
ENV HOME /home/aros
USER aros


## ------- Volumes

# Make it easy to grant access to this.
VOLUME ["/home/aros","/root"]

## ------- Ports

# We expose ssh, because if we want to use xpra to export
# the AROS display over the network, that happens via SSH.
EXPOSE 22

# In case we want to use VNC
EXPOSE 5901
EXPOSE 5801
