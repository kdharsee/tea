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
export PATH=$PATH:$HOME/opt/bin

# History
export HISTSIZE=2000
export HISTFILE="$HOME/.zsh_history"
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_ignore_space

# Start emacs server
\emacs --daemon -nw

# Define aliases
alias clip='xclip -selection c'
alias sudo='sudo '
alias mv='mv -i'
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -lah'
alias emacsclient='emacsclient -t'
alias emacs='emacsclient -t'
#alias grep='grep -H --color=auto'
alias grep='grep --color=auto'
alias pushd="pushd ."
alias peakd="cd \"$(dirs -l -p | sed -n '2{p;q}')\""
alias ssh='ssh -XC'
alias rm='rm -I'
alias install='install -b' # Always make a backup
alias tl='tail -f /var/log/messages'
alias cd='cd -P'
alias qemu='qemu-system-x86_64'
alias qemu-kvm='qemu --enable-kvm'
alias lp='lp -o fit-to-page -o sides=two-sided-long-edge'
alias scholar='scholar -c 5'

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

# DIR COLORS
LS_COLORS=$LS_COLORS:'di=1;33:'; export LS_COLORS

# set emacs keybinds for line editor
bindkey -e

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
