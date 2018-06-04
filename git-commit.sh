#!/bin/bash
clear
echo 'git remote -v'
git remote -v
echo 'git add .'
git add .
echo 'git status'
git status
printf 'Enter your commit message: '
read msg
git commit -m "$msg"
echo 'git push -u origin master' && git push -u origin master