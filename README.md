
# Bash Scripts

### Example Usage
Use an alias to to run the `git-merge.sh` script located in `~/Documents/Bash/`.

Create a [new directory](http://pubs.opengroup.org/onlinepubs/009695399/utilities/mkdir.html) in Documents folder.

```
mkdir -p ~/Documents/Bash && cd $_

```

Clone this repo into the new directory.

```
git -C ~/ clone https://github.com/GarySwift/bash-scripts.git && cd ~/bash-scripts && ls -1
```

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


### Result:

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

### Environment Variables

Some scripts such as `wordpress.sh` require a hidden `.env` file that is not saved in version control. You should create this using the following:

```
touch ~/bash-scripts/.env && open ~/bash-scripts/.env
```

This should store the variables shown below (fill in your own details):

```
export DEFAULT_DIR="~/Code"
export DEAFALT_CODE_DIR=/Users/YOUR_USER_NAME/Code

export DEFAULT_TITLE="WordPress Site"
export DEFAULT_EMAIL=
export DEFAULT_USER=
export DEFAULT_PASSWORD=
 
export DBHOST=localhost
export DBUSER=
export DBPASS=  

export DEAFALT_REPO="https://github.com/olefredrik/FoundationPress.git"
```
