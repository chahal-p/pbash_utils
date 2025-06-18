#!/usr/bin/env bash

complete -W "-s --short -l --long -d --default-value -o --out-values-var -r --remaining-args-var --help" pbash.args.extract
function pbash.args.extract() {


  local usage="
pbash.args.extract parse args and update the value of arg in a local varible name provided in -o/--out-values-var.

Example:
  arg1_val=""
  pbash.args.extract -l arg1: -o arg1_val -- --arg1 abc
  echo \$arg1_val  # abc will be printed (Value of arg1 will be updated in arg1_val.)

  force_val=""
  pbash.args.extract -l force -o force_val -- --force=false
  echo \$force_val #  false will be printed for a bool argument
  pbash.args.extract -l force -o force_val -- --force
  echo \$force_val #  true will be printed for a bool argument

FLAGS:
  {FLAGS}"

  local _____SPLITED_ARGS1_____=()
  local _____SPLITED_ARGS2_____=()
  ___pbash_split_args_by_double_hyphen___ "$@" || return $PBASH_ARGS_ERROR_USAGE
  local ____internal_args____=( "${_____SPLITED_ARGS1_____[@]}" )
  local ____external_args____=( "${_____SPLITED_ARGS2_____[@]}" )

  __parsedpflags__=$(pflags parse --usage "$usage" \
    ---- --short "s" --long "short" --type string --default "" \
      -- --short "l" --long "long" --type string --default "" \
      -- --short "d" --long "default" --type string  \
      -- --short "o" --long "out-values-var" --type string --required --default "" \
      -- --short "r" --long "remaining-args-var" --type string --default "" \
    ---- "${____internal_args____[@]}") || { local err=$?; [ "$err" == "$PBASH_ARGS_ERROR_USAGE_HELP_REQUESTED" ] && echo "$__parsedpflags__"; return $err; }
  
  local args=()

  ____short____=$(pflags get -n short "$__parsedpflags__") || return $?
  args+=( -s "${____short____%:}" )
  ____long____=$(pflags get -n long "$__parsedpflags__") || return $?
  args+=( -l "${____long____%:}" )

  local ____type____
  local type_from_short=""
  local type_from_long=""

  [ -z "$____short____" ] || { [[ "$____short____" =~ .*: ]] && { type_from_short="string"; } || type_from_short="bool"; }
  [ -z "$____long____" ] || { [[ "$____long____" =~ .*: ]] && { type_from_long="string"; } || type_from_long="bool"; }
  [ -z "$____short____" ] || [ -z "$____long____" ] || [ "$type_from_short" == "$type_from_long" ] || { echo "Both short and long should be of same type"; return 1; }
  [ -z "$____short____" ] || ____type____="$type_from_short"
  [ -z "$____long____" ] || ____type____="$type_from_long"

  args+=( -t "$____type____" )

  ____default____=$(pflags get -n default "$__parsedpflags__" 2> /dev/null) && args+=( --default "$____default____" )
  ____out____=$(pflags get -n out-values-var "$__parsedpflags__") || return $?
  ____remaining____=$(pflags get -n remaining-args-var "$__parsedpflags__") || return $?

  local ____flag_name____=""

  [ -z "$____short____" ] || ____flag_name____="${____short____%:}"
  [ -z "$____long____" ] || ____flag_name____="${____long____%:}"

  __parsedpflags__=$(pflags parse ---- "${args[@]}" ---- "${____external_args____[@]}") || return $?
  values=$(pflags get -n "$____flag_name____" "$__parsedpflags__") || return $?
  local -n out_values="$____out____"
  readarray -t out_values <<< "${values}"
  [ ! -z "$____remaining____" ] && local -n out_remaining_args="$____remaining____" && readarray -t out_remaining_args <<< "$(pflags unparsed "$__parsedpflags__")"
}

