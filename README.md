# bootc-device-demo

This repository contains example scripts for trying out deploying bootc to bare metal for your own home projects.  It assumes you have:

* a linux laptop (commands are for Fedora variants)
* podman and bootc already installed on the laptop
* small x86-based device (could be adapted to ARM) which you're prepared to erase and reinstall
* a dedicated, configurable network connection between them

Note that the network setup is to allow you to experiment with custom images without requiring uploads to a public internet container registry, primarily to allow for conference demos.  If you don't have that restriction, just use Quay instead and you can dispense with the dedicated network connection.

# Files in this repo

* config.toml: an example ISO-building configuration file to be used with bootc-image-builder
* CONTAINERFILE: a bootable container definition for a simple httpd server OS
* index.html: the static web page for the demo OS.  Put anything you want in this.
* sample_podman_commands.sh: file containing various podman commands for building and running the images and services you need
* registry.sh: sample shell and podman commands for running a local container registry to supply images for the demo system

# The presentation

Try flipping through the presentation slides, which will give you an idea of the progress of the demo.  Once the video is available, I'll link it here.

# license

All materials in this repo, unless specifically otherwise noted in the file, are licensed Apache 2.0.  Copyright Josh Berkus and Red Hat LLC, 2026.
