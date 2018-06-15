<?php
/**
 * Register the stylesheets for the public-facing side of the site.
 *
 * @since    1.0.0
 */
function wp_taoglas_placeholder_enqueue_styles() {
	if (!ENQUEUE_PLACEHOLDER_CPT_STYLE) return;
	$file = 'assets/css/wp-taoglas-placeholder-public.css';
	$version = filemtime(plugin_dir_path( __DIR__ ) . $file);
	wp_enqueue_style( "wp-taoglas-placeholder-public-css", plugin_dir_url( __DIR__ ) . $file, array(), $version, 'all' );
}