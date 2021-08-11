#!/bin/sh

#     ____ ____  _____         _          
#    / ___|  _ \|  ___| __ ___(_)_ __ ___ 
#   | |  _| |_) | |_ | '__/ _ \ | '__/ _ \     Guilherme Rugai Freire
#   | |_| |  _ <|  _|| | |  __/ | | |  __/     https://grfreire.com
#    \____|_| \_\_|  |_|  \___|_|_|  \___|     https://github.com/GRFreire
#                                         

. "$HOME/.id.profile"

### Default programs ###
export EDITOR="nvim"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export TERMINAL="alacritty"
export BROWSER="firefox"

### PATH exports ###
# $1 = path to export
try_export_path() {
  if [ -d "$1" ] ;
    then export PATH="$1:$PATH"
  fi
}

try_export_path $HOME/.bin

try_export_path $HOME/.local/bin

try_export_path $HOME/.yarn/bin

try_export_path $HOME/.cargo/bin

# Android Studio
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:~/android-studio/bin

# SPICETIFY (SPOTIFY)
export SPICETIFY_INSTALL="$HOME/spicetify-cli"
export PATH="$SPICETIFY_INSTALL:$PATH"

# Use custom mono path (C#)
export FrameworkPathOverride=/etc/mono/4.5

# Path for cuda
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/cuda/lib64

