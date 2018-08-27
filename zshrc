export ZSH=/Users/magnus/.oh-my-zsh
ZSH_THEME="spaceship"

plugins=(
  git
  osx
  tmux
  vi-mode
  autojump
  sbt
  scala
  node
  npm
)

source $ZSH/oh-my-zsh.sh
source ~/.bash_profile_local
export SBT_CREDENTIALS=%USERPROFILE%/.sbt/.credentials

alias gp="git push --force-with-lease"
alias vim='nvim'
alias k=kubectl

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
ssh-add ~/.ssh/id_rsa
ssh-add ~/.ssh/sl_rsa
ssh-add ~/.ssh/test.pem
ssh-add ~/.ssh/production.pem

export SBT_CREDENTIALS=~/.sbt/.credentials
export BODDINGTON_ENVIRONMENT_NAME=dev

KEYTIMEOUT=1
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export GOPATH=~/go
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH:$GOPATH/bin"
export GO111MODULE=on

# Completion for spl
source <(spl completion zsh)

source "/Users/magnus/.oh-my-zsh/custom/themes/spaceship.zsh-theme"

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship

# Pull request from command line
function projname() {
  basename $(git rev-parse --show-toplevel)
}

function github_org() {
  git config --get remote.origin.url | ggrep -oP '.*:\K(.*)(?=/.*)'
}

function pr() {
  open "https://github.com/$(github_org)/$(projname)/pull/new/$(git_current_branch)"
}
export PATH="$HOME/.jenv/bin:$PATH"
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
