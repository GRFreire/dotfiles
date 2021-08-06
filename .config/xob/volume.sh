#!/bin/sh

cd "${0%/*}" || exit

WATCHER=pulse-volume-watcher.py ./base.sh volume 
