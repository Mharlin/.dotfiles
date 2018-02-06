export SBT_CREDENTIALS=~/.sbt/.credentials
export BODDINGTON_ENVIRONMENT_NAME=dev

export CLICOLOR=1

if [ -f /usr/local/share/gitprompt.sh ]; then
  GIT_PROMPT_THEME=Default
  . /usr/local/share/gitprompt.sh
fi

ssh-add ~/.ssh/id_rsa
ssh-add ~/.ssh/sl_rsa

alias vim='nvim'

