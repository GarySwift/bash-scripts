#!/bin/bash
source ~/bash-scripts/_settings.sh
clear
folder=''
default_company="Taoglas"
while true
do
	# printf 'Enter your post type slug: '
	printf "Enter your post type ${PURPLE}slug${NC}: "
	read cpt

	# Check for valid characters a-z, A-Z, 0-9, -
	if [[ "$cpt" =~ [^a-z_] ]]; then
		echo ${red}"Invalid characters${NC}"
	else
		CPT=$(tr '[:lower:]' '[:upper:]' <<< "$cpt")
		break
	fi	
done

while true
do
	printf "${PURPLE}Slug plural${NC}"
	read -p " ("$cpt"s): " plural_cpt

	# Set default if not input
	if [ "${plural_cpt}" == "" ] ; then
	  plural_cpt=${cpt}s
	fi	

	# Check for valid characters a-z, A-Z, 0-9, -
	if [[ "$cpt" =~ [^a-z_] ]]; then
		echo ${red}"Invalid characters${NC}"
	else
		
		break
	fi	
done

temp_singular_label="$(tr '[:lower:]' '[:upper:]' <<< ${cpt:0:1})${cpt:1}"	

# Do a loop until we have a valid singular label
while true
do
	printf "${PURPLE}Singular Label${NC}"
	read -p " (${temp_singular_label}): " singular_label
	# Set default if not input
	if [ "${singular_label}" == "" ] ; then
	  singular_label=$temp_singular_label
	fi	

	# Check for valid characters a-z, A-Z, 0-9, -
	if [[ "$cpt" =~ [^a-z] ]]; then
		echo ${red}"Invalid characters${NC}"
	else
		break	
	fi	
done

temp_plural_label="$(tr '[:lower:]' '[:upper:]' <<< ${plural_cpt:0:1})${plural_cpt:1}"

# Do a loop until we have a valid plural label
while true
do
	printf "${PURPLE}Plural Label${NC}"
	read -p " (${temp_plural_label}): " plural_label
	# Set default if not input
	if [ "${plural_label}" == "" ] ; then
	  plural_label=$temp_plural_label
	fi	

	# Check for valid characters a-z, A-Z, 0-9, -
	if [[ "$cpt" =~ [^a-z] ]]; then
		echo ${red}"Invalid characters${NC}"
	else
		break	
	fi	
