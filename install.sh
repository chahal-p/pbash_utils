#!/usr/bin/env bash

if [[ "${BASH_VERSINFO[0]}" -lt 5 ]]
then
  echo 'bash version 5 or higher is required for pbash_utils'
  return
fi

IFS=' ' read -r _ python_version <<< $(python3 -V)
IFS='.' read -r python_version_major python_version_minor python_version_patch <<< $python_version

if [[ "${python_version_major}" -lt 3 || ("${python_version_major}" -eq 3 && "${python_version_minor}" -lt 11) ]]
then
  echo 'python version 3.11 or higher is required for pbash_utils'
  return
fi

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

echo '#!/usr/bin/env bash' > /tmp/_pbu.completes.bash

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
    cat ./$x/_complete.sh | grep -v ^#.*$ >> /tmp/_pbu.completes.bash
  }
done
bash pbu_install/pbu.install --file /tmp/_pbu.completes.bash || exit
exit 0
