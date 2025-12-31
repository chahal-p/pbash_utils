#!/usr/bin/env bash

function _complete_pbu.vars.create() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "--var" -- "$cur") )
}
complete -F _complete_pbu.vars.create pbu.vars.create

function _complete_pbu.vars.delete() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "--var" -- "$cur") )
}
complete -F _complete_pbu.vars.delete pbu.vars.delete
