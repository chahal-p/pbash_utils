#!/usr/bin/env bash

function _complete_pbu.date.from-epoch() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "--out-utc --nanoseconds --microseconds --milliseconds --seconds" -- "$cur") )
}
complete -F _complete_pbu.date.from-epoch pbu.date.from-epoch

function _complete_pbu.date.to-epoch() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "--date --out-nanoseconds --out-microseconds --out-milliseconds --out-seconds" -- "$cur") )
}
complete -F _complete_pbu.date.to-epoch pbu.date.to-epoch

function _complete_pbu.date.add_sub() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "add subtract --date --nanoseconds --microseconds --milliseconds --seconds --minutes --hours --days --out-utc" -- "$cur") )
}
complete -F _complete_pbu.date.add_sub pbu.date.add_sub

function _complete_pbu.date.add() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "--date --nanoseconds --microseconds --milliseconds --seconds --minutes --hours --days --out-utc" -- "$cur") )
}
complete -F _complete_pbu.date.add pbu.date.add

function _complete_pbu.date.subtract() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "--date --nanoseconds --microseconds --milliseconds --seconds --minutes --hours --days --out-utc" -- "$cur") )
}
complete -F _complete_pbu.date.subtract pbu.date.subtract
