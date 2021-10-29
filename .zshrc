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
