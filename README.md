# NAME

docker-ocr - Docker Image for OCR

# VERSION

Version 0.0.1

# LICENCE AND COPYRIGHT

Copyright (c) 2019 Matthias Nott (mnott (at) mnsoft.org).

Licensed under WTFPL.


# INTRODUCTION

            This docker file gives a working environment for
            ocr. You need to have a valid ABBYY CLI license.

# SYNOPSIS

## INSTALLATION

### PREREQUISITES

Running the docker image is very easy. You typically need
to install only two things:

1\. Install \[Git\](https://git-scm.com/download)

2\. Install \[Docker for Mac\] (https://docs.docker.com/docker-for-mac/install/), or
   Install \[Docker for Win\] (https://docs.docker.com/docker-for-windows/install/)

Note: On Linux, use your distribution's preferred way to install
docker. For the subsequent commands, also install docker-compose,
which is, for example, a separate package on Ubuntu.

Very important: If you are working on a Windows system, make sure
to configure Git, when it installs, to \*not automatically\* convert
Line Ends ("CR/LF"). Shouly you have configured it wrongly, you can
do this on the command line:

    git config --global core.autocrlf false

Then, before continuing, make sure that you have switched on
Virtualization in your BIOS (the feature is often under either
Configuration or Security, and is often called Intel Virtualization
Technology and VT-d Feature: Enable both). If you fail to do this,
the image may not start up.


### DOCKER IMAGE

Finally, you open a command line, e.g. on your Desktop, and do this:

    git clone https://github.com/mnott/docker-ocr
    cd docker-ocr


## CONFIGURATION

Look into the docker-compose.yaml. There you see a directory mapping:

    - ~/Cloud/02 - Ablegen:/data/Ablage/Ablegen

The first part, in front of the colon, is a local directory on your
computer that will typically contain the PDFs that you want to run
the OCR on. Change that part to match your situation, and leave the
part after the colon untouched.

## BUILD

From the directory that contains docker-compose.yaml, run

    docker-compose build

The process will typically take about 5 minutes.

## RUN

From the same directory that contains docker-compose.yaml, run

    ./run.sh

For MacOS users, there is also a

    OCR.app
    
that you can run.