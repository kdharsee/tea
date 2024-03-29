# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    zsh-syntax-highlighting
    fzf
    fzf-zsh-plugin
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# Set up i3lock screen
# echo 'i3lock -c 000000 -n -e' >> /usr/bin/xflock4


# Set up i3lock screen
# echo 'i3lock -c 000000 -n -e' >> /usr/bin/xflock4

# List highlighting completion
zstyle ':completion:*:*:git:*' menu select
fpath=(/usr/local/share/zsh-completions $fpath)
autoload -U compinit && compinit
zmodload -i zsh/complist

# selection style
autoload -U select-word-style
select-word-style bash

# set PATH variable
export PATH=$PATH:/opt/miniconda3/bin
export PATH=$PATH:/opt/riscv/bin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/.local/opt/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:/opt/homebrew/bin
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/.local/lib:$HOME/lib64

# Machine-specific Environment Variables
export YOSYSHQ_LICENSE=/home/kdharsee/Research/decaf/yosys_official_builds/tabbycad-rochester-220620.lic


# Fetch opam environment vars
test -r ${HOME}/.opam/opam-init/init.zsh && . ${HOME}/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# History
export HISTSIZE=2000
export HISTFILE="$HOME/.zsh_history"
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_ignore_space

# Globbing enhancments
setopt extended_glob
# zsh autosend SIGCONT after disown
setopt autocontinue
# zsh disable globbing from printing error on nomatch (e.g. /tmp/emacs* -> ERROR)
setopt +o nomatch
setopt noautopushd
setopt nopushdtohome
setopt nopushdignoredups
setopt pushdsilent
# Bash compatibilty mode
autoload bashcompinit
bashcompinit

# Define static aliases
alias ta="tmux attach -t"
alias gef="\gdb -q -x ~/.gefinit"
alias gdb="gdb -q"
alias tags='find . -type f -regextype egrep -regex ".*\.(c|h|S|cpp|cc)" | xargs etags -a'
alias clip='xclip -selection c'
alias sudo='sudo '
alias mv='mv -i'
alias ls='ls -h --color'
alias ll='ls -lh'
alias la='ls -lah'
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
alias pd="pushd"
alias qemu='qemu-system-x86_64'
alias qemu-kvm='qemu --enable-kvm'
alias lp='lp -o fit-to-page -o sides=two-sided-long-edge'
alias scholar='scholar -c 5'
alias less='less -R'
alias history='history 10'
# Alias for xpdf reverse video (dark) mode
alias xpdf='xpdf -rv'
# Directory history
alias dirs='dirs -v'
alias xargs='xargs '
alias dirs='dirs -v'
alias pud="pushd"
alias pod="popd"
# Set up display
#export DISPLAY=':0.0'
# Emacs config
export EMACS_SERVER_DIR="~/.emacs.d/servers"
export EMACS_SERVER_NAME="${USER}_server"
export EMACS_SERVER_SOCKET="${EMACS_SERVER_DIR}/${EMACS_SERVER_NAME}"
EMACS_SERVER_CMD="emacs --daemon=${EMACS_SERVER_NAME}"
EMACS_GUI=0
alias emacs="emacsclient"
# Set default applications
#export ALTERNATE_EDITOR="vi"
export EDITOR='emacs'
#export PAGER='less'
export PAGER='most'
# Execute this after each new prompt (BASH)
export PROMPT_COMMAND="pwd > /tmp/whereami"
# Execute the PROMPT_COMMAND with zsh tools
whereami() { eval $PROMPT_COMMAND }
# Register hook to execute on changed directory
#add-zsh-hook chpwd whereami

# Export terminal for all the colors
# export TERM=xterm-256color

#### ANYTHING INSIDE THIS SECTION HAPPENS ONLY FOR "REALLY" INTERACTIVE SHELLS
#### (i.e. those with a tty allocated - not SCP, directly executed SSH commands, etc.)
# tty -s
# if [ $? -eq 0 ]
# then
#   ### Prompt setup
#   # Note: the PS2 variable apparently doesn't work on this distribution.
#   # It's just used internally by this script.
#   if [ $(id -u) -eq 0 ]
#   then
#     PS2="#"
#   else
#     PS2="$"
#   fi
#   # Colors can be found in .bash_colors
#   #export PS1="\[$CYAN\][\u@\h \W]$PS2 \[\e[m\]"
#   export PROMPT='%F{cyan}[%n@%m]%f %F{blue}%~$%f '
# fi

