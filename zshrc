
# restore color scheme
(cat $HOME/.config/wpg/sequences &)

# PATH
export PATH="${PATH}:${HOME}/.local/bin"
export PATH="${PATH}:${HOME}/.npm-global/bin"
export PATH="${PATH}:${HOME}/.gem/ruby/2.5.0/bin"
export PATH="${PATH}:${HOME}/.ruby/bin"
export PATH="${PATH}:${HOME}/.rvm/bin"
export PATH="${PATH}:${HOME}/.cargo/bin"
export PATH="${PATH}:${HOME}/bin"
export PATH="${PATH}:${HOME}/.local/bin"
export PATH="${PATH}:${HOME}/.azuquactl"
export PATH="${PATH}:/usr/local/go/bin"
export PATH="${PATH}:${HOME}/code/go/bin"
export PATH="${PATH}:${HOME}/google-cloud-sdk/bin"

if [ -x "$(command -v yarn)" ]; then PATH="$PATH:`yarn global bin`"; fi

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

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  kube-ps1
  wd
)

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh

PROMPT=$PROMPT'$(kube_ps1) '

# ALWAYS
export EDITOR=$(which nvim)

# MISC
alias top='htop'
alias cava='cava -p ~/.config/cava/config'
# no more arch :(
# alias roll='pacaur -Syu && neofetch'
# alias pac-clean='pacaur -Scc'

# AWESOMEWM
alias testawesome='Xephyr -screen 800x600 :1 & sleep 1 ; DISPLAY=:1.0 awesome';

# all things N/VI/M
alias ls='ls --color=auto'
alias vi='nvim'
alias vim='nvim'

# KEYS
#
export GPG_TTY=$(tty)
alias gpg-add='gpg --keyserver keyserver.ubuntu.com --recv';

# AZUQUACTL
#
alias a='azuquactl';

# K8S
#
alias v='vcluster';
alias k='kubectl';
alias kgp='kubectl get pods';
alias kgs='kubectl get services';
alias kdp='kubectl delete pod';
alias kds='kubectl delete service';
alias ktail='kubectl logs -f --tail=10';
alias kloc='kubectl get pods | grep';
alias ksaloc='kubectl get rolebindings,clusterrolebindings -n kubernetes-dashboard -o custom-columns='\''KIND:kind,NAMESPACE:metadata.namespace,NAME:metadata.name,SERVICE_ACCOUNTS:subjects[?(@.kind=="ServiceAccount")].name'\'' | grep';
if [ ! -f "${fpath[1]}/_kubectl" ]; then kubectl completion zsh > "${fpath[1]}/_kubectl"; fi

alias kdbg='kubectl run curl --image=radial/busyboxplus:curl -i --tty'

alias p4tiller='kubectl port-forward -n kube-system $(kubectl get pods -n kube-system -l "app=pontus" -l "component=tiller" -o jsonpath="{.items[0].metadata.name}") 44134'
alias p4argo='kubectl port-forward -n argo $(kubectl get pods -n argo -l "app=argo-server" -l "release=azq-argo" -o jsonpath="{.items[1].metadata.name}") 2746'
alias p4minio='kubectl port-forward -n argo $(kubectl get pods -n argo -l "app=minio" -l "release=azq-argo" -o jsonpath="{.items[0].metadata.name}") 9000'
alias p4thanos='kubectl port-forward -n monitoring $(kubectl get pods -n monitoring -l"app.kubernetes.io/component=query" -o jsonpath="{.items[0].metadata.name}") 10902'

# Minikube
#
#if [ -x "$(command -v minikube)" ]; then source <(minikube completion zsh); fi
if [ -f "$HOME/.minikube-completion" ]; then source $HOME/.minikube-completion; fi

# DOCKER
#
alias docker-clean='docker rmi $(docker images --quiet --filter "dangling=true")';

# SNAP
#
alias snap-clean='snap list --all | awk '\''/disabled/{print $1, $3}'\'' | while read snapname revision; do sudo snap remove "$snapname" --revision="$revision"; done'

# LOGS
#
alias logs-clean='sudo journalctl --vacuum-time=2h && sudo truncate -s 0 /var/log/syslog && sudo truncate -s 0 /var/log/salt/minion && sudo truncate -s 0 /var/log/osquery/osqueryd.results.log'

# NODEJS
#
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# GOLANG
#
export GOROOT="/usr/local/go"
export GOPATH="$HOME/code/go"
if [ ! -d "$GOPATH" ]; then mkdir -p "$GOPATH"; fi

# RUBY
#
#export GEM_HOME="$HOME/.ruby"
#export PATH="$PATH:$HOME/.ruby/bin"

# DOTNET
#
export DOTNET_ROOT=/snap/dotnet-sdk/current

# GOOGLE CLOUD
#
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/austin/google-cloud-sdk/path.zsh.inc' ]; then source '/home/austin/google-cloud-sdk/path.zsh.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '/home/austin/google-cloud-sdk/completion.zsh.inc' ]; then source '/home/austin/google-cloud-sdk/completion.zsh.inc'; fi

# AZUQUA
#
if [ -x "$(command -v azuquactl)" ]; then source <(azuquactl completion zsh); fi

# OKTA
#
export AWS_USER=abrown
alias okta-vpn='cd /home/austin/code/okta-vpn && sudo openvpn --config okta-vpc-dev.ovpn'
alias okta-aws-sts-mfa='aws --profile aws-dmz-mfa sts get-session-token --serial-number "arn:aws:iam::153884899675:mfa/abrown" --token-code'
alias okta-aws-mfa='okta-aws-auth --use-cache -r 14400 -k'

# ASA
#
export PAM_CHARTS_REPO_DIR=/home/austin/code/flo-infra/charts
export ASA_DEVICE_TOOLS_REPO=/home/austin/code/asa/device-tools
alias docker-login-asa='aws --profile azq-prod --region us-west-2 ecr get-login-password | docker login --username AWS --password-stdin 188514508768.dkr.ecr.us-west-2.amazonaws.com'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
