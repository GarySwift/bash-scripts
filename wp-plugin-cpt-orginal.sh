#!/bin/bash
source ~/bash-scripts/_settings.sh
clear
folder=''
default_prefix='wp-taoglas'
while true
do
	printf 'Enter your post type slug: '
	read cpt

	# Check for valid characters a-z, A-Z, 0-9, -
	if [[ "$cpt" =~ [^a-z_] ]]; then
		echo ${red}"Invalid characters${NC}"
	else
		CPT=$(tr '[:lower:]' '[:upper:]' <<< "$cpt")
		break
	fi	
done
#
while true
do
	printf "${PURPLE}Prefix${NC}"
	read -p " (wp-taoglas): " prefix

	# Set default if not input
	if [ "${prefix}" == "" ] ; then
	  prefix=$default_prefix
	fi	

	# Check for valid characters a-z, A-Z, 0-9, -
	if [[ "$cpt" =~ [^a-z-] ]]; then
		echo ${red}"Invalid characters${NC}"
	else
		break
	fi	
done
#
temp_folder=${prefix}-${cpt}-cpt
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
temp_singular_label="$(tr '[:lower:]' '[:upper:]' <<< ${cpt:0:1})${cpt:1}"	
temp_plural_label=${temp_singular_label}s
#
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
#
# Create the folders and files
# 
mkdir $folder && cd $_
#
git init
cp ~/bash-scripts/wp-plugin-cpt/.gitignore .gitignore
cp ~/bash-scripts/wp-plugin-cpt/config.rb config.rb
cp ~/bash-scripts/wp-plugin-cpt/index.php index.php
#
cp ~/bash-scripts/wp-plugin-cpt/README.md README.md
sed -i "s/Placeholders/${temp_plural_label}/g" README.md
#
cp ~/bash-scripts/wp-plugin-cpt/${prefix}-placeholder.php ${prefix}-${cpt}.php
sed -i "s/Placeholders/${temp_plural_label}/g" ${prefix}-${cpt}.php
sed -i "s/placeholder/${cpt}/g" ${prefix}-${cpt}.php
sed -i "s/PLACEHOLDER/${CPT}/g" ${prefix}-${cpt}.php
#
cp ~/bash-scripts/wp-plugin-cpt/admin-menu.php admin-menu.php
sed -i "s/placeholder/${cpt}/g" admin-menu.php
# Rename class name
sed -i "s/PluginTools/${singular_label}PluginTools/g" admin-menu.php
# Rename instance name
sed -i "s/plugin_tools/${cpt}_plugin_tools/g" admin-menu.php
mkdir acf && cd $_
	touch ${cpt}.php
	cd ../
mkdir cpt && cd $_
	touch ${cpt}.php
	touch ${cpt}.json
	cd ../
mkdir assets && cd $_ 
	mkdir css
	mkdir images
	mkdir js && cd $_ 
		touch ${prefix}-${cpt}-public.js 
		cd ../
	mkdir sass && cd $_ 
		touch ${prefix}-${cpt}-public.scss 
		cd ../../
mkdir functions && cd $_
	# touch enqueue-scripts.php
	cp ~/bash-scripts/wp-plugin-cpt/functions/enqueue-scripts.php enqueue-scripts.php
	sed -i "s/placeholder/${cpt}/g" enqueue-scripts.php
	sed -i "s/PLACEHOLDER/${CPT}/g" enqueue-scripts.php
	touch html.php
	touch shortcodes.php 
	cd ../
mkdir html && cd $_
	# touch ${cpt}-loop.php
	# html/placeholder-loop.php
	cp ~/bash-scripts/wp-plugin-cpt/html/placeholder-loop.php ${cpt}-loop.php
	sed -i "s/placeholder/${cpt}/g" ${cpt}-loop.php
	touch the-content-single.php
	cd ../
tree
cd ../
subl $folder
subl $folder"/"${prefix}-${cpt}.php