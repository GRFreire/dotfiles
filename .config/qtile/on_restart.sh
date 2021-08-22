#!/bin/sh

# Restart picom so qtile bar does not get round corners
killall picom ; sleep 1 && picom --experimental-backends &