DOTFILES=$HOME/Developer/Repos/Dotfiles/
TERMINAL_FILES=$HOME/Developer/Repos/Terminal/

ZSH_THEME=agnoster
CASE_SENSITIVE=true
ENABLE_CORRECTION=false
COMPLETION_WAITING_DOTS=true
plugins=(git)

# Setup oh my zsh
source $TERMINAL_FILES/oh-my-zsh/oh-my-zsh.sh

# iTerm integration
source $TERMINAL_FILES/.iterm2_shell_integration.zsh

# Setup fzf
export PATH="${PATH:+${PATH}:}${TERMINAL_FILES}/fzf/bin"
source $TERMINAL_FILES/fzf/shell/completion.zsh 2> /dev/null
source $TERMINAL_FILES/fzf/shell/key-bindings.zsh 2> /dev/null

# Aliasses
source $DOTFILES/aliases.sh


# # export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.rvm/bin:$HOME/.yarn/bin"

export USER_NAME="Tieme"
export SSH_KEY_PATH=$HOME/.ssh/dsa_id
export APPEND_HISTORY=true
export HISTFILE=$DOTFILES/.zshrc_history
export HISTSIZE=10000;
export HISTFILESIZE=10000;
export HISTCONTROL="ignoreboth"; # Omit duplicates and commands that begin with a space from history.
DEFAULT_USER="Tieme"
unsetopt inc_append_history
unsetopt share_history

# Prefer US English and use UTF-8.
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US.UTF-8


# Highlight section titles in manual pages.
export LESS_TERMCAP_md="${yellow}";

# Don’t clear the screen after quitting a manual page.
export MANPAGER="less -X";

# Always enable colored `grep` output.
export GREP_OPTIONS="--color=auto";

# Editor
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="nano"
else
  export EDITOR="subl -w"
fi


# Fixing typos
# eval $(thefuck --alias)

###### More git goodies functions

# Interactive git log
hist() {
  git log --graph --abbrev-commit --decorate --all --date=local --color=always \
    --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%ad%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%n''' "$@" \
    | fzf --ansi --no-sort --reverse --tiebreak=index --preview "echo {} \
        | grep -o '[a-f0-9]\{7\}' \
        | head -1 \
        | xargs -I % sh -c 'git show --stat --color=always %; git show --color=always %'" \
            --bind "ctrl-y:execute-silent(echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | pbcopy)+abort" \
            --bind "enter:execute:
                  (grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I % sh -c 'git show --color=always % | less -R') \
                  < <(printf '\n%s\n' {})" \
}

histbr() {
  git log --graph --abbrev-commit --decorate --date=local --color=always \
    --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%ad%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%n''' "$@" \
    | fzf --ansi --no-sort --reverse --tiebreak=index --preview "echo {} \
        | grep -o '[a-f0-9]\{7\}' \
        | head -1 \
        | xargs -I % sh -c 'git show --stat --color=always %; git show --color=always %'" \
            --bind "ctrl-y:execute-silent(echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | pbcopy)+abort" \
            --bind "enter:execute:
                  (grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I % sh -c 'git show --color=always % | less -R') \
                  < <(printf '\n%s\n' {})" \
}

# fco_preview - checkout git branch/tag, with a preview showing the commits between the tag/branch and HEAD
fco() {
  local tags branches target
  branches=$(
    git --no-pager branch --all \
      --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" \
    | sed '/^$/d') || return
  tags=$(
    git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}') || return
  target=$(
    (echo "$branches"; echo "$tags") |
    fzf --height=60% --no-hscroll --no-multi -n 2 \
        --ansi --preview="git log '..{2}' --color=always --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%ad%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%n''' --date=local") || return
  git checkout $(awk '{print $2}' <<<"$target" )
}

# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
fbr() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

