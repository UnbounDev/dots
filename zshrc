# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# start tmux
# If not running interactively, don't do anything
if [[ $DISPLAY ]]; then
  # If not running interactively, do not do anything
  [[ $- != *i* ]] && return
  [[ -z "$TMUX" ]] && exec tmux
fi

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
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
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

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
  #zsh-nvm
)


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

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh

#
#
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# always
export EDITOR=/usr/bin/nvim

# roll up... no more arch :(
# alias roll='pacaur -Syu && neofetch'
# alias pac-clean='pacaur -Scc'

# awesomewm
alias testawesome='Xephyr :5 & sleep 1 ; DISPLAY=:5 awesome';

# all things n/vi/m
alias ls='ls --color=auto'
alias vi='nvim'
alias vim='nvim'

# k8s
alias k='kubectl';
alias kgp='kubectl get pods';
alias kgs='kubectl get services';
alias kdp='kubectl delete pod';
alias kds='kubectl delete service';
alias ktail='kubectl logs -f --tail=10';
alias kloc='kubectl get pods | grep';

# jaeger-access
if [ -x "$(command -v kubectl)" ]; then 
  alias kjaeger="kubectl port-forward $(kubectl get pods -l app=jaeger -ojson | jq -r '.items[0] | .metadata.name') 16686";
fi

# docker
alias docker-clean='docker rmi $(docker images --quiet --filter "dangling=true")';

# misc
alias top='htop'

# PATH
PATH="$PATH:$HOME/.local/bin/:/home/austin/go/bin/:/home/austin/.npm-global/bin/"
PATH="$PATH:$HOME/.gem/ruby/2.5.0/bin/"
PATH="$PATH:$HOME/.cargo/bin/"
PATH="$PATH:$HOME/bin/"
if [ -x "$(command -v yarn)" ]; then PATH="$PATH:`yarn global bin`"; fi
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export GOPATH="/home/austin/go/"

# GOOGLE CLOUD
#
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/austin/google-cloud-sdk/path.zsh.inc' ]; then source '/home/austin/google-cloud-sdk/path.zsh.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '/home/austin/google-cloud-sdk/completion.zsh.inc' ]; then source '/home/austin/google-cloud-sdk/completion.zsh.inc'; fi

# AZUQUA
#
# azuquactl
export PATH="${PATH}:/home/austin/.azuquactl"
source <(azuquactl completion zsh)
alias rdb="xfreerdp /u:austin /v:35.211.50.31 /size:1680x1050"

# K8S
#
if [ -x "$(command -v kubectl)" ]; then source <(kubectl completion zsh); fi

