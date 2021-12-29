
# source `which virtualenvwrapper.sh`
source ~/.bashrc
source ~/.custom.sh
alias weather="curl wttr.in/jessore"
alias dc="docker"
alias ld="pyenv activate localdev"
alias amend="git add . && git ci --amend --no-edit"
alias amendRb="amend && git rb --continue"
alias amendRbPs="amendRb && git ps"
alias rbcont="git add . && git ci --no-edit && git rb --continue"
export NVM_DIR="$HOME/.nvm"
export CMP="$HOME/Desktop/projects/cmp-server"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
alias celery_worker='celery worker --app assets.worker.app:app --loglevel DEBUG --queue extract_zip_and_update_task'
alias run_script='node --require ts-node/register/transpile-only '
alias gocmp="cd $CMP; ld;"
alias rs="gocmp touch server/server.js"
alias gocl="gocmp cd ../cmp-client"
alias goLD="cd $CMP; cd ../localdev; ld;"
alias updateLDdep="goLD cd nc-docker; sudo pip install -e ."
alias dsk="cd ~/Desktop/";
alias ncd='gocmp  nc-docker'
alias du="ld; nc-docker up sso assets channel-service rabbitmq mongo mysql article-query article-query-record-processors sqs permissions --local marketingplatform"
alias minimalist_du="ld; nc-docker up assets analytics-api channel-service --local marketingplatform"
alias cmpu="cmp; yarn --ignore-engines; node --max_old_space_size=2048 $(which grunt);"
alias cmp="cd $CMP && ld  && du && yarn start"
alias cmp2="cd $CMP && ncdu cmp-client marketing-work-request"
alias cmp_light="cd $CMP && ld && minimalist_du && yarn start"
alias ll="ls -lhaG"
alias ncdu="ld; nc-docker up"
alias ncdb='gocmp  nc-docker build'
alias ncdd="ld; nc-docker down"
alias ncdps="ld; nc-docker ps"
alias shell="ld;  nc-docker shell"
alias lg="ld; nc-docker logs -ft --tail 100"
alias ncdt="nc-docker test"
alias tc="ncdt cmp-client contract-test"
alias tb="gocmp yarn test"
alias tf="gocl yarn test"
alias tl="cd $CMP && ld; yarn run lint --fix"
alias smp='nc-docker up assets channel-service permissions article-query article-query-record-processors sso sqs marketing-work-request localstack --local cmp-server'
alias gpm="git checkout master; git pull newscred master; git co -"
alias gco='git checkout'
alias pro='nvim $HOME/.bash_profile'
alias source_profile='source $HOME/.bash_profile'
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
export PATH="$PATH:$HOME/Desktop/flutter/bin"
alias cleanIndices='nc-docker exec article-query "./ncbuild clean_indices" && cd $CMP && yarn reindex-data'
alias publishSeed='nc-docker exec analytics-api "/code/docker/run-data-seed.sh"'
export PATH="$PATH:$HOME/Desktop/mongodb-osx-x86_64-3.6.17/bin"
# Git branch in prompt.

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] λ "

_nc_docker_completion() {
    COMPREPLY=( $( env COMP_WORDS="${COMP_WORDS[*]}" \
                COMP_CWORD=$COMP_CWORD \
                _NC_DOCKER_COMPLETE=complete $1 ) )
    return 0
}

complete -F _nc_docker_completion -o default nc-docker
force_color_prompt=yes
export LC_ALL=en_US.UTF-8
alias pullAll='nc-docker pull assets analytics-api sso channel-service article-query article-query-record-processors rabbitmq redis mongo mysql file-server sqs file-server-internal marketingplatform'
export PATH="/usr/local/opt/python@3.8/bin:$PATH"

_mkcd() {
  mkdir -p "$1" && cd "$1"
}
alias mkcd=_mkcd

_fetchCo() {
  IN="$1"
  arrIN=(${IN//:/ })
  git fetch ${arrIN[0]} ${arrIN[1]} && git co ${arrIN[1]}
}
alias fetchCo=_fetchCo

_crbr() {
  echo 'stash everything'
  git stash
  echo 'move to master and pull latest'
  gpm
  echo 'creating brach'
  git co -b "$1"
  echo 'done'
}
alias crbr=_crbr


_gitPull() {
  cd $CMP && cd ../ 
  for f in *; do  
    (echo "***************** ${f} *****************" && cd $f && gpm  && cd ../) || (echo "^^^^^^^^^^^^^^^^^^^^ failed ${f} ^^^^^^^^^^^^^^^^^^^" && cd ../) ;
  done  
}

alias gitPull=_gitPull


_spro() {
  currentDir=$(pwd)
  source $HOME/.bash_profile
  echo 'Sourcing done'
  # rm -r ~/Desktop/aliasAndFunction/.bash_profile 
  # echo 'removing done'
  cp ~/.bash_profile ~/Desktop/aliasAndFunction/.bash_profile
  echo 'copying done'
  cd ~/Desktop/aliasAndFunction 
  echo 'moved to git folder'
  git add . && git ci -m "$1 - updated at - `date`" && git ps;
  echo "push done"
  echo 'sourcing bash profile'
  source_profile
  echo 'moving to current directory'
  cd $currentDir
}

alias spro=_spro

_quickRebase() {
  echo 'moving to master and pull latest'
  gpm
  echo 'moving to current branch'
  git co "$1"
  echo 'rebase'
  git rb master
}

alias quickRebase=_quickRebase
# Create a stable channel PR from edge channel PR
#
#    git-stable-pr 1234 some-name
#
# 1: the PR number in edge channel
# 2: label used to name new branch
git-stable-pr() {
  git remote get-url edge 2>/dev/null || git remote add edge git@github.com:newscred/cmp-client.git
  git fetch edge master

  git remote get-url stable 2>/dev/null || git remote add stable git@github.com:newscred/cmp-client-stable.git
  git fetch stable master

  BR=$(printf -- "-%s" "$@" | awk '{print substr($1, 2)}')
  git fetch edge pull/$1/head:pr/$BR
  git co pr/$BR

  git rebase --onto stable/master $(git merge-base HEAD edge/master) pr/$BR
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
