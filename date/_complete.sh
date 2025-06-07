#!/usr/bin/env bash

complete -W "--out-utc --nanoseconds --microseconds --milliseconds --seconds" date-from-epoch
complete -W "--date --out-nanoseconds --out-microseconds --out-milliseconds --out-seconds" date-to-epoch
complete -W "add subtract --date --nanoseconds --microseconds --milliseconds --seconds --minutes --hours --days --out-utc" pbu.date.add_sub
complete -W "--date --nanoseconds --microseconds --milliseconds --seconds --minutes --hours --days --out-utc" date-add
complete -W "--date --nanoseconds --microseconds --milliseconds --seconds --minutes --hours --days --out-utc" date-subtract
