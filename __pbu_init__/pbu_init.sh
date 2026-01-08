#!/usr/bin/env bash

function pbu.pathadd() {
  [[ ":$PATH:" == *":$1:"* ]] || export PATH="$1:$PATH"
}

function pbu.reload-bashrc() {
  source ~/.bashrc
}
alias reload-bashrc='pbu.reload-bashrc'

function pbu.quiet_source() {
  which "$1" > /dev/null || return 1
  source "$1"
}

function ___error_echo() {
  echo -e "\e[01;31m${@}\e[0m"
}

pbu.quiet_source pbash-args.sh

pbu.quiet_source pbu.docker.sh
pbu.quiet_source pbu.exec-bash-script.sh
pbu.quiet_source pbu.python-scripts.sh

function pbu.python.venv-activate() {
  test -d ~/.python-venv || { echo 'Creating new venv'; pbu.python -m venv ~/.python-venv;}
  source ~/.python-venv/bin/activate
}

source <(pbu.persistent_source.print_sourceable)