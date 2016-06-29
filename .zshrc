ZSH=$HOME/.oh-my-zsh/

ZSH_THEME="robbyrussell"
CASE_SENSITIVE=true
ENABLE_CORRECTION=true
COMPLETION_WAITING_DOTS=true

plugins=(git)

source $ZSH/oh-my-zsh.sh

# user settings
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export USER_NAME="Tieme van Veen"
export SSH_KEY_PATH=$HOME/.ssh/dsa_id

export APPEND_HISTORY=true
export HISTFILE=$HOME/Dotfiles/.zshrc_history
export HISTSIZE=10000;
export HISTFILESIZE=10000;
export HISTCONTROL="ignoreboth"; # Omit duplicates and commands that begin with a space from history.
unsetopt inc_append_history
unsetopt share_history

# Prefer US English and use UTF-8.
export LANG="en_US.UTF-8";
export LC_ALL="en_US.UTF-8";

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

source $HOME/Dotfiles/aliases.sh