# Functions for prompt
# PS1o="$PS1"

# Calculate number of lines for half terminal's height
halfpage=$((LINES/2))
# Construct parameter to go down/up $halfpage lines view termcap
halfpage_down=""
for i in {1..$halfpage}; do 
    halfpage_down="$halfpage_down$terminfo[cud1]"
done
halfpage_up=""
for  i in {1..$halfpage}; do 
    halfpage_up="$halfpage_up$terminfo[cuu1]"
done

function prompt_middle() { 
    # print $halfpage_down
    PS1="%{${halfpage_down}${halfpage_up}%}$PS1o"
}
function prompt_restore() {
    PS1="$PS1o"
}

function magic-enter() { 
    if [[ -z $BUFFER ]]
    then 
        print ${halfpage_down}${halfpage_up}$terminfo[cuu1]
        zle reset-prompt
    else
        zle accept-line
    fi
}
# forward-word to first character, not first alpha
zle -A emacs-forward-word forward-word
zle -N magic-enter
bindkey "^M" magic-enter    

# Function to print a useful prompt
# prompt_command() {
#     local exit_status="$?"

#     # Color definitions
#     local normal="\e[0m"        # Normal color
#     local fGbBb="\e[1;32;44m"   # Green foreground, blue background, bold
#     local fYbBb="\e[1;33;44m"   # Yellow foreground, blue background, bold
#     local fP="\e[35m"           # Purple foreground
#     local fBb="\e[1;34m"        # Blue foreground, bold
#     local fY="\e[0;33m"         # Yellow foreground
#     local fR="\e[0;31m"         # Red foreground

#     # Set PS1
#     if [ "$PS1" ]; then
#         PS1="$fGbBb"
#         PS1="$PS1\u"                    # Username
#         PS1="$PS1$fYbBb"
#         PS1="$PS1@"                     # @
#         PS1="$PS1$fGbBb"
#         PS1="$PS1\h"                    # Hostname
#         PS1="$PS1$normal"
#         PS1="$PS1 "                     # <Space>
#         PS1="$PS1$fP"
#         PS1="${PS1}bash"                # bash
#         PS1="$PS1$normal"
#         PS1="$PS1 "                     # <Space>
#         PS1="$PS1$fBb"
#         PS1="$PS1\w"                    # PWD
#         PS1="$PS1$fY"
#         PS1="$PS1"`__git_ps1`           # Current Git branch name
#         PS1="$PS1$normal"
#         PS1="$PS1\n"                    # Newline
#         if [[ "$exit_status" != 0 ]]; then
#             PS1="$PS1$fR"
#         fi
#         PS1="$PS1\\$"                   # UID indicator
#         PS1="$PS1$normal"
#         PS1="$PS1 "                     # <Space>
#         export PS1
#     fi
# }
#export PROMPT_COMMAND=prompt_command

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
    autoretry ssh -o "ConnectTimeout=2" "$@"
}


function emacsline()
{
    cut -d ":" -f 1,2 | sed 's|\(.*\):\(.*\)|+\2 \1|g' | xargs emacs
}
function findmissingcite()
{
    grep -i undef ./*.log | grep -oP "\`.*?\'" | sed "s/[\`\']//g" | xargs -I {} grep --color=always {} ./*.tex | sort
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Start emacs server if it's not started
function emacs_server_start()
{
    server=0
    running=0
    FOUND=$(ps -o command -U $USER | grep -c $EMACS_SERVER_CMD )
    if [[ $FOUND -eq 2 ]]
    then
        running=1
    fi
    
    if [[ $running -eq 0 ]] # If the server is not running
    then
        if [[ $EMACS_GUI -eq 0 ]]
        then
	          eval "\\${EMACS_SERVER_CMD} -nw"
            alias emacsclient="emacsclient -t -s ${EMACS_SERVER_SOCKET}"
        else
            eval "\\${EMACS_SERVER_CMD}" 
           alias emacsclient="emacsclient -n -s ${EMACS_SERVER_SOCKET}"
        fi
    fi
    if [[ $EMACS_GUI -eq 0 ]]
    then
        alias emacsclient="emacsclient -t -s ${EMACS_SERVER_SOCKET}"
    else
        alias emacsclient="emacsclient -n -s ${EMACS_SERVER_SOCKET}"
    fi
    alias emacs="emacsclient"
}

function emacs_server_restart() {
    killall emacs
    emacs_server_start
}

emacs_server_start
