######### Custom aliases!
alias zshconfig="subl ~/.zshrc"

alias server="php -S 127.0.0.1:4000"

alias Apps='cd ~/Developer/Apps'
alias Web='cd ~/Developer/Web'
alias Repos='cd ~/Developer/Repos'
alias Study='cd ~/Developer/Study'

# Edit Dotfiles
alias Dotfiles="subl ~/Developer/Repos/Dotfiles/"

# Delete all 'gone' 'merged' branches
alias git-cleanup-branches="git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -d"

## Cleanup XCODE
alias purgexcodebuilds='rm -rf ~/library/Developer/Xcode/DerivedData/*'

## OSX
alias delete-extended-attributes='xattr -c'

# show path when ls
alias ls="pwd; ls -ahl"

# mkdir and cd into dir
function mkcd() { mkdir -p "$@" && cd "$_"; }

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

# Empty the Trash on all mounted volumes and the main HDD
# Also, clear Apple’s System Logs to improve shell startup speed
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/Projects/Repos/Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

# Lock the screen (when going AFK) and print current time
alias afk="date \"+Locked screen on: %H:%M\"; /System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL -l"

# typos
alias gut=git

alias deleteDsStore="find . -name '.DS_Store' -type f -delete"

alias rsyncopy="rsync -vraz --exclude '.Trashes' --exclude '.Spotlight-V100' --exclude '.fseventsd'"
alias rsyncssh="rsync -P -vraz  --exclude '.Trashes' --exclude '.Spotlight-V100' --exclude '.fseventsd' --rsh=ssh"
alias listbackup-disks="diskutil cs list"
alias listbackup-info="diskutil cs info /Volumes/"

alias record-sim="xcrun simctl io booted recordVideo -f --mask=black --codec=h264 ~/Desktop/ios-sim-video.mov"

alias edit-keybindings="subl ~/Library/KeyBindings/DefaultKeyBinding.dict"