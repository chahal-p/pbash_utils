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

echo '#!/usr/bin/env bash' > /tmp/_pbu.completes.sh

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
    cat ./$x/_complete.sh | grep -v ^#.*$ >> /tmp/_pbu.completes.sh
  }
done
bash pbu_install/pbu.install --file /tmp/_pbu.completes.sh || exit
exit 0
