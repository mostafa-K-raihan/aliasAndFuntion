source `which virtualenvwrapper.sh`
source ~/.bashrc
source ~/.custom.sh
alias ld="pyenv activate localdev"
alias amend="git add . && git ci --amend --no-edit"
alias amendRb="amend && git rb --continue"
alias amendRbPs="amendRb && git ps"
alias rbcont="git add . && git ci --no-edit && git rb --continue"
export NVM_DIR="$HOME/.nvm"
export CMP="$HOME/Desktop/projects/marketingplatform/"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
alias celery_worker='celery worker --app assets.worker.app:app --loglevel DEBUG --queue extract_zip_and_update_task'
alias gocmp="cd $CMP; ld;"
alias goLD="cd $CMP; cd ../localdev; ld;"
alias updateLDdep="goLD cd nc-docker; sudo pip install -e ."
alias dsk="cd ~/Desktop/";
alias ncd='gocmp  nc-docker'
alias du="ld; nc-docker up  sso assets publishing-service channel-service analytics-api redis rabbitmq mongo mysql marketing-work-request article-query article-query-record-processors sqs pitchmanager --local marketingplatform"
alias cmpu="cmp; yarn --ignore-engines; node --max_old_space_size=2048 $(which grunt);"
alias cmp="cd $CMP && ld  && du && yarn start"
alias ll="ls -lhaG"
alias ncdu="ld; nc-docker up"
alias ncdb='gocmp  nc-docker build'
alias ncdd="ld; nc-docker down"
alias ncdps="ld; nc-docker ps"
alias shell="ld;  nc-docker shell"
alias log="ld; nc-docker logs -ft --tail 100"
alias tb="cd $CMP && ld; yarn run server-test"
alias tf="cd $CMP && ld; yarn run client-test"
alias tfs="gocmp  yarn run client-test --single-run"
alias tl="cd $CMP && ld; yarn run lint --fix"
alias gpm="git checkout master; git pull newscred master"
alias gco='git checkout'
alias pro='vi $HOME/.bash_profile'
alias spro='source $HOME/.bash_profile'
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
export PATH="$PATH:$HOME/Desktop/flutter/bin"
alias cleanIndices='nc-docker exec article-query "./ncbuild clean_indices'
export PATH="$PATH:$HOME/Desktop/mongodb-osx-x86_64-3.6.17/bin"
export PS1="\W ξ "
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

_gitPull() {
  cd $CMP && cd ../ 
  for f in *; do  
    (echo "***************** ${f}" && cd $f && gpm  && cd ../) || (echo "^^^^^^^^^^^^^^^^^^^^ failed ${f}" && cd ../) ;
  done  
}

alias gitPull=_gitPull


_spro() {
  source $HOME/.bash_profile
  echo 'Sourcing done'
  rm -r ~/Desktop/aliasAndFunction/.bash_profile 
  echo 'removing done'
  cp ~/.bash_profile ~/Desktop/aliasAndFunction/.bash_profile
  echo 'copying done'
  cd ~/Desktop/aliasAndFunction 
  echo 'moved to git folder'
  git add . && git ci -m "updated at - `date`" && git ps;
  echo "push done"
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
