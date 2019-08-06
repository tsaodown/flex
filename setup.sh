#!/bin/bash

die() {
  if [[ ! -z "$*" ]]; then echo "$*" 1>&2; fi
  printf "\e[91m$(cat /tmp/flex-setup)\e[0m\n"
  rm /tmp/flex-setup
  exit 1
}
checked() {
  printf "\e[1;92m$1\e[0m\n"
  eval "${*:2}" > /tmp/flex-setup 2>&1 || die
  rm /tmp/flex-setup > /dev/null 2>&1
}

checked 'Cloning flex tool...' git clone git@github.com:tsaodown/flex.git /usr/local/share/flex
cwd=$(pwd)
cd /usr/local/share/flex/setup_scripts
for s in *.sh; do
  checked "Running $s..." /bin/bash "$s" -H || break
done
cd $cwd
