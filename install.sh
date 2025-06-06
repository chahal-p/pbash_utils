#!/usr/bin/env bash
err=0
PARSED_OPTIONS=$(getopt -o "" -l "install:" -- "$@" || err=$?)
[ "$err" == "0" ] || exit $err

eval set -- "$PARSED_OPTIONS"

default_install_input=(
"aliases"
"arrays"
"checks"
"date"
"errors"
"input"
"numbers"
"peval"
"pinstall"
"pssh"
"ptmux"
"python"
"strings"
"utils"
"vars"
)

install_input=()

while true; do
  case "$1" in
    --install)
      install_input+=( "$2" )
      shift 2
      ;;
    --)
      shift
      break
      ;;
    *)
      echo "Unexpected option: $1" >&2
      exit 1
      ;;
  esac
done

[ "${#install_input[@]}" == "0" ] && install_input+=( "${default_install_input[@]}" )
[ "${#install_input[@]}" == "1" ] && [ "${install_input[0]}" == "all" ] && install_input+=( "${default_install_input[@]}" )

install=()

while (( ${#install_input[@]} ))
do
  i="${install_input[0]}"
  install_input=( "${install_input[@]:1}" )
  [[ ${install[@]} =~ "$i" ]] && continue
  install+=( "$i" )
  [ -f "$i/dependencies.txt" ] || continue
  install_input+=( $(cat "$i/dependencies.txt" | xargs) )
done

for x in "${install[@]}"
do
  for f in "./$x"/*
  do
    [ "$f" == "./$x/*" ] && continue
    p="$(realpath "$f")"
    bn="$(basename "$p")"
    [[ "$bn" == "dependencies.txt" || "$bn" == "_complete.sh" ]] && continue
    bash pinstall/pinstall "$p" || exit
  done
done
