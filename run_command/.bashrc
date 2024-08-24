case $- in
    *i*) ;;
      *) return;;
esac

# HISTORY

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
HISTFILE=~/.bash_history

shopt -u histappend
share_history(){
  history -a
  history -c
  history -r
}
PROMPT_COMMAND='share_history'

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

# COMPILATION
bind 'set completion-ignore-case on'
bind 'TAB:menu-complete'
bind 'set show-all-if-ambiguous on'

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# PS1
# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

function nonzero_return() {
	RETVAL=$?
    echo "$RETVAL"
}

export PS1="\[\e[31m\]\u\[\e[m\] \[\e[36m\]\w\[\e[m\] [\[\e[33m\]\`nonzero_return\`\[\e[m\]] \[\e[37m\]\`parse_git_branch\`\[\e[m\] >  "

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
