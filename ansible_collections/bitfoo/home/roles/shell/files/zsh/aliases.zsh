alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"
alias hgrep="history 0 |grep --color=auto "
alias ll="ls -lFh --color=auto"
alias l=ll
alias la="ls -lAFh"
alias ls="ls --color=auto"

# Ask when overwrittin a file
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# Tailing logfiles
alias t="tail -f"
# Human readable output
alias df="df -h"

# Reload zshrc
alias zre="source $XDG_CONFIG_HOME/zsh/.zshrc"

if command -v netstat &> /dev/null; then
    alias ports="netstat -tlpen"
fi

# Kubernetes aliases
if command -v kubectl &> /dev/null; then
    alias k="kubectl"
fi
if command -v kubectx &> /dev/null; then
    alias kns="kubens"
    alias kct="kubectx"
fi

# git aliase
if command -v git &> /dev/null; then
    alias ggrep="git grep"
    alias gst="git status"
    alias gad="git add"
    alias gadd=gad
    alias gcom="git commit -v"
    alias gcof="git commit -m "f""
    alias gcoam="git commit -v --amend"
    alias gri="git rebase -i"
    alias gsta="git stash"
    alias gsto="git stash pop"
    alias gstl="git stash list"
    alias gom=gcom
    alias giff="git diff"
fi

# Either use pacman or yay (if available) to upgrade system.
_sysupgrade() {
    test $(id -u) = 0 && SUDO="" || SUDO="sudo"
    test -x $(command -v yay) && UPGRADE_CMD="yay -Syu" || test -x $(command -v pacman) && UPGRADE_CMD="$SUDO pacman -Syu"
    test -x $(command -v dnf) && UPGRADE_CMD="$SUDO dnf update"
    test -x $(command -v flatpak) && UPGRADE_CMD="$UPGRADE_CMD && flatpak update && flatpak update --user"
    echo $UPGRADE_CMD
    eval $UPGRADE_CMD
}
alias sysupgrade=_sysupgrade

# Set aliases for cat to bat if bat exists.
if command -v bat &> /dev/null; then
    alias cat="bat"
fi

# Alias grep with ripgrep to have a better grep tool.
if command -v rg &> /dev/null; then
    alias grep="rg"
fi

if command -v eza &> /dev/null; then
    alias eza="eza --icons --group-directories-first --group --header --mounts --git"
    alias la="eza -a"
    alias ll="eza -l"
    alias lla="eza -la"
    alias ls="eza"
    alias lt="eza --tree"
    alias tree="eza --tree"
fi

if command -v batman &> /dev/null; then
    alias man=batman
fi

if command -v btop &> /dev/null; then
    alias top=btop
fi

if command -v nvim &> /dev/null; then
    alias vimdiff="nvim -d"
    alias vim="nvim"
    alias vi="nvim"
fi

if command -v lazygit &> /dev/null; then
    alias lg="lazygit"
fi

alias bku-sops="SOPS_AGE_KEY_FILE=$XDG_CONFIG_HOME/bku/keyfile.txt sops exec-env $XDG_CONFIG_HOME/bku/credentials.env"
