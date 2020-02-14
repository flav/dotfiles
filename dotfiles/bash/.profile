case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*|interix)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
    ;;
  screen)
    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\033\\"'
    ;;
  *)
    PROMPT_COMMAND='true'
    ;;
esac

# man console_codes
#       -- Makes the sequence not take any actual terminal spaces
#      /  -- escape sequence to start colors
#      | /   -- color selections separated by a ;
#      | |  /    -- Code for setting attributes
#      | |  |   / -- Close the initial [ - so command line wrap is correct.
#      |_|__|___|/_
# GRN="\[\e[1;32m\]"

GRN="\[\e[1;32m\]"
RED="\[\e[1;31m\]"
NOR="\[\e[0;39;49;27m\]"
if [ `id -u` = 0 ]; then
  export TMOUT=900 # 15 minute timeout
  ROOT="\[\e[1;4;37;41m\]"
fi
#PS1="$TITLE[$RED$ROOT\u$NOR@$GRN\H$NOR \W]\\$ "
#PS1="[$RED$ROOT\u$NOR@$GRN\H$NOR \W]\\$ "

function parse_git_dirty {
  [[ $(git status --porcelain 2> /dev/null) != "" ]] && echo "*"
}

function parse_git_branch {
  git rev-parse --is-inside-work-tree &>/dev/null || return
  git symbolic-ref -q HEAD | sed -e "s|^refs/heads/\(.*\)| \(\1$(parse_git_dirty)\)|" 2>/dev/null
}

function __git_pair_prompt {
  [ `git config user.pair` ] && echo " (pair: `git config user.pair`)"
}

# https://github.com/ahmetb/kubectx
# https://github.com/jonmosco/kube-ps1
if [ -f "/usr/local/opt/kube-ps1/share/kube-ps1.sh" ]; then
  source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
  kubeoff
fi

alias kctx=kubectx
alias kns=kubens

function _kube {
  if [ "`type -t kube_ps1`" == "function" ]; then
    kube_ps1
  fi
}

COL="\[\e[1;34m\]"
#PS1="[$RED$ROOT\u$NOR@$GRN\H$NOR \W\$(parse_git_branch)]\\$ "
PS1="⌁ $RED$ROOT\u$NOR@$GRN\H$NOR:\w\$(parse_git_branch)\$(__git_pair_prompt)\$(_kube)\n${COL}❯$NOR "

HISTCONTROL=ignoredups:ignorespace
HISTSIZE=10000
# preserve history across multiple sessions (append after each command)
export PROMPT_COMMAND="$PROMPT_COMMAND; history -a"

export PATH="~/bin:$PATH:/usr/local/opt/mysql-client/bin:/usr/local/sbin"

export EDITOR=vim

test -f ~/bin/git-completion.bash && . $_

removeAwsHostKey () {
  ssh-keygen -R $1 -f /Users/flav/.ssh/aws_hosts
}

loopGif() {
  echo convert -loop 0 $1
}

connectDocker() {
  screen ~/Library/Containers/com.docker.docker/Data/vms/0/tty 
}

secureInput() {
  ioreg -l -w 0 | grep SecureInput
}

# misc specific env files to include
if [ -d ~/vault/env ]; then
  for e in ~/vault/env/*; do
    source $e;
  done
fi

alias ls="ls -GF"
alias grep="grep --color=auto"
alias cgd='cd $(gd=$(git rev-parse --git-dir); echo ${gd%.git*}./)'
alias fixcam="sudo killall VDCAssistant"

alias weather="curl -s http://wttr.in/arb |head -n 17 |tail -n 10"
alias ag='ag --path-to-ignore ~/.ignore'

alias clean-url="sed -e 's/%5B/[/g' -e 's/%5D/]/g' -e 's/%2C/,/g'"
alias boom="pbpaste | json_pp | pbcopy"
