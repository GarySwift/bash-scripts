# Bash Scripts

### Installation
Clone this repo into the new directory.

```
git -C ~/ clone https://github.com/GarySwift/bash-scripts.git && cd ~/bash-scripts && ls -1
```

### Example Usage

Open bash_profile

```
open ~/.bash_profile
```

Add this new alias

```
alias merge='sh ~/Documents/Bash/git-merge.sh'
```

Restart terminal

Type `merge` in any terminal window and return


#### Result:

```
mac@~$ merge

How to do a git merge in Vim:

1) press "i"
2) write your merge message
3) press "esc"
4) write ":wq"
5) then press enter

https://stackoverflow.com/questions/19085807/please-enter-a-commit-message-to-explain-why-this-merge-is-necessary-especially
mac@~$ 
```

