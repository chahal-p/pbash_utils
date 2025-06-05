#!/usr/bin/env bash

PARSED_OPTIONS=$(getopt -o "" -l "install:,user,system" -- "$@")

eval set -- "$PARSED_OPTIONS"

install_input=(
"aliases"
"arrays"
"checks"
"date"
"errors"
"input"
"numbers"
"peval"
"python"
"strings"
"utils"
"vars"
)

while true; do
  case "$1" in
    --user)
      install_user=true
      shift
      ;;
    --system)
      install_system=true
      shift
      ;;
    --install)
      install_input="$2"
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

[[ $install_user == true && $install_system == true ]] && { echo "Either --uesr or --system should be provided."; exit 1; }

installation_type=$1
installation_path=""
[ "$install_system" == true ] && installation_path="/usr/local/bin/"
[ "$install_user" == true ] && installation_path="$HOME/.local/bin/"
if [ "$install_user" == true ] && [ ! -d $HOME/.local/bin ]
then
  mkdir -p $HOME/.local/bin
fi
if [ -z "$installation_path" ]
then
  echo "Installation type is not provided. Either --user or --system argument is required."
  exit 1
fi

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
    [ -f "$p" ] && echo "Installing: $bn" && cp "$p" "${installation_path}${bn}" && chmod +x "${installation_path}${bn}" || { echo "Installation failed"; exit 1; }
  done
done