# ========================================
# Powerlevel10k Instant Prompt
# ========================================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ========================================
# 基本環境変数
# ========================================
export LANG=en_US.UTF-8
export HISTSIZE=1000000
export SAVEHIST=1000000
export HISTFILE=${HOME}/.zsh_history

export NPM_GITHUB_TOKEN=
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_SDK_ROOT=$ANDROID_HOME
export JAVA_HOME=/opt/android-studio/jbr
export PATH=$JAVA_HOME/bin:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$PATH
export PNPM_HOME="/home/haruki-goto/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
export PATH="/home/haruki-goto/.local/share/aquaproj-aqua/bin:$PATH"

# ========================================
# zplug 初期化とプラグイン
# ========================================
export ZPLUG_HOME=$HOME/.zplug
source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-completions", defer:2
zplug "plugins/git", from:oh-my-zsh
zplug "~/.zsh", from:local, use:"git-completion.zsh", defer:1
zplug "lukechilds/zsh-better-npm-completion"
zplug "romkatv/powerlevel10k", as:theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
zplug "ajeetdsouza/zoxide", use:"zoxide.zsh"
zplug "junegunn/fzf", hook-build:"./install --bin"
zplug "Aloxaf/fzf-tab"
zplug "zsh-users/zsh-history-substring-search"
zplug "changyuheng/zsh-interactive-cd"

if ! zplug check --verbose; then
  zplug install
fi
zplug load

# fzf補完
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zoxide初期化
eval "$(zoxide init zsh)"

# fzf-tab 設定
setopt no_menu_complete
unsetopt menu_complete

# npm補完をpnpmにも適用
compdef pnpm=npm

# history substring search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# ========================================
# zsh オプション
# ========================================
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt extended_glob
setopt print_eight_bit
setopt no_beep
setopt no_flow_control
setopt ignore_eof
setopt interactive_comments
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt prompt_subst

# ========================================
# 補完設定
# ========================================
autoload -Uz compinit
compinit
autoload -Uz select-word-style
select-word-style default

zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' format '%B%F{blue}%d%f%b'
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified
zstyle ':completion:*:(cd|less):*' matcher 'm:{a-z}={A-Z}'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ':completion:*' completer _complete _approximate _prefix _correct
zstyle ':completion:*:approximate' max-errors 4 NUMERIC
zstyle ':autocomplete:*' add-space executables aliases functions builtins reserved-words commands

# ========================================
# プロンプトと Git branch 表示
# ========================================
autoload -Uz colors
colors

PROMPT="%f%b%F{45}%~%f[%F{227}%?%f] > "
function rprompt-git-current-branch {
  local branch_name st branch_status
  if [ ! -e  ".git" ]; then return; fi
  branch_name=`git rev-parse --abbrev-ref HEAD 2`
  st=`git status 2`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    branch_status="%F{green}"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    branch_status="%F{red}?"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    branch_status="%F{red}+"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    branch_status="%F{yellow}!"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    echo "%F{red}!(no branch)"
    return
  else
    branch_status="%F{blue}"
  fi
  echo "${branch_status}[$branch_name]"
}
RPROMPT='`rprompt-git-current-branch`'

# ========================================
# エイリアス
# ========================================
alias ls='ls --color=auto'
alias l='ls'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lsl='ls'
alias sl='ls'
alias sls='ls'
alias g='git'
alias ga='git add'
alias gcm='git commit -m'
alias gb='git branch'
alias gc='git checkout'
alias gd='git diff'
alias gcb='git checkout -b'
alias gf='git fetch -v'
alias gp='git push'
alias gpo='git push origin'
alias gpos='git push origin stage'
alias gpoH='git push origin HEAD'
alias gpl='git pull'
alias gplo='git pull origin'
alias gplos='git pull origin stage'
alias gploH='git pull origin HEAD'
alias gl='git log'
alias sd='sudo'
alias sdpc='sudo pacman'
alias d='docker'
alias dc='docker compose'
alias co='code .'
alias s='startx'
alias c='cd'
alias ..='cd ..'
alias ...='cd ../..'
alias cz='code ~/.zshrc'
alias sz='source ~/.zshrc'
alias y='yarn'
alias yd='y dev'
alias yb='y build'
alias yl='y lint'
alias yi='y install'
alias yga='y global add'
alias ya='y add'
alias n='bash -c "if [[ $(gsettings get org.gnome.settings-daemon.plugins.color night-light-enabled) == \"true\" ]]; then gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled false; else gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true; fi"'
alias cursor="~/Application/squashfs-root/AppRun --no-sandbox"

# ========================================
# 関数
# ========================================
function mkcd() {
  mkdir -p "$1" && cd "$1"
}

# ========================================
# カラー設定
# ========================================
export LS_COLORS='di=01;33'

# ========================================
# キーバインド
# ========================================
bindkey '^R' history-incremental-pattern-search-backward
bindkey ';5C' forward-word
bindkey ';5D' backward-word

