#!/bin/bash
export RED='\033[0;31m'
export RED='\033[01;31m'
export GREEN='\033[0;32m'
export GREEN='\033[01;32m'
export YELLOW='\033[01;33m'
export PURPLE='\033[01;35m'
export CYAN='\033[01;36m'
export WHITE='\033[37m'
export BOLD='\033[1m'
export NONE='\033[00m'
export NC='\033[0m' # No Color
export bold=$(tput bold)
# export italic=$(tput italic)
export normal=$(tput sgr0)
export UNDERLINE='\033[4m'

export GREEN_BG='\033[42m'
export BLUE_BG='\033[44m'
export BLACK_BG='\033[40m'
# https://www.howtogeek.com/307701/how-to-customize-and-colorize-your-bash-prompt/
# sh $PWD/wordpress-debug.sh
# sh $PWD/wordpress-assets.sh
# sh $PWD/git-clone-foundationpress.sh
# sh ~/bash-scripts/git-clone-foundationpress.sh
# sh ~/bash-scripts/wordpress-debug.sh
# sh ~/bash-scripts/wordpress-assets.sh
# 
# echo -e "This text is ${RED}red${NONE} and ${GREEN}green${NONE} and ${BOLD}bold${NONE} and ${UNDERLINE}underlined${NONE}."