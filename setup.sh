#!/bin/bash

git clone git@github.com:tsaodown/flex.git /usr/local/share/flex
cwd=$(pwd)
cd /usr/local/share/flex/setup_scripts
for s in *.sh; do
  /bin/bash "$f" -H || break
done
cd $cwd
