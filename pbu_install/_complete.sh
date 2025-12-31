#!/usr/bin/env bash
function _complete_pbu.install() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "--name --content --file --quiet" -- "$cur") )
}
complete -F _complete_pbu.install pbu.install

function _complete_pbu.uninstall() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "--name" -- "$cur") )
}
complete -F _complete_pbu.uninstall pbu.uninstall