done
#
#
while true
do
	printf "${PURPLE}Company${NC}"
	read -p " ($default_company): " company

	# Set default if not input
	if [ "${company}" == "" ] ; then
	  company=$default_company
	fi	

	# Check for valid characters a-z, A-Z, 0-9, -
	if [[ "$company" =~ [^a-zA-Z\ ] ]]; then
		echo ${red}"Invalid characters${NC}"
	else
		# function_company=${text_domain//-/_}
		# echo $function_text_domain
		# exit
		default_text_domain=$(tr '[:upper:]' '[:lower:]' <<< "$company")
		default_text_domain=${default_text_domain// /-}
		default_text_domain=wp-$default_text_domain
		# 'wp-taoglas'
		# default_prefix='wp_taoglas'
		default_prefix=$(tr '[:upper:]' '[:lower:]' <<< "$company")
		default_prefix=${default_text_domain// /_}	
		default_prefix=wp_$default_prefix
# default_text_domain='wp-taoglas'
# default_prefix='wp_taoglas'	
		company="WP ${company}"		
		break
	fi	
done
#
#
while true
do
	printf "${PURPLE}Text Domain${NC}"
	read -p " ($default_text_domain): " text_domain

	# Set default if not input
	if [ "${text_domain}" == "" ] ; then
	  text_domain=$default_text_domain
	fi	

	# Check for valid characters a-z, A-Z, 0-9, -
	if [[ "$cpt" =~ [^a-z-] ]]; then
		echo ${red}"Invalid characters${NC}"
	else
		# function_text_domain=${text_domain//-/_}
		# echo $function_text_domain
		# exit
		break
	fi	
done
#
default_prefix=${text_domain//-/_} 
while true
do
	printf "${PURPLE}Prefix${NC}"
	read -p " ($default_prefix): " prefix

	# Set default if not input
	if [ "${prefix}" == "" ] ; then
	  prefix=$default_prefix
	fi	

	# Check for valid characters a-z, A-Z, 0-9, -
	if [[ "$cpt" =~ [^a-z-] ]]; then
		echo ${red}"Invalid characters${NC}"
	else
		# function_text_domain=
		# echo $function_text_domain
		# exit
		break
	fi	
done
#
temp_folder=${text_domain}-${cpt}-cpt
#
while true
do
		
	printf "${PURPLE}Folder${NC}"
	read -p " ("$temp_folder"): " folder

	# Set default if not input
	if [ "${folder}" == "" ] ; then
	  folder=$temp_folder
	fi	
	
	# Check if folder alreadt exists
	if [ -d "$folder" ]; then
		echo "${RED}This folder $folder already exists${NC}"
	else	
		break
	fi
done

#
clear
echo "Does this look ok?"
echo
printf "${PURPLE}cpt${NC} " 
echo $cpt
printf "${PURPLE}CPT${NC} " 
echo $CPT
printf "${PURPLE}plural_cpt${NC} " 
echo $plural_cpt
printf "${PURPLE}plural_label${NC} " 
echo $plural_label
printf "${PURPLE}singular_label${NC} " 
echo $singular_label
printf "${PURPLE}folder${NC} " 
echo $folder
printf "${PURPLE}company${NC} " 
echo $company
printf "${PURPLE}text_domain${NC} " 
echo $text_domain
printf "${PURPLE}prefix${NC} " 
echo $prefix
echo
printf "${GREEN}${bold}Confirm? ${normal}${NC}[y/N] "
read verfiy

# Check result
if [[ $verfiy =~ ^[Yy]$ ]]
then

	#
	# Create the folders and files
	# 
	git clone https://github.com/wp-swift-wordpress-plugins/wp-swift-placeholder-cpt $folder && cd $_

	echo "Renaming files..."

	rm rename.sh

	# mv wp-text-domain-placeholder.php ${text_domain}-${cpt}.php
	mv wp-text-domain-placeholder.php ${text_domain}-${cpt}.php
	sed -i "s/Placeholders/${temp_plural_label}/g" ${text_domain}-${cpt}.php
	sed -i "s/placeholder/${cpt}/g" ${text_domain}-${cpt}.php
	sed -i "s/PLACEHOLDER/${CPT}/g" ${text_domain}-${cpt}.php
	sed -i "s/WP Taoglas/${company}/g" ${text_domain}-${cpt}.php	

	sed -i "s/Placeholders/${plural_label}/g" README.md
	sed -i "s/Placeholder/${singular_label}/g" README.md
	sed -i "s/placeholders/${plural_cpt}/g" README.md
	sed -i "s/placeholder/${cpt}/g" README.md
	sed -i "s/WP Taoglas/${company}/g" README.md
	sed -i "s/wp_taoglas/${prefix}/g" README.md	

	# Rename cpt
	sed -i "s/placeholder/${cpt}/g" admin-menu.php
	# Rename class name
	sed -i "s/PlaceholderPluginTools/${singular_label}PluginTools/g" admin-menu.php

	cd acf
		mv placeholder.php ${cpt}.php
		cd ../
	cd assets
		mkdir css
		mkdir images
		cd sass
			mv wp-text-domain-placeholder-public.scss ${text_domain}-${cpt}-public.scss
			cd ../
		cd js
			mv wp-text-domain-placeholder-public.js ${text_domain}-${cpt}-public.js
			cd ../			
		cd ../
	cd cpt
		mv placeholder.php ${cpt}.php
		mv placeholder.json ${cpt}.json
		cd ../		
	cd functions
		sed -i "s/placeholder/${cpt}/g" enqueue-scripts.php
		sed -i "s/PLACEHOLDER/${CPT}/g" enqueue-scripts.php
		sed -i "s/wp_prefix/${prefix}/g" enqueue-scripts.php
		sed -i "s/wp-text-domain/${text_domain}/g" enqueue-scripts.php
		sed -i "s/placeholder/${cpt}/g" html.php
		sed -i "s/wp_prefix/${prefix}/g" html.php
		sed -i "s/wp_prefix/${prefix}/g" shortcodes.php
		sed -i "s/placeholders/${plural_cpt}/g" shortcodes.php
		sed -i "s/placeholder/${cpt}/g" shortcodes.php
		cd ../
	cd html
		mv placeholder-loop.php ${cpt}-loop.php
		sed -i "s/placeholder/${cpt}/g" ${cpt}-loop.php
		cd ../
		
	rm -rf .git
	git init
	git add .
	git status
	tree
	cd ..
	subl $folder && subl $folder/${text_domain}-${cpt}.php
	exit
else
    echo "Aborted"
    exit
fi
