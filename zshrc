# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export PATH="~/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

# Google cloud SDK
export PATH="$PATH:~/google-cloud-sdk/bin"

# Python poetry 
export PATH="$HOME/.poetry/bin:$PATH"

ZSH_THEME="eastwood"

source $ZSH/oh-my-zsh.sh

# Aliases
alias grep='grep  --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
alias mysql=/usr/local/mysql/bin/mysql

# case insensitive path-completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# partial completion suggestions
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix
autoload -Uz compinit && compinit

# fzf setup
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

### Functions ###
# Find process at port
listening() {
    if [ $# -eq 0 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P
    elif [ $# -eq 1 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P | grep -i --color $1
    else
        echo "Usage: listening [pattern]"
    fi
}

# Select git branch
gcheckout() {
    git checkout $(git branch -a --format '%(refname:short)' | sed 's~origin/~~' | sort | uniq | fzf)
}

# Clean up local branches
gpurge() {
    git branch --merged | grep -v "\*" | grep -v "master" | xargs -n 1 git branch -d
}

# See prettier git logs
glog() {
    git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset"
}

# Quickly append the last commit to the one before it
gappend() {
    git reset --soft "HEAD^" && git commit --amend --no-edit
}
