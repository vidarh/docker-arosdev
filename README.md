
# AROS development container #

**WORK IN PROGRESS. USE AT OWN RISK**


This repository provides what is necessary to build a Docker container for AROS development.
The container provides /home/aros as a volume, so that you can optionally expose it from the host
or from another container.

My preference is to expose it from the host, and if you use the companion script to set up
the source repository, and to start the container, then by default it will expose /opt/volumes/aros
on the host as /home/aros in the container.

## Preparation ##

 * Create an /opt/volumes/aros directory.
 * Copy bin to /opt/volumes/aros/bin
 * Start the container with ./run-arosdev and download/build an AROS version using
   * "aros download"
   * "aros config"
   * "aros build"
 
(These are extracted from gimmearos.sh by Matthias Rust which is also available unchanged in
bin)

 * Optionally symlink the root directory of the build of your preference to /home/aros/AROS in
   the container. This is used if you run ./run-arosdev-vnc
   
NOTE: The example invocations in run-arosdev-* use one-off containers that are wiped when killed.
However anything mounted in a volume from the host persists, so in other words: make all your changes
in /home/aros (in the container) or /opt/volumes/aros (on the host). If you want to make your
changes persist elsewhere, you need to change the Dockerfile and rebuild.


FIXME: systemd setup
FIXME: Alternative: Daemonize under Docker


## FIXME: AROS config ##

## Running ssh ##

The Dockerfile sets up an 'aros' user. If you run the container with sshd (see run-arosdev-ssh as an
example), you may want to add your ssh public-key to /opt/volumes/aros/.ssh/authorized_keys on the
host, which will be mapped to /home/aros/.ssh/authorized_keys


## Running VNC ##

 * Start ssh
 
 * SSH in, cd to right directory.
 * vncserver -geometry 1850x1016 [1850x1016 gives "perfect match" for the VNC client "gtkvncviewer" on
   Ubuntu w/Unity on a 1920x1080 display. You may want to adjust depending on your setup)
 * DISPLAY=:1 boot/linux/AROSBootstrap
 * Adjust screen modes to your preference.

