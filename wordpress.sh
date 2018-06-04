#!/bin/bash

FILE=$1

# This script relies on two other files.
# .env stores settings such as usernames and passwords
# _settings.sh stores settings such as font colours
# We do a check to see if these files exist first
if [ ! -f ~/bash-scripts/.env ]
then
	echo ".env does not exist in ~/bash-scripts"  
	echo "Aborted"
	exit
fi
if [ ! -f ~/bash-scripts/_settings.sh ]
then
	echo "_settings.sh does not exist in ~/bash-scripts"  
	echo "Aborted"
	exit
fi

source ~/bash-scripts/.env
source ~/bash-scripts/_settings.sh

# Check the user is in the default code directory
if [ $PWD != $DEAFALT_CODE_DIR ] ; then
	echo "Please switch to default code directory: "
	echo ${GREEN}cd $DEFAULT_DIR${NC}
	echo ${RED}"Aborted"${NC}
	exit		
fi

# This script outputs a lot of text so we will clear the console before we start
clear

# Intro messages
echo "${BLUE_BG}${WHITE}   ~ WORDPRESS INSTALL SCRIPT ~   ${NC}"
echo "Follow the prompts below to create a \nclean install of the latest WordPress."
echo "${GREEN}${bold}Let's step through this${normal}${NC}"

# Do a loop until we have a valid Sitename
while true
do
	printf "${PURPLE}Sitename${NC}"
	read -p " (WordPress Site): " title

	# Set default if not input
	if [ "${title}" == "" ] ; then
	  title=$DEFAULT_TITLE
	fi

	# Strip out spaces from the user input
	folder=${title// /} 
	theme_folder=$folder

	# Check for valid characters a-z, A-Z, 0-9, -
	if [[ "$folder" =~ [^a-zA-Z0-9-] ]]; then
		echo ${red}"Invalid characters${NC}"
	else
		folder=$(tr '[:upper:]' '[:lower:]' <<< "$folder")
		folder=$(tr '[:alnum:]' '[:alnum:]' <<< "$folder")
		db=wp_$folder
		url=$folder".loc"

		# Check if folder alreadt exists
		if [ -d "$folder" ]; then
			echo "${RED}This folder $folder already exists${NC}"
		else
			location=${DEAFALT_CODE_DIR}/${folder}/
			root=${folder}/public		
			break
		fi	
	fi	
done

# Do a loop until we have a valid Themename
while true
do
	printf "${PURPLE}Themename${NC}"
	read -p " ("$theme_folder"Press): " themename
	if [ "${themename}" == "" ] ; then
	  themename=${theme_folder}'Press'
	fi 
	if [[ "$themename" =~ [^a-zA-Z0-9-] ]]; then
	    echo "${RED}Invalid characters${NC}"
	else
		break 	
	fi
done

# Do a loop until we have a valid email
while true
do
	printf "${PURPLE}Email${NC}"
	read -p " (${DEFAULT_EMAIL}): " email
	if [ "${email}" == "" ] ; then
	  email=${DEFAULT_EMAIL}
	fi
	# Basic email validation
	if [[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$ ]]; then
	  : # : is a null command in bash
	  break
	else
	    echo "${RED}Invalid email${NC}"
	fi 
done

# Do a loop until we have a valid user
while true
do
	printf "${PURPLE}User${NC}"
	read -p " (${DEFAULT_USER}): " user
	if [ "${user}" == "" ] ; then
		user=$DEFAULT_USER
	fi 
	# if [[ "$user" =~ [^a-zA-Z0-9-_] ]]; then
	#     echo "${RED}Invalid characters${NC}"
	# else
	# 	echo $user
	# 	break 	
	# fi
	if [[ "$user" =~ [^a-zA-Z0-9-] ]]; then
	    echo "${RED}Invalid characters${NC}"
	else
		echo $user
		break 	
	fi	
done

printf "${PURPLE}Password:${NC} "
read -s password
if [ "${password}" == "" ] ; then
  # password=$(openssl rand -base64 21)
  password=$DEFAULT_PASSWORD
fi

echo "\n${GREEN}${bold}Please review the details below${normal}${NC}"
echo "${PURPLE}Sitename:${NC}  "$title
echo "${PURPLE}Folder:${NC}    "$folder
echo "${PURPLE}Location:${NC}  "$location
echo "${PURPLE}Root:${NC}      "$root
echo "${PURPLE}Database:${NC}  "$db
echo "${PURPLE}Themename:${NC} "$themename
echo "${PURPLE}URL:${NC}       "$url
echo "${PURPLE}Email:${NC}     "$email
echo "${PURPLE}User:${NC}      "$user
echo "${PURPLE}password:${NC}  "${BLACK_BG}${password}${NC}
echo

printf "${GREEN}${bold}Confirm? ${normal}${NC}[y/N] "
read verfiy
# Check result
if [[ $verfiy =~ ^[Yy]$ ]]
then
	echo "Installing WordPress..."
	mkdir $folder
	cd $folder
	mkdir public
	cd public
	wp core download
	wp core config --dbhost=$DBHOST --dbname=$db --dbuser=$DBUSER --dbpass=$DBPASS


	# wp core config --dbhost=localhost --dbname=testdb4 --dbuser=root --dbpass=root
	# wp config create --dbhost=$DBHOST --dbname=$db --dbuser=$DBUSER --dbpass=$DBPASS
	wp db create
	rm wp-config.php
	echo "\n${GREEN}${bold}Good News${normal}${NC}"
	echo "You downloaded the latest WordPress core into ${bold}"$location"public${normal}"
	echo "You have created the empty database ${bold}"$db"${normal} in the Mamp Pro SQL database directory."
	
	echo "\n${GREEN}${bold}Next Steps${normal}${NC}"
	echo "1) Create new host in Mamp Pro using ${bold}"$url"${normal} as host. "
	echo "2) Select ${bold}"$location"public${normal} as root."
	echo "3) Go to ${bold}http://"$url"${normal} in a browser."
	echo "4) Create a new config file using the following details:\n"

	echo "${PURPLE}Database Name${NC}   "$db
	echo "${PURPLE}Username${NC}	"$DBUSER
	echo "${PURPLE}Password${NC}	"${BLACK_BG}${DBPASS}${NC}
	echo "${PURPLE}Database Host${NC}	localhost"
	echo "${PURPLE}Table Prefix${NC}	"$db"_\n"

	echo " >> ${bold}Submit${normal}"
	echo " >> ${bold}Run the installation${normal}\n"

	echo "${PURPLE}Site Title${NC}      "$title
	echo "${PURPLE}Username${NC}	"$user
	echo "${PURPLE}Password${NC}	"${BLACK_BG}${password}${NC}
	echo "${PURPLE}Your Email${NC}      "$email

	echo "\n >> ${bold}Install WordPress${normal}\n"

	printf "${GREEN}${bold}Install theme $themename & npm install? ${normal}${NC}[y/N] "
	read verfiy
	# Check result
	if [[ $verfiy =~ ^[Yy]$ ]]
	then
		cd wp-content/themes
		git clone $DEAFALT_REPO $themename
		cd $themename
		npm install
	fi	
	echo "${GREEN}${bold}Next${normal}${NC}"
	echo "cd "$root
	# wp db create --dbhost=localhost --dbname=testdb2 --dbuser=gary --dbpass=password
	# wp core install --url=$url --title=$title --admin_user=$user --admin_password=$password --admin_email=$mail
	# wp core install --url=testsite.loc --title=TestSite --admin_user=gary --admin_password=password --admin_email=garyswiftmail@gmail.com	
else
    echo "Aborted"
    exit
fi