complete -W "--args1 --args2" pbash.args.split_with_double_hyphen
function pbash.args.split_with_double_hyphen() {
  local _____SPLITED_ARGS1_____=()
  local _____SPLITED_ARGS2_____=()
  ___pbash_split_args_by_double_hyphen___ "$@" || return $PBASH_ARGS_ERROR_USAGE
  local _____internal_args_____=( "${_____SPLITED_ARGS1_____[@]}" )
  local _____external_args_____=( "${_____SPLITED_ARGS2_____[@]}" )

  local _____args1_____
  local _____args2_____
  pbash.args.extract -l args1: -o _____args1_____ -- "${_____internal_args_____[@]}" || { pbash.args.errors.echo "--args1 is required"; return $PBASH_ARGS_ERROR_USAGE; }
  pbash.args.extract -l args2: -o _____args2_____ -- "${_____internal_args_____[@]}" || { pbash.args.errors.echo "--args2 is required"; return $PBASH_ARGS_ERROR_USAGE; }
  _____SPLITED_ARGS1_____=()
  _____SPLITED_ARGS2_____=()
  ___pbash_split_args_by_double_hyphen___ "${_____external_args_____[@]}" || return $PBASH_ARGS_ERROR_USAGE
  local -n _____args1_ref_____="$_____args1_____"
  local -n _____args2_ref_____="$_____args2_____"
  _____args1_ref_____=( "${_____SPLITED_ARGS1_____[@]}" )
  _____args2_ref_____=( "${_____SPLITED_ARGS2_____[@]}" )
}

complete -W "-s --short -l --long -o --out-values-var" pbash.args.delete
function pbash.args.delete() {
  local _____SPLITED_ARGS1_____=()
  local _____SPLITED_ARGS2_____=()
  ___pbash_split_args_by_double_hyphen___ "$@" || return $PBASH_ARGS_ERROR_USAGE
  local internal_args=( "${_____SPLITED_ARGS1_____[@]}" )
  local external_args=( "${_____SPLITED_ARGS2_____[@]}" )

  local pbash_args_delete_out_values_var_name=()
  pbash.args.extract -s 'o:' -l 'out-values-var:' -o pbash_args_delete_out_values_var_name -- "${internal_args[@]}"
  local err=$?
  pbash.args.errors.is_not_found_error $err && pbash.args.errors.echo "-o/--out-values-var is required arg"
  pbash.args.errors.is_error $err && return $err

  pbash.args.extract -r $pbash_args_delete_out_values_var_name "${internal_args[@]}" -- "${external_args[@]}"
  local err=$?
  pbash.args.errors.is_not_found_error $err || return $err
  return 0
}

complete -W "-s --short -l --long -r --remaining-args-var" pbash.args.is_switch_arg_enabled
function pbash.args.is_switch_arg_enabled() {
  local _____SPLITED_ARGS1_____=()
  local _____SPLITED_ARGS2_____=()
  ___pbash_split_args_by_double_hyphen___ "$@" || return $PBASH_ARGS_ERROR_USAGE
  local internal_args=( "${_____SPLITED_ARGS1_____[@]}" )
  local external_args=( "${_____SPLITED_ARGS2_____[@]}" )

  local pbash_args_is_switch_arg_enabled_remaining_args=()
  pbash.args.delete -s d -l default-value -o pbash_args_is_switch_arg_enabled_remaining_args -- "${internal_args[@]}"
  internal_args=( "${pbash_args_is_switch_arg_enabled_remaining_args[@]}" )
  internal_args+=( -d false )

  local pbash_args_is_switch_arg_enabled_short_args=()
  pbash.args.extract -s "s:" -l "short:" -o pbash_args_is_switch_arg_enabled_short_args -- "${internal_args[@]}"

  local pbash_args_is_switch_arg_enabled_long_args=()
  pbash.args.extract -s "l:" -l "long:" -o pbash_args_is_switch_arg_enabled_long_args -- "${internal_args[@]}"

  local all_args=()
  all_args+=( "${pbash_args_is_switch_arg_enabled_short_args[@]}" )
  all_args+=( "${pbash_args_is_switch_arg_enabled_long_args[@]}" )

  local k
  for k in "${all_args[@]}"
  do
    [[ ! "$k" =~ .*:$ ]] || pbash.args.errors.echo "pbash.args.is_switch_arg_enabled can't take value args." || return $PBASH_ARGS_ERROR_USAGE
  done

  local pbash_args_is_switch_arg_enabled_value=()
  pbash.args.extract -o pbash_args_is_switch_arg_enabled_value "${internal_args[@]}" -- "${external_args[@]}"
  local err=$?

  pbash.args.errors.is_success $err || return $err

  [ "$pbash_args_is_switch_arg_enabled_value" == "false" ] && return 1
  [ "$pbash_args_is_switch_arg_enabled_value" == "true" ] && return 0
  return 1
}

