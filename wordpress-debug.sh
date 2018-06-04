#!/bin/bash
file=wp-config-sample.php
debug_off="define('WP_DEBUG', false);"
debug_on="\$debug=true;# Turn on\/off Wordpress debugging (and log it in debug.log) \nif(\$debug) { \n # Turn debugging on \n define('WP_DEBUG', true); \n # Tell WordPress to log everything to \/wp-content\/debug.log \n define('WP_DEBUG_LOG', true); \n # Turn on the display of error messages on your site \n define('WP_DEBUG_DISPLAY', true); \n} \nelse { \n define('WP_DEBUG', false); \n define('WP_DEBUG_LOG', false); \n define('WP_DEBUG_DISPLAY', false); \n}"
if [ -e $file ]; then
	echo "Turning on Wordpress debugging (and opening debug.log)"
	gsed -i "s/$debug_off/$debug_on/" $file
	touch wp-content/debug.log && open -a Console.app wp-content/debug.log
else
    echo "wp-config.php does not exist!"
fi