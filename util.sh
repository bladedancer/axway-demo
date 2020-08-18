#!/bin/bash

readonly  reset=$(tput sgr0)
readonly  red=$(tput bold; tput setaf 1)
readonly  green=$(tput bold; tput setaf 2)
readonly yellow=$(tput bold; tput setaf 3)
readonly   blue=$(tput bold; tput setaf 6)
readonly   colreset=$(tput bold; tput setaf 9)

WAIT_TIMEOUT=0

##
# wait for user to press ENTER
# if $WAIT_TIMEOUT > 0 this will be used as the max time for proceeding automatically
##
function wait() {
  if [[ $NO_WAIT ]]; then
    return
  fi

  if [[ "$WAIT_TIMEOUT" == "0" ]]; then
    read -rs
  else
    read -rst "$WAIT_TIMEOUT"
  fi
}

function desc() {
    maybe_first_prompt
    echo -e "$blue# $@$reset"
    prompt
    wait
}

function prompt() {
    echo -n "$yellow\$ $reset"
}

function show() {
  rate=25
  if [ -n "$DEMO_RUN_FAST" ]; then
    rate=1000
  fi
  if [[ $NO_WAIT ]]; then
    echo "${green}cat $1$reset" | pv -qL $rate
  else 
    echo "${green}vi $1$reset" | pv -qL $rate
  fi
  if [ -n "$DEMO_RUN_FAST" ]; then
    sleep 0.5
  fi

  if [[ $NO_WAIT ]]; then
    cat $1
  else
    vi $1
  fi
  prompt
}

started=""
function maybe_first_prompt() {
    if [ -z "$started" ]; then
        prompt
        started=true
    fi
}

function backtotop() {
    clear
}

function run() {
    rate=25
    if [ -n "$DEMO_RUN_FAST" ]; then
      rate=1000
    fi
    echo "$green$1$reset" | pv -qL $rate
    if [ -n "$DEMO_RUN_FAST" ]; then
      sleep 0.5
    fi
    eval "$1"
    r=$?
    read -d '' -t 1 -n 10000 # clear stdin
    prompt
    wait
    return $r
}

function nowait_run() {
    rate=25
    if [ -n "$DEMO_RUN_FAST" ]; then
      rate=1000
    fi
    echo "$green$1$reset" | pv -qL $rate
    if [ -n "$DEMO_RUN_FAST" ]; then
      sleep 0.5
    fi
    eval "$1"
    r=$?
    read -d '' -t 1 -n 10000 # clear stdin
    prompt
    return $r
}


function bgrun() {
    maybe_first_prompt
    rate=25
    if [ -n "$DEMO_RUN_FAST" ]; then
      rate=1000
    fi
    echo "$green$1$reset" | pv -qL $rate
    if [ -n "$DEMO_RUN_FAST" ]; then
      sleep 0.5
    fi
    $($@) &
    r=$?
    read -d '' -t 1 -n 10000 # clear stdin
    prompt
    wait
    return $r
}

function relative() {
    for arg; do
        echo "$(realpath $(dirname $(which $0)))/$arg" | sed "s|$(realpath $(pwd))|.|"
    done
}

function check_pv() {
  command -v pv >/dev/null 2>&1 || {

    echo ""
    echo -e "${red}##############################################################"
    echo "# HOLD IT!! I require pv but it's not installed.  Aborting." >&2;
    echo -e "${red}##############################################################"
    echo ""
    echo -e "${colreset}Installing pv:"
    echo ""
    echo -e "${blue}Mac:${colreset} $ brew install pv"
    echo -e "${blue}Ubuntu:${colreset} $ sudo apt install pv"
    echo -e "${blue}Other:${colreset} http://www.ivarch.com/programs/pv.shtml"
    echo -e "${colreset}"
    exit 1;
  }
}

#SSH_NODE=$(kubectl get nodes | tail -1 | cut -f1 -d' ')

check_pv
trap "echo" EXIT