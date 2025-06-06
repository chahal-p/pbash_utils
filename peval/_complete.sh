#!/usr/bin/env bash

complete -W "-c --confirmation -v --verbose --serialized_args" peval
complete -W "--lock_id --timeout" peval.with_lock