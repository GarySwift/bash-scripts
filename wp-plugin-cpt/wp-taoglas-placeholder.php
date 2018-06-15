<?php
/*
Plugin Name: WP Taoglas: Placeholders CPT
Plugin URI: 
Description: CPT & ACF for Placeholders. This can be disabled without loss of data but associated content will not be available.
Version: 1
Author: Gary Swift
Author URI: https://github.com/wp-swift-wordpress-plugins
License: GPL2
*/

# Global variables
define("ENQUEUE_PLACEHOLDER_CPT_STYLE", false);
# CPT
require_once plugin_dir_path( __FILE__ ) . 'cpt/placeholder.php';
# ACF Fields
require_once plugin_dir_path( __FILE__ ) . 'acf/placeholder.php';
# Admin menu
require_once plugin_dir_path( __FILE__ ) . 'admin-menu.php';
# Functions
require_once plugin_dir_path( __FILE__ ) . 'functions/enqueue-scripts.php';
require_once plugin_dir_path( __FILE__ ) . 'functions/shortcodes.php';
require_once plugin_dir_path( __FILE__ ) . 'functions/html.php';