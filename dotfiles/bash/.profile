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
#  if [ "`stat -fc %T .`" == "nfs" ];
#  then
#  	echo "-";
#  else
#  	[[ $(git status --porcelain 2> /dev/null | tail -n1) != "" ]] && echo "*"
#  fi
  	[[ $(git status --porcelain 2> /dev/null) != "" ]] && echo "*"
#	git diff --quiet --ignore-submodules HEAD &>/dev/null
#	(($? == 1)) && echo '*'
}

function parse_git_branch {
	git rev-parse --is-inside-work-tree &>/dev/null || return
	# git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
	# git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ \(\1\)/"
	#git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ \(\1$(parse_git_dirty)\)/"
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

export PATH=~/bin:$PATH

export EDITOR=vim

test -f ~/bin/git-completion.bash && . $_

# Usage: releaseTickets release-1497 release-1498
releaseTickets() {
    git log $1..$2 | \
	egrep -io 'NUT-\d+' | \
	tr 'a-z' 'A-Z' | \
	uniq | \
	sort | \
	sed -e 's/^/https:\/\/nutshell.atlassian.net\/browse\//'
}

# Usage: releaseTickets release-1497 release-1498
openReleaseTickets() {
    releaseTickets $1 $2 | xargs open
}

removeAwsHostKey () {
       ssh-keygen -R $1 -f /Users/flav/.ssh/aws_hosts
}

loopGif() {
       echo convert -loop 0 $1
}

connectDocker() {
	screen ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/tty
}

alias ls="ls -GF"
alias grep="grep --color=auto"
alias cgd='cd $(gd=$(git rev-parse --git-dir); echo ${gd%.git*}./)'
alias cb='git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'
alias fixcam="sudo killall VDCAssistant"

## Nutshell nub
NUBHOME=/Users/flav/source/nutshell.com/projects
if [[ -d "$NUBHOME/nub" ]]; then
   eval "$($NUBHOME/nub/bin/nub init -)"
fi

# misc specific env files to include
if [ -d ~/vault/env ]; then
  for e in ~/vault/env/*; do
    source $e;
  done
fi

export VAGRANT_MOUNT_ALL_WWW=1

alias weather="curl -s http://wttr.in/arb |head -n 17 |tail -n 10"
alias ag='ag --path-to-ignore ~/.ignore'

alias pair='echo "Committing as: `git config user.name` <`git config user.email`>"'
alias unpair="git config --remove-section user 2> /dev/null; echo Unpaired.; pair"
alias pairml="git config user.pair 'FDC+ML' && git config user.name 'Flavio daCosta and Mike Linington' && git config user.email 'developers+fdacosta+mlinington@nutshell.com'; pair"

alias clean-url="sed -e 's/%5B/[/g' -e 's/%5D/]/g' -e 's/%2C/,/g'"
alias boom="pbpaste | json_pp | pbcopy"
alias aws-nut-ec2="aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" --query 'Reservations[*].Instances[*].[Tags[?Key==\`Name\`] | [0].Value,InstanceId,InstanceType,PrivateIpAddress,PublicIpAddress] | [] | [*].{Value:[0],InstanceId:[1],InstanceType:[2],PrivateIpAddress:[3],PublicIpAddress:[4]} | sort_by(@, &Value)[*].[Value,InstanceId,InstanceType,PrivateIpAddress,PublicIpAddress]' --output table"
