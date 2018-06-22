<?php
/**
 * Register the stylesheets for the public-facing side of the site.
 *
 * @since    1.0.0
 */
function wp_taoglas_placeholder_enqueue_styles() {
	if (!ENQUEUE_PLACEHOLDER_CPT_STYLE) return;
	$file = 'assets/css/wp-taoglas-placeholder-public.css';
	if (file_exists( plugin_dir_path( __DIR__ ) . $file )) {
		$version = filemtime(plugin_dir_path( __DIR__ ) . $file);
		wp_enqueue_style( "wp-taoglas-placeholder-public-css", plugin_dir_url( __DIR__ ) . $file, array(), $version, 'all' );		
	}
}
function wp_taoglas_placeholder_enqueue_script() {
	if (!ENQUEUE_PLACEHOLDER_CPT_SCRIPT) return;
	$file = 'assets/js/wp-taoglas-placeholder-public.js';
	if (file_exists( plugin_dir_path( __DIR__ ) . $file )) {
		$js_version = filemtime( plugin_dir_path( __DIR__ ) . $file );
		wp_enqueue_script( 
			"wp-taoglas-placeholder-public-js",
			plugin_dir_url( __DIR__ ) . $file,
			array( 'jquery' ),
			$js_version,
			true
		);
	}
}
// add_action( 'wp_enqueue_scripts', 'wp_taoglas_placeholder_enqueue_styles');
// add_action( 'wp_enqueue_scripts', 'wp_taoglas_placeholder_enqueue_script');