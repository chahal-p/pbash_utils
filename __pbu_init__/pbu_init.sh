#!/usr/bin/env bash

function pathadd() {
  [[ ":$PATH:" == *":$1:"* ]] || export PATH="$1:$PATH"
}

function reload-bashrc() {
  source ~/.bashrc
}

function pbu.quiet_source() {
  which "$1" > /dev/null || return 1
  source "$1"
}

function ___error_echo() {
  echo -e "\e[01;31m${@}\e[0m"
}

function update-pbash-utils() {
  [ -d "/tmp/.pbash_utils" ] || git clone https://github.com//chahal-p/pbash_utils.git /tmp/.pbash_utils
  pushd /tmp/.pbash_utils > /dev/null
  git checkout .
  git pull
  chmod +x ./install.sh
  ./install.sh --install all
  popd > /dev/null
}

pbu.quiet_source pbash-args.sh

source pbu_complete.sh

pbu.quiet_source conversion.sh
pbu.quiet_source docker.sh
pbu.quiet_source exec-bash-script.sh
pbu.quiet_source python-scripts.sh

function python-venv-activate() {
  test -d ~/.python-venv || { echo 'Creating new venv'; pbu.py -m venv ~/.python-venv;}
  source ~/.python-venv/bin/activate
}
