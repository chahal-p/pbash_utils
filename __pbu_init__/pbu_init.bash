#!/usr/bin/env bash

if [[ "${BASH_VERSINFO[0]}" -lt 5 ]]
then
  echo 'bash version 5 or higher is required for pbash_utils'
  return
fi

IFS=' ' read -r _ python_version <<< $(python3 -V)
IFS='.' read -r python_version_major python_version_minor python_version_patch <<< $python_version

if [[ "${python_version_major}" -lt 3 || ("${python_version_major}" -eq 3 && "${python_version_minor}" -lt 11) ]]
then
  echo 'python version 3.11 or higher is required for pbash_utils'
  return
fi

function pbu.pathadd() {
  [[ ":$PATH:" == *":$1:"* ]] || export PATH="$1:$PATH"
}

if [ -f "$HOME/.bashrc" ]
then
  function pbu.reload-bashrc() {
    source "$HOME/.bashrc"
  }
  alias reload-bashrc='pbu.reload-bashrc'
fi

function pbu.quiet_source() {
  which "$1" > /dev/null || return 1
  source "$1"
}

pbu.quiet_source _pbu.completes.bash

function pbu.python.venv-activate() {
  test -d ~/.python-venv || { echo 'Creating new venv'; pbu.python -m venv ~/.python-venv;}
  source ~/.python-venv/bin/activate
}

source <(pbu.persistent_source.print_sourceable)