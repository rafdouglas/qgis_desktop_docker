[![Image info](https://images.microbadger.com/badges/image/rafdouglas/qgis_desktop.svg)](https://hub.docker.com/r/rafdouglas/qgis_desktop "Click to view the image on Docker Hub")
[![Docker pulls](https://img.shields.io/docker/pulls/rafdouglas/qgis_desktop.svg)](https://hub.docker.com/r/rafdouglas/qgis_desktop "Click to view the image on Docker Hub")

# QGIS 3.4 Desktop running on Docker

A full-fledge QGIS 3.4 running on Docker.

Everything supported in the standard QGIS 3.4 is ready out of the box: 3D views, Google Maps/Sat/Terrain integration, OSM, plugins etc.
Preferences are retained across sessions, and the integration with your physical computer is seamless.

**Automated build on Docker Hub for maximum reliability.**

![qgis_desktop_docker screenshot](https://raw.githubusercontent.com/rafdouglas/qgis_desktop_docker/3.4/docs/qgis_desktop_docker_3.4.jpg)


## Installation And Usage

This is the easiest and fastest way, since it downloads the image from DockerHub, you don't need to compile anything on your computer.

    git clone https://github.com/rafdouglas/qgis_desktop_docker.git
    cd qgis_desktop_docker
    sh qgis_run.sh

    #after the container is running (i.e. with the full GUI), you can optionally use the Command Line:
    sh qgis_cli.sh

### Build your own

If you instead feel like customizing something, you can build the image locally:

    git clone https://github.com/rafdouglas/qgis_desktop_docker.git
    cd qgis_desktop_docker
    #(Edit the Dockerfile or what you need)
    . ./build
    
    sh qgis_run.sh 

### Notes

There are three exposed directories:
1. `/mnt/ext_home/` is mapped to your home directory (i.e. "~") 
2. `/root/qgis34-files` is the working files directory and is mapped to your computer's `~/qgis34-files`
3. `/root/.local` (the profile/preferences directory) maps to your computer's `~/.qgis34-docker`. This allows to retain preferences, histroy, etc across different sessions.

### Troubleshooting

Since the X11-unix is mapped directly (by the qgis_run.sh script), there should be no need to run the insecure `xhost +` command.
However, should you get errors accessing the display, consider running:

    xhost +

- - -
Brought to you by: 

:sparkles: RafDouglas C. Tommasi C. -  2019  
:sparkles: http://rafdouglas.science  

- - -
Released as GNU General Public License v3.0 - 2019

