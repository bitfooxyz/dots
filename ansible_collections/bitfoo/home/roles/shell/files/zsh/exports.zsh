# Append path with users local bin dir
export PATH=~/.local/bin:$PATH
# History
export HISTSIZE=100000      # Nearly infinite history; essential to building a cli 'library' to use with fzf/etc
export SAVEHIST=100000
export HISTFILE=$XDG_CACHE_HOME/.zsh_history
mkdir -p "$(dirname "$HISTFILE")"

# Default editor
export EDITOR="vim"

# Default pager
export PAGER="less"
# --RAW-CONTROL-CHARS:   translate raw escape sequences to colors
# --squeeze-blank-lines: no more than one blank line in a row
# --quit-on-intr:        quit on interrupt, e.g. C-c
# --quit-if-one-screen:  quit if content fills less than the screen
export LESS='--RAW-CONTROL-CHARS --squeeze-blank-lines --quit-on-intr --quit-if-one-screen'
if command -v lesspipe.sh &> /dev/null; then
    export LESSOPEN="|lesspipe.sh %s"
fi

# Terminal configuration
export TERM=xterm-256color # True Color support in terminals and TUI programs that support it (e.g. vim)

# Ensure locale is set language variables
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export C_TIME=en_US.UTF-8
export C_ADDRESS=de_DE.UTF-8
export C_IDENTIFICATION=de_DE.UTF-8
export C_MEASUREMENT=de_DE.UTF-8
export C_MONETARY=de_DE.UTF-8
export C_NAME=de_DE.UTF-8
export C_NUMERIC=de_DE.UTF-8
export C_PAPER=de_DE.UTF-8
export C_TELEPHONE=de_DE.UTF-8

# Export gpg-agent's TTY to allow access to it.
export GPG_TTY=$(tty)

# Export to circumvent forking failure
# See: [__NSPlaceholderDate initialize] may have been in progress in
# another thread when fork() was called.
# This is an ansible workaround
if [ $(uname) = "Darwin" ]; then
    export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
fi

# Set exports if mcfly exists
if command -v mcfly &> /dev/null; then
    export MCFLY_INTERFACE_VIEW=bottom
    export MCFLY_PROMPT="❯"
    export MCFLY_RESULTS=50
    export MCFLY_FUZZY="2"
    export MCFLY_KEY_SCHEME="vim"
fi

# Set exports if fzf is installed
if command -v fzf &> /dev/null; then
    export FZF_DEFAULT_OPTS="--cycle --border=bold"
    if command -v fd &> /dev/null; then
        export FZF_DEFAULT_COMMAND="fd --type f"
    fi
    if [[ -r "$XDG_CONFIG_HOME/fzf/preview.sh" ]]; then
        export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --preview '$XDG_CONFIG_HOME/fzf/preview.sh {}'"
    fi
fi

# Set colors for jq output
if command -v jq &> /dev/null; then
    export JQ_COLORS="1;30:0;37:0;37:0;37:0;32:1;37:1;37"
fi

if command -v tealdeer &> /dev/null; then
    export TEALDEER_CONFIG_DIR="$XDG_CONFIG_HOME/tealdeer"
fi

if command -v bat &> /dev/null; then
    export BAT_THEME="tokyonight_storm"
fi

if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi
