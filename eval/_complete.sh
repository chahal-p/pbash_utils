#!/usr/bin/env bash
function _complete_pbu.eval() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "-c --confirmation -v --verbose --serialized_args" -- "$cur") )
}
complete -F _complete_pbu.eval pbu.eval

function _complete_pbu.eval.with_lock() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "--lock_id --timeout" -- "$cur") )
}
complete -F _complete_pbu.eval.with_lock pbu.eval.with_lock
