#!/usr/bin/env bash

function error_echo() {
  echo -e "\e[01;31m${@}\e[0m"
}

default_install_input=(
"aliases"
"arrays"
"checks"
"copy"
"date"
"docker"
"errors"
"exec-bash-script"
"input"
"numbers"
"openssl"
"peval"
"pinstall"
"ssh"
"ptmux"
"python"
"strings"
"utils"
"vars"
)

install_input=()

parsed=$(pflags parse --name "$(basename "$0")" ---- -l install -t string -h 'Utils which needs to be installed, use "all" as value to install all' -r ---- "$@") || exit $?
pflags printhelp $parsed && exit

install_input+=( "$(pflags get -n install "$parsed")" )
[[ "${#install_input[@]}" == "0" || "${install_input[0]}" == "" ]] && { error_echo "Non-empty --install argument is required."; exit 1; }
[ "${#install_input[@]}" == "1" ] && [ "${install_input[0]}" == "all" ] && install_input+=( "${default_install_input[@]}" )

install=( __pbu_init__ )

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
    bash pinstall/pinstall --file "$p" || exit
  done
  [ -f "$HOME/.local/bin/pbu_complete.sh" ] && [ -f "./$x/_complete.sh" ] && cat ./$x/_complete.sh | grep -v ^#.*$ >> "$HOME/.local/bin/pbu_complete.sh"
done
