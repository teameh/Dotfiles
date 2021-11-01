DOTFILES=$HOME/Developer/Repos/Dotfiles/
TERMINAL_FILES=$HOME/Developer/Repos/Terminal/

ZSH_THEME=agnoster
UPDATE_ZSH_DAYS=60
CASE_SENSITIVE=true
ENABLE_CORRECTION=false
COMPLETION_WAITING_DOTS=true
DISABLE_UNTRACKED_FILES_DIRTY=true
plugins=(
  git
  # bundler
  # dotenv
  osx
  # zsh-autosuggestions
  # zsh-syntax-highlighting
  # rake
  # rbenv
  # ruby
)


# Setup oh my zsh
source $TERMINAL_FILES/oh-my-zsh/oh-my-zsh.sh

# iTerm integration
source $TERMINAL_FILES/.iterm2_shell_integration.zsh

# Setup fzf
export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"

# source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null
# source "/usr/local/opt/fzf/shell/key-bindings.zsh" 2> /dev/null


# Aliasses
source $DOTFILES/aliases.sh
source $DOTFILES/git-trees

export USER_NAME="Tieme"
export SSH_KEY_PATH=$HOME/.ssh/dsa_id
export APPEND_HISTORY=true
export HISTFILE=$DOTFILES/.zshrc_history
export HISTSIZE=5000;
export HISTFILESIZE=5000;
export HISTCONTROL="ignoreboth"; # Omit duplicates and commands that begin with a space from history.
DEFAULT_USER="$(whoami)"

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
