#!/bin/sh

cd "${0%/*}" || exit

./brightness-watcher.sh | xob -s brightness