complete -W "-s --short -l --long " pbash.args.any_switch_arg_enabled
function pbash.args.any_switch_arg_enabled() {
  local _____SPLITED_ARGS1_____=()
  local _____SPLITED_ARGS2_____=()
  ___pbash_split_args_by_double_hyphen___ "$@" || return $PBASH_ARGS_ERROR_USAGE
  local internal_args=( "${_____SPLITED_ARGS1_____[@]}" )
  local external_args=( "${_____SPLITED_ARGS2_____[@]}" )

  local pbash_args_any_switch_arg_enabled_remaining_args=()
  pbash.args.delete -s d -l default-value -o pbash_args_any_switch_arg_enabled_remaining_args -- "${internal_args[@]}"
  internal_args=( "${pbash_args_any_switch_arg_enabled_remaining_args[@]}" )
  internal_args+=( -d false )
  
  # declaring to avoid modifying variable from parent function.
  local remaining_args=()

  local pbash_args_any_switch_arg_enabled_short_args=()
  pbash.args.extract -s "s:" -l "short:" -o pbash_args_any_switch_arg_enabled_short_args -- "${internal_args[@]}"

  local pbash_args_any_switch_arg_enabled_long_args=()
  pbash.args.extract -s "l:" -l "long:" -o pbash_args_any_switch_arg_enabled_long_args -- "${internal_args[@]}"

  local k
  for k in "${pbash_args_any_switch_arg_enabled_short_args[@]}"
  do
    pbash.args.is_switch_arg_enabled -s "$k" -- "${external_args[@]}" && return 0
  done
  
  for k in "${pbash_args_any_switch_arg_enabled_long_args[@]}"
  do
    pbash.args.is_switch_arg_enabled -l "$k" -- "${external_args[@]}" && return 0
  done
  return 1
}

complete -W "-s --short -l --long" pbash.args.atleast_one_arg_present
function pbash.args.atleast_one_arg_present() {
  local _____SPLITED_ARGS1_____=()
  local _____SPLITED_ARGS2_____=()
  ___pbash_split_args_by_double_hyphen___ "$@" || return $PBASH_ARGS_ERROR_USAGE
  local internal_args=( "${_____SPLITED_ARGS1_____[@]}" )
  local external_args=( "${_____SPLITED_ARGS2_____[@]}" )

  local short_args=()
  pbash.args.extract -s 's:' -l 'short:' -o short_args -- "${internal_args[@]}"
  local err=$?
  pbash.args.errors.is_success $err || pbash.args.errors.is_not_found_error $err || return $err

  local long_args=()
  pbash.args.extract -s 'l:' -l 'long:' -o long_args -- "${internal_args[@]}"
  local err=$?
  pbash.args.errors.is_success $err || pbash.args.errors.is_not_found_error $err || return $err

  local k
  for k in "${short_args[@]}"
  do
    pbash.args.extract -s "$k" -- "${external_args[@]}"
    err=$?
    pbash.args.errors.is_success $err && return $PBASH_ARGS_SUCCESS
    pbash.args.errors.is_not_found_error $err || return $err
  done

  for k in "${long_args[@]}"
  do
    pbash.args.extract -l "$k" -- "${external_args[@]}"
    err=$?
    pbash.args.errors.is_success $err && return $PBASH_ARGS_SUCCESS
    pbash.args.errors.is_not_found_error $err || return $err
  done
  return $PBASH_ARGS_ERROR
}

