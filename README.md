
# AROS development container #

**WORK IN PROGRESS. USE AT OWN RISK**


This repository provides what is necessary to build a Docker container for AROS development.
The container provides /home/aros as a volume, so that you can optionally expose it from the host
or from another container.

My preference is to expose it from the host, and if you use the companion script to set up
the source repository, and to start the container, then by default it will expose /opt/volumes/aros
on the host as /home/aros in the container.

## Preparation ##

 1. ./downloadaros will download AROS v1 (core, contrib and ports) with git, and then give you
 the option of setting up the git repository to work with svn. This step will only be taken
 if the target directory does not already exist.
 

FIXME: systemd setup
FIXME: Alternative: Daemonize under Docker

FIXME: What about Wanderer?

## FIXME: AROS config ##

## Running ssh ##

FIXME: Setting up ssh-keys

## Running XPRA ##

FIXME: Simplify: Specify a default port in the script

 * Start ssh

 * SSH in, cd to right directory:
   xpra start :100 --start-child='cd '`pwd`' && boot/linux/AROSBootstrap'
   
 * On host: docker ps to obtain port for ssh daemon

 * On client machine:
   xpra attach --ssh='ssh -p [port] -l aros' ssh:[ip of host]:100


## Running VNC ##

 * Start ssh
 
 * SSH in, cd to right directory.
 * vncserver -geometry 1850x1016 [1850x1016 gives "perfect match" for the VNC client "gtkvncviewer" on
   Ubuntu w/Unity on a 1920x1080 display. You may want to adjust depending on your setup)
 * DISPLAY=:1 boot/linux/AROSBootstrap
 * Adjust screen modes to your preference.

