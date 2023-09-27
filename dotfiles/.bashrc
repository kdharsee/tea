# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Emacs config
EMACS_GUI=0
if [[ $EMACS_GUI -eq 0 ]]
then
    alias emacsclient='emacsclient -t'
else
    alias emacsclient='emacsclient -n'
fi
alias emacs="emacsclient"
# Define static aliases
alias gef="\gdb -q -x ~/.gefinit"
alias gdb="gdb -q"
alias tags='find . -type f -regextype egrep -regex ".*\.(c|h|S|cpp|cc|hpp|hh)" | xargs etags -a'
alias clip='xclip -selection c'
alias mv='mv -i'
export COLORTERM=1
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -la'
#alias grep='grep -H --color=auto'
alias grep='grep --color=auto'
alias grepc='grep --color=yes'
#alias pushd="pushd ."
alias peakd='echo $(dirs -l -p | sed -n "2{p;q}")'
alias ssh='ssh -XC'
alias rm='rm -I'
alias install='install -b' # Always make a backup
alias tl='tail -f /var/log/messages'
#alias cd='cd -P' # Alias cd to resolve symbolic links to realpath
#alias qemu='qemu-system-x86_64'
alias qemu-kvm='qemu --enable-kvm'
alias lp='lp -o fit-to-page -o sides=two-sided-long-edge'
alias scholar='scholar -c 5'
alias less='less -R'
# Print history from the BEGINNING OF TIME
alias history='history 1'
# Alias for xpdf reverse video (dark) mode
alias xpdf='xpdf -rv'
# Directory history
alias dirs='dirs -v'
alias pud="pushd"
alias pod="popd"
# Set up display
#export DISPLAY=':0.0'
# Set default applications
export ALTERNATE_EDITOR="emacs"
export EDITOR='emacsclient -t'
export PAGER='less'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Start emacs server if it's not started
function emacs_server_start()
{
    server=0
    running=0
    server_file=''
    for file in /tmp/emacs*
    do 
        test -O $file/server
        if [[ $? -eq 0 ]]
        then
            server=1
            server_file=$file/server
        fi
    done
    FOUND=$(ps --format cmd= -U $USER | grep -c "emacs.*daemon" )
    if [[ $FOUND -eq 2 ]]
    then
        running=1
    fi

    if [[ $running -eq 0 ]]
    then
        if [[ $server -ne 0 ]]
        then
            echo "Deleting emacs server file $server_file" 
            rm $server_file
        fi
        if [[ $EMACS_GUI -eq 0 ]]
        then
	          \emacs -nw --daemon
            alias emacsclient='emacsclient -t'
        else
            \emacs --daemon
            alias emacsclient='emacsclient -n'
        fi
        alias emacs="emacsclient"
    fi
}

function emacs_server_restart() {
    killall emacs
    emacs_server_start
}

emacs_server_start

