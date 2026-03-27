#!/bin/bash

inotifywait -m -q -e modify /sys/class/backlight/intel_backlight/brightness |
while read -r; do
  ./brightness_pct.sh
done
