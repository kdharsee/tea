source /etc/zshrc

# Set up i3lock screen
# echo 'i3lock -c 000000 -n -e' >> /usr/bin/xflock4

# List highlighting completion
zstyle ':completion:*:*:git:*' menu select
fpath=(/usr/loca/share/zsh-completions $fpath)
autoload -U compinit && compinit
zmodload -i zsh/complist

# selection style
autoload -U select-word-style
select-word-style bash

# ADD local opt to path
export PATH=$HOME/opt/bin:/usr/local/bin:$PATH

# History
export HISTSIZE=2000
export HISTFILE="$HOME/.zsh_history"
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_ignore_space

# zsh autosend SIGCONT after disown
setopt AUTO_CONTINUE

# Start emacs server if it's not started
test -e "/tmp/emacs1990/server" || test -e "~/.emacs.d/server"
if [ $? -ne 0 ]
then
	\emacs --daemon -nw
fi

# Define aliases
alias ctags='find . -type f -iname "*.[chS]" | xargs etags -a'
alias ffind='find ./* -name'
alias clip='xclip -selection c'
alias sudo='sudo '
alias mv='mv -i'
alias ls='ls -h --color=auto'
alias ll='ls -lh'
alias la='ls -lah'
alias emacsclient='emacsclient -t'
alias emacs='emacsclient -t'
#alias grep='grep -H --color=auto'
alias grep='grep --color=auto'
alias pushd="pushd ."
alias peakd='echo $(dirs -l -p | sed -n "2{p;q}")'
alias ssh='ssh -XC'
alias rm='rm -I'
alias install='install -b' # Always make a backup
alias tl='tail -f /var/log/messages'
alias cd='cd -P'
alias qemu='qemu-system-x86_64'
alias qemu-kvm='qemu --enable-kvm'
alias lp='lp -o fit-to-page -o sides=two-sided-long-edge'
alias scholar='scholar -c 5'
alias less='less -R'
# Print history from the BEGINNING OF TIME
alias history='history 1'

# Set up display
export DISPLAY='localhost:0.0'
# Set default applications
export ALTERNATE_EDITOR="emacs"
export EDITOR='emacsclient -t'
export PAGER='most'

# Set up PATH and LD_LIBRARY_PATH for software installed to my home directory
export PATH="$PATH:$HOME/bin"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/lib:$HOME/lib64"

# Export terminal for all the colors
export TERM=xterm-256color

#### ANYTHING INSIDE THIS SECTION HAPPENS ONLY FOR "REALLY" INTERACTIVE SHELLS
#### (i.e. those with a tty allocated - not SCP, directly executed SSH commands, etc.)
tty -s
if [ $? -eq 0 ]
then
  ### Prompt setup
  # Note: the PS2 variable apparently doesn't work on this distribution.
  # It's just used internally by this script.
  if [ $(id -u) -eq 0 ]
  then
    PS2="#"
  else
    PS2="$"
  fi
  # Colors can be found in .bash_colors
  #export PS1="\[$CYAN\][\u@\h \W]$PS2 \[\e[m\]"
  export PROMPT='%F{cyan}[%n@%m]%f %F{blue}%~$%f '
fi

# Function to print a useful prompt
prompt_command() {
    local exit_status="$?"

    # Color definitions
    local normal="\e[0m"        # Normal color
    local fGbBb="\e[1;32;44m"   # Green foreground, blue background, bold
    local fYbBb="\e[1;33;44m"   # Yellow foreground, blue background, bold
    local fP="\e[35m"           # Purple foreground
    local fBb="\e[1;34m"        # Blue foreground, bold
    local fY="\e[0;33m"         # Yellow foreground
    local fR="\e[0;31m"         # Red foreground

    # Set PS1
    if [[ "$PS1" ]]; then
        PS1="$fGbBb"
        PS1="$PS1\u"                    # Username
        PS1="$PS1$fYbBb"
        PS1="$PS1@"                     # @
        PS1="$PS1$fGbBb"
        PS1="$PS1\h"                    # Hostname
        PS1="$PS1$normal"
        PS1="$PS1 "                     # <Space>
        PS1="$PS1$fP"
        PS1="${PS1}bash"                # bash
        PS1="$PS1$normal"
        PS1="$PS1 "                     # <Space>
        PS1="$PS1$fBb"
        PS1="$PS1\w"                    # PWD
        PS1="$PS1$fY"
        PS1="$PS1"`__git_ps1`           # Current Git branch name
        PS1="$PS1$normal"
        PS1="$PS1\n"                    # Newline
        if [[ "$exit_status" != 0 ]]; then
            PS1="$PS1$fR"
        fi
        PS1="$PS1\\$"                   # UID indicator
        PS1="$PS1$normal"
        PS1="$PS1 "                     # <Space>
        export PS1
    fi
}
#export PROMPT_COMMAND=prompt_command

# DIR COLORS
LS_COLORS=$LS_COLORS:'di=1;33:'; export LS_COLORS

# set emacs keybinds for line editor
bindkey -e
bindkey '^w' kill-region


function autoretry()
{
    false
    while [ $? -ne 0 ]; do
        "$@" || (sleep 1;false)
    done
}

function sshretry()
{
    autoretry ssh "$@"
}

