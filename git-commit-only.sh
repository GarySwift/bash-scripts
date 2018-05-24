#!/bin/bash
printf 'Enter your commit message: '
read msg
git commit -m "$msg"

exit
# Notes
# alias add="echo 'git add .' && git add ."
# alias push="echo 'git push -u origin master' && git push -u origin master"
# alias stat="echo 'git status' && git status"
# alias com="sh ~/Documents/Bash/git-commit-only.sh"
# alias commit="sh ~/Documents/Bash/git-commit.sh"