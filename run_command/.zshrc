# Needs plugins:
# zsh-auto-suggestions
# zsh-syntax-highlighting

PROMPT="%f%b%F{45}%~%f[%F{227}%?%f] > "

# History settings
export HISTSIZE=1000000
export SAVEHIST=1000000
export HISTFILE=${HOME}/.zsh_history
setopt share_history

export LANG=en_US.UTF-8

setopt print_eight_bit
setopt no_beep
setopt no_flow_control
setopt ignore_eof
setopt interactive_comments
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt extended_glob

autoload -Uz colors
colors

autoload -Uz select-word-style
select-word-style default

autoload -Uz compinit
compinit
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' format '%B%F{blue}%d%f%b'


zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

zstyle ':completion:*:(cd|less):*' matcher 'm:{a-z}={A-Z}'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' ignore-parents parent pwd ..

zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                    /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

zstyle ':completion:*' completer _complete _approximate
zstyle ':completion:*:approximate' max-errors 4 NUMERIC
zstyle ':completion:*' completer _complete _correct
zstyle ':completion:*' completer _complete _approximate _prefix

zstyle ':autocomplete:*' add-space \
    executables aliases functions builtins reserved-words commands

function rprompt-git-current-branch {
  local branch_name st branch_status

  if [ ! -e  ".git" ]; then
    return
  fi
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`
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

setopt prompt_subst

RPROMPT='`rprompt-git-current-branch`'

alias ls='ls --color=auto' \
      l='ls' \
      ll='ls -l' \
      la='ls -a' \
      lla='ls -la' \
      g='git' \
      ga='git add' \
      gcm='git commit -m' \
      gb='git branch' \
      gc='git checkout' \
      gd='git diff' \
      gcb='git checkout -b' \
      gf='git fetch -v' \
      gp='git push' \
      gpo='git push origin' \
      gpos='git push origin stage' \
      gpoH='git push origin HEAD' \
      gpl='git pull' \
      gplo='git pull origin' \
      gplos='git pull origin stage' \
      gploH='git pull origin HEAD' \
      gl="git log" \
      sd="sudo" \
      sdpc="sudo pacman" \
      d='docker' \
      dc='docker compose' \
      co="code ." \
      s='startx' \
      c='cd' \
      d='cd' \
      dc='cd' \
      cdc='cd' \
      lsl='ls' \
      sl='ls' \
      sls='ls' \
      cz='code ~/.zshrc' \
      sz='source ~/.zshrc' \
      y='yarn' \
      yd='y dev' \
      yb='y build' \
      yl='y lint' \
      yi='y install' \
      yga='y global add' \
      ya='y add' \
      n='bash -c "if [[ $(gsettings get org.gnome.settings-daemon.plugins.color night-light-enabled) == "true" ]]; then gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled false; else gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true; fi"' \
      cursor="~/Application/Cursor.AppImage --no-sandbox "


function mkcd() {
  mkdir -p "$1" && cd "$1"
}

export LS_COLORS='di=01;33'

bindkey '^R' history-incremental-pattern-search-backward
bindkey ";5C" forward-word
bindkey ";5D" backward-word
export NPM_GITHUB_TOKEN=******

# git-completion
# curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh -o ~/.zsh/git-completion.zsh
fpath=(~/.zsh $fpath)
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.zshsz
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export ANDROID_HOME=$HOME/Android/Sdk

export ANDROID_SDK_ROOT=$ANDROID_HOME
export PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$PATH
