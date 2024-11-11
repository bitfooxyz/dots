# Setup completion for for custom commands
fpath+="$HOME/.config/zsh/completions"

# Prerequisites for macos
if [[ $(uname) == "Darwin" ]]; then
  if command -v brew &> /dev/null; then
    path+="/opt/homebrew/share/zsh/site-functions"
    fpath+="/opt/homebrew/share/zsh/site-functions"
  fi
fi

path+="$HOME/.config/zsh/plugins/zsh-autosuggestions"
fpath+="$HOME/.config/zsh/plugins/zsh-autosuggestions"
path+="$HOME/.config/zsh/plugins/zsh-history-substring-search"
fpath+="$HOME/.config/zsh/plugins/zsh-history-substring-search"
path+="$HOME/.config/zsh/plugins/zsh-syntax-highlighting"
fpath+="$HOME/.config/zsh/plugins/zsh-syntax-highlighting"
path+="$HOME/.config/zsh/plugins/zsh-completions"
fpath+="$HOME/.config/zsh/plugins/zsh-completions"
path+="$HOME/.config/zsh/plugins/collored-man-pages"
fpath+="$HOME/.config/zsh/plugins/collored-man-pages"
path+="$HOME/.config/zsh/plugins/sudo"
fpath+="$HOME/.config/zsh/plugins/sudo"
path+="$HOME/.config/zsh/plugins/powerlevel10k"
fpath+="$HOME/.config/zsh/plugins/powerlevel10k"
path+="$HOME/.config/zsh/plugins/powerlevel10k-config"
fpath+="$HOME/.config/zsh/plugins/powerlevel10k-config"

# Oh-My-Zsh/Prezto calls compinit during initialization,
# calling it twice causes slight start up slowdown
# as all $fpath entries will be traversed again.
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

if [[ -f "$HOME/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh" ]]; then
  source "$HOME/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"
fi
if [[ -f "$HOME/.config/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh" ]]; then
  source "$HOME/.config/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh"
fi
if [[ -f "$HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh" ]]; then
  source "$HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"
fi
if [[ -f "$HOME/.config/zsh/plugins/zsh-completions/zsh-completions.plugin.zsh" ]]; then
  source "$HOME/.config/zsh/plugins/zsh-completions/zsh-completions.plugin.zsh"
fi
if [[ -f "$HOME/.config/zsh/plugins/collored-man-pages/collored-man-pages.plugin.zsh" ]]; then
  source "$HOME/.config/zsh/plugins/collored-man-pages/collored-man-pages.plugin.zsh"
fi
if [[ -f "$HOME/.config/zsh/plugins/sudo/sudo.plugin.zsh" ]]; then
  source "$HOME/.config/zsh/plugins/sudo/sudo.plugin.zsh"
fi
if [[ -f "$HOME/.config/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
  source "$HOME/.config/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme"
fi
if [[ -f "$HOME/.config/zsh/plugins/powerlevel10k-config/p10k.zsh" ]]; then
  source "$HOME/.config/zsh/plugins/powerlevel10k-config/p10k.zsh"
fi

if [ -f $HOME/.rye/env ]; then
  source "$HOME/.rye/env"
fi

if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh --cmd cd)"
fi
