#!/bin/bash
file=wp-config-sample.php
assets_off="define('DB_COLLATE', '');"
assets_on="define('DB_COLLATE', '');\n\n\/**  Change the Default WordPress Uploads Folder *\/\ndefine('UPLOADS', 'assets');"
if [ -e $file ]; then
	# clear
	echo "Switching WordPress uploads folder to /assets"
	gsed -i "s/$assets_off/$assets_on/" $file
else
    echo "wp-config.php does not exist!"
fi