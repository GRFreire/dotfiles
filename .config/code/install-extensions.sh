#!/bin/sh

cat extensions-list.txt | xargs -L 1 code --install-extension

