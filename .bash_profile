source ~/Settings/.bash_prompt
source ~/Settings/.git-completion.sh
source ~/Settings/.git-prompt.sh

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;
# Append to the Bash history file, rather than overwriting it
shopt -s histappend;
# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# path
export PATH="$PATH:$HOME/local/node/bin";
export PATH="$PATH:/usr/local/bin";
export PATH="$PATH:/usr/local/sbin";
export PATH="$PATH:$HOME/bin";
export PATH="$PATH:$HOME/Settings";

# histfile
export HISTFILE=~/Settings/.bash_history

# Make sublime the default editor.
export EDITOR='subl -w'

# Increase Bash history size. Allow 32³ entries; the default is 500.
export HISTSIZE='1000';
export HISTFILESIZE="${HISTSIZE}";

# Omit duplicates and commands that begin with a space from history.
export HISTCONTROL='ignoreboth';

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8';
export LC_ALL='en_US.UTF-8';

# Highlight section titles in manual pages.
export LESS_TERMCAP_md="${yellow}";

# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X';

# Always enable colored `grep` output.
export GREP_OPTIONS='--color=auto';

# Homebrew -> fill in your token
export HOMEBREW_GITHUB_API_TOKEN=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

## Custom Aliasses!
alias restart-memcached="launchctl unload $HOME/Library/LaunchAgents/homebrew.mxcl.memcached.plist; launchctl load $HOME/Library/LaunchAgents/homebrew.mxcl.memcached.plist"
alias restart-apache='sudo apachectl restart'

# Delete all 'gone' 'merged' branches
alias git-cleanup-branches="git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -d"

## Cleanup XCODE
alias purgexcodebuilds='rm -rf ~/library/Developer/Xcode/DerivedData/*'

## OSX
alias delete-extended-attributes='xattr -c'

## Other's Aliasses!
alias ls="pwd; ls -al"

# Get week number
alias week='date +%V'

# Get OS X Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update'

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Flush Directory Service cache
alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"

# Clean up LaunchServices to remove duplicates in the “Open With” menu
alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# Empty the Trash on all mounted volumes and the main HDD
# Also, clear Apple’s System Logs to improve shell startup speed
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/Projects/Repos/Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

# Make Grunt print stack traces by default
command -v grunt > /dev/null && alias grunt="grunt --stack"

# Lock the screen (when going AFK)
alias afk="date \"+Locked screen on: %H:%M\"; /System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# Edit these settings
alias Settings="subl ~/Settings/"

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL -l"
