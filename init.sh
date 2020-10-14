#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2020 Chua Hou
#
# Installs everything for the first time.

set -e

# log files
readonly LOG_FILE="./setup_nonsudo.log"
readonly ERR_FILE="./setup_nonsudo.err"
touch $LOG_FILE
touch $ERR_FILE
exec 1> >(tee -a "$LOG_FILE")
exec 2> >(tee -a "$ERR_FILE")

# use Windows clock system
timedatectl set-local-rtc 1 --adjust-system-clock

# TODO: dotfiles

# install prerequisite package
# this depends on, and will trigger the install of, the dependencies needed to
# build everything else
sudo apt-get install ./prereq.deb -y

# install kiwami debian packages
make -C debian

# install kiwami-mgr packages
kiwami-mgr init

# install snaps
snap install spotify
snap install --classic heroku
