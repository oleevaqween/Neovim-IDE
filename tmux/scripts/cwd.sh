#!/usr/bin/env bash
# Prints the current pane's working directory, shortened, for tmux status-right

dir="$1"
dir="${dir/#$HOME/\~}"

max=40
if [[ ${#dir} -gt $max ]]; then
    dir="…${dir: -$((max - 1))}"
fi

echo "#[fg=#CF9BC2] ${dir}"
