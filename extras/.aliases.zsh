#!/usr/bin/env zsh
export ONI_HOME=${CODE_HOME}/oni
export CONFIG_DIR=${HOME}/.config

# run `kc` to see your kubernetes contexts
[[ -f ${HOME}/.contexts ]] && source ${HOME}/.contexts # create this file in your $HOME directory
[[ -z "${PROD_CONTEXT}"    ]] && export PROD_CONTEXT=my-prod-context
[[ -z "${QA_CONTEXT}"      ]] && export QA_CONTEXT=my-qa-context
[[ -z "${DEV_CONTEXT}"     ]] && export DEV_CONTEXT=my-dev-context
[[ -z "${SANDBOX_CONTEXT}" ]] && export SANDBOX_CONTEXT=my-sandbox-context
[[ -z "${LOCAL_CONTEXT}"   ]] && export LOCAL_CONTEXT=my-local-context

show_all_help() {
    local aliases=$(alias | grep 'help=' | awk -F'=' '{ print $1 }' | awk '{ print $2 }')
    while read line; do
        name=$(echo $line | awk -F'=' '{ print $1 }')
        msg=$(? $name)
        printf "%15s    %-s\n" $name "$msg"
    done < <(alias | grep 'help=')
}

show_help() {
    if [[ -z "$@" ]]; then
        show_all_help
        return 0
    fi
    a=$(alias $@)
    msg=$(echo -en "$a" | awk -F'help=' '{ print $2 }' | awk -F';' '{ print $1 }')
    echo -e "$msg" | tr -d '"'
}

# Core aliases (update paths and commands as necessary for Zsh compatibility)
alias brc='help="clean up git branches"; branch-cleanup'
alias branch-cleanup='$ONI_HOME/bin/branch-cleanup.sh'
alias branch='help="export and echo current branch"; export BRANCH=$(git branch | grep "*" | awk "{ print \$2 }") && echo $BRANCH'
alias branches='help="show all branches"; git branch -a | grep -v "remotes" | tr -d "*" | awk "{ print \$1 }"'
alias config='help="configure the project defaults"; project; cd ${CODE_HOME}/${PROJECT} && cat $ONI_HOME/extras/.gitignore.template > ./.gitignore'
alias d='help="list running containers in project"; project; echo -e "CONTAINER ID    NAMES";docker ps -a --format="table {{.ID}}    {{.Names}}" | grep $PROJECT'
alias ff='help="tldr fuzzy finder"; tldr --list | fzf --preview "tldr {1} --color=always" --preview-window=right,70% | xargs tldr'
alias flush='help="flush all dev stores"; flush-etcd; flush-redis'
alias flush-etcd='help="flush etcd"; etcdctl del "" --prefix 2> /dev/null'
alias flush-redis='help="flush redis"; docker exec -it redis.${PROJECT} redis-cli flushall 2> /dev/null'
alias g='help="lazy git push"; project && git add . && git commit -m "pipeline test" && git pull && git push'
alias killall='help="kill all project apps"; for pid in $(ps -ef | grep -i $PROJECT | grep "__debug\|source" | grep -v "grep" | awk "{print $2}"); do kill -9  $pid; done'
alias p='help="initialize project"; project && echo $PROJECT'
alias post='help="curl POST helper"; curl -H "Content-Type: application/json" -X POST'
alias get='help="curl GET helper"; curl -H "Content-Type: application/json" -X GET'
alias project='export PROJECT=${PWD##*/}; src; [[ -f venv/bin/activate ]] && source $ONI_HOME/extras/.aliases && source venv/bin/activate || echo $PROJECT &> /dev/null'
alias remake='help="go clean make all"; make clean && go mod vendor && go mod tidy && make all'
alias greset='help="git reset project"; git reset --hard $(branch)'
alias start='help="start a python application"; project; kenv up; project; python app.py'
alias src='help="source .env file"; setopt allexport; [[ -f .env ]] && source .env; unsetopt allexport'
alias tag='help="show branch tag"; branch && [[ $BRANCH != "master" ]] || echo $(git tag | tail -1)'
alias update='help="update python libraries"; project; pip uninstall -r requirements.txt --yes && pip install -r requirements.txt --upgrade --force --no-cache-dir'
alias uuid='help="generate uuid"; uuidgen | tr [:upper:] [:lower:]'
alias nvc='help="reset neovim config"; cp $ONI_HOME/nvim/lua/user/init.lua $CONFIG_DIR/nvim/lua/user/init.lua && cp $ONI_HOME/nvim/init.lua $CONFIG_DIR/nvim/init.lua'
alias palette='help="show terminal colors"; $ONI_HOME/bin/colors.sh'
alias dt='help="show diff in git tags"; $ONI_HOME/bin/diff-tags'
alias tokens='help="estimate GPT token count"; wc -w --libxo=json | jq ".wc.file[0].words"'
alias '?'='help="show alias help message: ? [alias]"; show_help'

# K8S shortcuts
alias h='help="helm alias for current project"; project && helm -n $PROJECT'
alias kt='help="tail k8s logs"; project; stern --color always --exclude "^.*healthz.*$" -n $PROJECT ".*"'
alias k='help="kubectl alias for current project"; project && kubectl -n $PROJECT'
alias w='help="watch all k8s objects in current project"; project && watch -n5 "kubectl -n $PROJECT get all"'
alias proxy='help="local proxy to current service"; project; $ONI_HOME/bin/kube-proxy.sh $PROJECT'
alias forward='help="local forward of current service"; project; $ONI_HOME/bin/kube-forward.sh $PROJECT'
alias top-pods='help="top readout of pods in current project"; project && watch -n5 "kubectl -n $PROJECT top pods"'
alias top-nodes='help="top readout of nodes"; project && watch -n5 "kubectl -n $PROJECT top nodes"'
alias kc='help="list k8s contexts"; kubectl config get-contexts'

# K8S contexts
alias prod='help="switch to PROD k8s context"; kubectl config use-context ${PROD_CONTEXT}; export ENVIRONMENT=PROD'
alias qa='help="switch to QA k8s context"; kubectl config use-context ${QA_CONTEXT}; export ENVIRONMENT=QA'
alias dev='help="switch to DEV k8s context"; kubectl config use-context ${DEV_CONTEXT}; export ENVIRONMENT=DEV'
alias sb='help="switch to SANDBOX k8s context"; kubectl config use-context ${SANDBOX_CONTEXT}; export ENVIRONMENT=SANDBOX'
alias loc='help="switch to LOCAL k8s context"; kubectl config use-context ${LOCAL_CONTEXT}; export ENVIRONMENT=LOCAL'

# Comment out the Bash-specific kubectl completion
# complete -F __start_kubectl kubectl

# Oni shortcuts
alias cpnvim='help="copy running nvim config to oni"; cp -rf ~/.config/nvim/* ${ONI_HOME}/nvim; rm -rf ${ONI_HOME}/tmux/plugins'
alias cptmux='help="copy running tmux config to oni"; cp -f ~/.config/tmux/* ${ONI_HOME}/tmux'
alias cpwezterm='help="copy running wezterm config to oni"; cp -f ~/.config/wezterm/* ${ONI_HOME}/wezterm'
