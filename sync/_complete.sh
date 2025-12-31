#!/usr/bin/env bash
function _complete_pbu.lock() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "-f --file -t --timeout" -- "$cur") )
}
complete -F _complete_pbu.lock pbu.lock
