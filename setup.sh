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

checked 'Installing git...' sudo apt-get install -y git
checked 'Create shared installation directory...' sudo mkdir -p /srv/flex
checked 'Setup permission...' sudo chmod 777 /srv/flex
checked 'Cloning flex tool...' git clone https://github.com/tsaodown/flex.git /srv/flex/repo
cwd=$(pwd)
cd /srv/flex/repo/setup_scripts
for s in *.sh; do
  checked "Running $s..." /bin/bash "$s" -H || break
done
cd $cwd
