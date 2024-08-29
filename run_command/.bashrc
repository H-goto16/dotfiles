if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi

case $- in
    *i*) ;;
      *) return;;
esac

# HISTORY

HISTCONTROL=ignoredups:erasedups
HISTSIZE=100000
HISTFILESIZE=200000
HISTFILE=~/.bash_history

# SHOPT

shopt -s histappend
shopt -s checkwinsize
shopt -s autocd
shopt -s cdable_vars
shopt -s cdspell
shopt -s checkhash
shopt -s dotglob
shopt -s dirspell
shopt -s force_fignore
shopt -s no_empty_cmd_completion
shopt -s globstar
shopt -s nocaseglob
shopt -s progcomp
shopt -s hostcomplete
shopt -s cmdhist
shopt -s histreedit
shopt -u histappend

# COMPILATION
bind 'set completion-ignore-case on'
bind 'TAB:menu-complete'
bind 'set show-all-if-ambiguous on'

# PS1

function nonzero_return() {
	echo $?
}

export PS1="\[\e[31m\]\u\[\e[m\] \[\e[36m\]\w\[\e[m\] [\`nonzero_return\`] > "
# COLOR AUTO ALIAS

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# NORMAL ALIAS

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
      uu="sudo apt update -y && sudo apt upgrade -y" \
      code="flatpak run com.visualstudio.code" \
      alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"' \
      spotify='flatpak run com.spotify.Client' \
      chrome='flatpak run com.google.Chrome' \
      wezterm='flatpak run org.wezfurlong.wezterm' \
      slack='flatpak install flathub com.slack.Slack'

function mkcd() {
  mkdir -p "$1" && cd "$1"
}

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# VOLTA SETTINGS
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export VOLTA_FEATURE_PNPM=1

# LS COLORS
export LS_COLORS='di=01;33'

# NPM GITHUB TOKEN
export NPM_GITHUB_TOKEN=**********************************

# PNPM SETTINGS
source ~/completion-for-pnpm.bash

# BLE SETTINGS
source ~/.local/share/blesh/ble.sh

# BASH-IT SETTINGS

export BASH_IT="/home/haruki-goto/.bash_it"
# export BASH_IT_THEME='bobby'
export GIT_HOSTING='git@git.domain.com'
unset MAILCHECK
export IRC_CLIENT='irssi'
export TODO="t"
export SCM_CHECK=true
export GITSTATUS_NUM_THREADS=8
export SHORT_HOSTNAME=$(hostname -s)
export SHORT_USER=${USER:0:10}
export BASH_IT_COMMAND_DURATION=true
export COMMAND_DURATION_MIN_SECONDS=1
export SHORT_TERM_LINE=true
export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1
source "$BASH_IT"/bash_it.sh
