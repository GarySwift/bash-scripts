# Bash Scripts

Located in `~/Documents/Bash`

### Example Usage

Type `merge` in any terminal window and return

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

This uses an alias to to run the `git-merge.sh` script located in `~/Documents/Bash/`.

```
alias merge='sh ~/Documents/Bash/git-merge.sh'
```