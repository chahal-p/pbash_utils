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

pbu.quiet_source pbash-args.sh

source pbu_complete.sh

pbu.quiet_source pbu.conversion.sh
pbu.quiet_source pbu.docker.sh
pbu.quiet_source pbu.exec-bash-script.sh
pbu.quiet_source pbu.python-scripts.sh

function python-venv-activate() {
  test -d ~/.python-venv || { echo 'Creating new venv'; pbu.python -m venv ~/.python-venv;}
  source ~/.python-venv/bin/activate
}
