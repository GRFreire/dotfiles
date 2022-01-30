#!/bin/sh

cat .config/code/extensions-list.txt | xargs -L 1 code --install-extension

