#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
reponame="https://github.com/olefredrik/FoundationPress.git"
# reponame="https://github.com/GarySwift/bash-scripts"
# Ask the user for a theme folder name
printf "Please enter theme folder name:\n"
read themename

# if [ $themename -eq 0 ]
#   then
#     echo "No arguments supplied"
# fi
# if [[ $themename = *[!\ ]* ]]; then
#   echo "\$param contains characters other than space"
# else
#   echo "\$param consists of spaces only"
# fi
# if  test $themename = "[0-9A-Za-z]*"

#     then echo "string $themename has alphabets which are only alpha numeric"

#     else echo "string $themename has characters which are not alphanumeric"

# fi
if ! [[ $themename =~ [^a-zA-Z0-9\-_] ]]; then
  # echo "VALID"
  :
else
  echo "INVALID"
fi
# printf "exiting...\n"
# exit

# Cofirm action
printf "This will clone directory into:\n"
printf "${GREEN}"$PWD/$themename"${NC}\n"
printf "Continue? [y/N] "
read verfiy
# Check result
if [[ $verfiy =~ ^[Yy]$ ]]
then
	# clone repo
	# Shell scripts are run inside a subshell, and each subshell has its own concept of what the current directory is. 
	# The cd succeeds, but as soon as the subshell exits, you're back in the interactive shell and nothing ever changed there.
	git clone $reponame $PWD/$themename
	# cd $PWD/$themename
	
	# echo "cd $themename"
	# exec bash
	cd $PWD/$themename
	ls -1
else
    printf "Abort.."
    exit
fi

printf "\nnpm install? [y/N] "
read verfiy
# Check result
if [[ $verfiy =~ ^[Yy]$ ]]
then
	npm install
else
    printf "Abort.."
    exit
fi

printf "\nnpm start? [y/N] "
read verfiy
# Check result
if [[ $verfiy =~ ^[Yy]$ ]]
then
	npm start
	exit
else
    printf "Abort.."
    exit
fi

printf "\nopen? [y/N] "
read verfiy
# Check result
if [[ $verfiy =~ ^[Yy]$ ]]
then
	subl $PWD/$themename
	exit
else
    printf "Abort.."
    exit
fi