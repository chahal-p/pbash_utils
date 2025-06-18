#!/usr/bin/env bash

function reload-bashrc() {
  source ~/.bashrc
}

function pbu.quiet_source() {
  which "$1" > /dev/null || return 1
  source "$1"
}

function ___error_echo() {
  echo -e "\e[01;31m${@}\e[0m"
}

source pbu_complete.sh

pbu.quiet_source conversion.sh
pbu.quiet_source docker.sh
pbu.quiet_source exec-bash-script.sh
pbu.quiet_source python.sh
