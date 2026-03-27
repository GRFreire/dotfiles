#!/bin/sh

max=$(cat /sys/class/backlight/intel_backlight/max_brightness)
curr=$(cat /sys/class/backlight/intel_backlight/brightness)

echo "$curr*100/$max" | bc
