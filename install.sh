#!/usr/bin/env bash

function error_echo() {
  echo -e "\e[01;31m${@}\e[0m"
}

install=(
"__pbu_init__"
"arrays"
"checks"
"conversion"
"copy"
"date"
"errors"
"eval"
"exec-bash-script"
"input"
"install_alias"
"persistent_kv"
"numbers"
"openssl"
"pbu_install"
"ssh"
"sync"
"persistent_source"
"python"
"strings"
"tmux"
"utils"
"vars"
"__exported_aliases__"
)

for x in "${install[@]}"
do
  for f in "./$x"/*
  do
    [ "$f" == "./$x/*" ] && continue
    p="$(realpath "$f")"
    bn="$(basename "$p")"
    [[ "$bn" == "_complete.sh" ]] && continue
    bash pbu_install/pbu.install --file "$p" || exit
  done
  [ -f "./$x/_complete.sh" ] && {
    cat ./$x/_complete.sh | grep -v ^#.*$ | bash persistent_source/pbu.persistent_source.add --name "_pbu_complete_$x" --file - || exit
  }
done
exit 0
