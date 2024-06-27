######### Custom aliases!
alias zshconfig="subl ~/.zshrc"

alias server="php -S 127.0.0.1:4000"

alias Apps='cd ~/Developer/Apps'
alias Web='cd ~/Developer/Web'
alias Repos='cd ~/Developer/Repos'
alias Study='cd ~/Developer/Study'

# Edit Dotfiles
alias Dotfiles="code ~/Developer/Repos/Dotfiles/"

alias stale-branches='for k in $(git branch -r | egrep "(quartz|tieme)" | sed /\*/d); do if [[ ! $(git log -1 --since=30.days.ago -s $k) ]]; then echo $k; fi; done'

# Delete all 'gone' 'merged' branches
alias git-cleanup-branches="git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -D"

## Cleanup XCODE
alias purgexcodebuilds='rm -rf ~/library/Developer/Xcode/DerivedData && rm -rf ./DerivedData'
alias project='find . -maxdepth 1 | grep xcodeproj | xargs open'

## OSX
alias delete-extended-attributes='xattr -c'
alias imagediff='ksdiff'

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
alias gti=git

alias deleteDsStore="find . -name '.DS_Store' -type f -delete"

alias rsyncopy="rsync -vraz --exclude '.Trashes' --exclude '.Spotlight-V100' --exclude '.fseventsd'"
alias rsyncssh="rsync -P -vraz  --exclude '.Trashes' --exclude '.Spotlight-V100' --exclude '.fseventsd' --rsh=ssh"
alias listbackup-disks="diskutil cs list"
alias listbackup-info="diskutil cs info /Volumes/"

alias record-sim="xcrun simctl io booted recordVideo -f --mask=black --codec=h264 ~/Desktop/ios-sim-video.mov"

alias edit-keybindings="subl ~/Library/KeyBindings/DefaultKeyBinding.dict"

alias gt="git-tree"

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
  git checkout $(awk '{print $2}' <<< "$target" )
}

# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
fbr() {
  local branches branch
  branches=$(git for-each-ref --count=100 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" | fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}
