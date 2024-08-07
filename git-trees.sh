#!/bin/bash

# Git tree
#
# Copyright (c) 2021 Tieme van Veen
# https://github.com/teameh/Dotfiles

printHelp() {
    echo "fzf powered git worktree helper

usage: git-tree (switch)               Switches directory
   or: git-tree add (-c | -C)          Creates a new git worktree
   or: git-tree remove (-d | -D)       Removes a git worktree
"
}

# TODO: find out how to add autocomplete for bash / zsh..

git-tree() {
    if ! which fzf-tmux >/dev/null; then
        echo "Error: fzf is not installed, run 'brew install fzf' to install."
        echo "See https://github.com/junegunn/fzf\n"
        printHelp
        return 1
    elif [ -z "$1" ] || [ "$1" = "switch" ] || [ "$1" = "-s" ]; then
        local root worktrees branches selection
        root=$(git worktree list | head -1 | awk '{print $1}') &&
        worktrees=$(basename $(git worktree list | head -1 | awk '{print $1}'))-worktrees &&
        branches=$(git worktree list) &&
        selection=$(echo "$branches" | fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
        cd $(echo "$selection" | head -1 | awk '{print $1}');
    elif [ "$1" = "add" ] || [ "$1" = "-c" ] || [ "$1" = "-C" ]; then
        local root worktrees remote allbranches branches branch newPath
        root=$(git worktree list | head -1 | awk '{print $1}') &&
        worktrees=$(basename $(git worktree list | head -1 | awk '{print $1}'))-worktrees &&
        remote=$(git remote show) &&
        allbranches=$(git branch -la --sort=-committerdate --format="%(refname:short)") &&
        branches=$(echo "$allbranches" | sed "s/$remote\///g" | awk '! seen[$0]++') &&
        branch=$(echo "$branches" | fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
        directory=$(sed "s/[^a-zA-Z0-9]//g" <<< $(openssl rand -base64 10)) &&
        newPath=$(echo "$root/../$worktrees/$directory") &&
        git worktree add $newPath $branch &&
        cd $newPath
    elif [ "$1" = "remove" ] || [ "$1" = "-d" ] || [ "$1" = "-D" ]; then
        local root worktrees branches selection
        root=$(git worktree list | head -1 | awk '{print $1}') &&
        worktrees=$(basename $(git worktree list | head -1 | awk '{print $1}'))-worktrees &&
        branches=$(git worktree list) &&
        selection=$(echo "$branches" | fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
        git worktree remove $(echo "$selection" | head -1 | awk '{print $1}') $2;
    else
        printHelp
    fi
}
