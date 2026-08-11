#!/usr/bin/env bash
# Prints the current pane's git branch, colored by clean/dirty state,
# for use in tmux status-right via #(...)

dir="$1"
cd "$dir" 2>/dev/null || exit 0

branch=$(git symbolic-ref --quiet --short HEAD 2>/dev/null)
if [[ -z "$branch" ]]; then
    branch=$(git rev-parse --short HEAD 2>/dev/null) || exit 0
    branch="detached@${branch}"
fi

if [[ -n "$(git status --porcelain 2>/dev/null)" ]]; then
    color="#D47766"
    marker="*"
else
    color="#85B695"
    marker=""
fi

echo "#[fg=${color}] ${branch}${marker}"