complete -W "-s --short -l --long" pbash.args.all_args_present
function pbash.args.all_args_present() {
  local _____SPLITED_ARGS1_____=()
  local _____SPLITED_ARGS2_____=()
    ___pbash_split_args_by_double_hyphen___ "$@" || return $PBASH_ARGS_ERROR_USAGE
  local internal_args=( "${_____SPLITED_ARGS1_____[@]}" )
  local external_args=( "${_____SPLITED_ARGS2_____[@]}" )

  local short_args=()
  pbash.args.extract -s 's:' -l 'short:' -o short_args -- "${internal_args[@]}"
  local err=$?
  pbash.args.errors.is_success $err || pbash.args.errors.is_not_found_error $err || return $err

  local long_args=()
  pbash.args.extract -s 'l:' -l 'long:' -o long_args -- "${internal_args[@]}"
  local err=$?
  pbash.args.errors.is_success $err || pbash.args.errors.is_not_found_error $err || return $err

  local k
  for k in "${short_args[@]}"
  do
    pbash.args.extract -s "$k" -- "${external_args[@]}"
    err=$?
    pbash.args.errors.is_success $err || return $err
  done

  for k in "${long_args[@]}"
  do
    pbash.args.extract -l "$k" -- "${external_args[@]}"
    err=$?
    pbash.args.errors.is_success $err || return $err
  done

  return $PBASH_ARGS_SUCCESS
}

#============================================================================
PBASH_ARGS_SUCCESS=0
PBASH_ARGS_ERROR=1
PBASH_ARGS_ERROR_USAGE=2
PBASH_ARGS_ERROR_INVALID_VALUE=4
PBASH_ARGS_ERROR_NOT_FOUND=40
PBASH_ARGS_ERROR_INTERNAL=99
PBASH_ARGS_ERROR_USAGE_HELP_REQUESTED=100

function pbash.args.errors.get_error_code() {
  local err="$?"
  [ "$1" == "" ] || err="$1"
  printf "%s" "$err"
}

function pbash.args.errors.echo() {
  local err="$?"
  echo -e "\e[01;31m${@}\e[0m"
  return $err
}

function pbash.args.errors.is_not_found_error() {
  local err="$(pbash.args.errors.get_error_code "$@")"
  [ "$err" == "$PBASH_ARGS_ERROR_NOT_FOUND" ] || return $PBASH_ARGS_ERROR
  return $PBASH_ARGS_SUCCESS
}

function pbash.args.errors.is_error() {
  local err="$(pbash.args.errors.get_error_code "$@")"
  [ "$err" != "$PBASH_ARGS_SUCCESS" ] || return $PBASH_ARGS_ERROR
  return $PBASH_ARGS_SUCCESS
}

function pbash.args.errors.is_success() {
  pbash.args.errors.is_error "$@" || return $PBASH_ARGS_SUCCESS
  return $PBASH_ARGS_ERROR
}


#============================================================================
# Below functions should be used in this file only.

function ___pbash_split_args_by_double_hyphen___() {
  local -n args1='_____SPLITED_ARGS1_____'
  local -n args2='_____SPLITED_ARGS2_____'

  args1=()
  args2=()

  local found_split=0

  while [ $# -gt 0 ]
  do
    if [ "$1" == "--" ]
    then
      found_split=1
      shift
      break
    fi
    args1+=( "$1" )
    shift
  done
  if [ $found_split == 0 ]
  then
    return
  fi
  args2=( "${@}" )
}
