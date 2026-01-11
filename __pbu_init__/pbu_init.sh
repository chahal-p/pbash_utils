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

pbu.quiet_source _pbu.completes.sh

function pbu.python.venv-activate() {
  test -d ~/.python-venv || { echo 'Creating new venv'; pbu.python -m venv ~/.python-venv;}
  source ~/.python-venv/bin/activate
}

source <(pbu.persistent_source.print_sourceable)