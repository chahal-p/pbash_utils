#!/usr/bin/env zsh

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

pbu.pathadd "${HOME}/.local/bin"

if [ -f "$HOME/.zshrc" ]
then
  function pbu.reload-zshrc() {
    source "$HOME/.zshrc"
  }
  alias reload-zshrc='pbu.reload-zshrc'
fi

function pbu.quiet_source() {
  which "$1" > /dev/null || return 1
  source "$1"
}

function pbu.python.venv-activate() {
  test -d ~/.python-venv || { echo 'Creating new venv'; pbu.python -m venv ~/.python-venv;}
  source ~/.python-venv/bin/activate
}

source <(pbu.persistent_source.print_sourceable --shell_type zsh)