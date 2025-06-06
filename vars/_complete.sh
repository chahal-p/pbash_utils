#!/usr/bin/env bash

complete -W "--setter_prefix --getter_prefix --var" vars.create
complete -W "--setter_prefix --getter_prefix --var" vars.delete