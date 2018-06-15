<?php
wp_reset_query();
$paged = (get_query_var('paged')) ? get_query_var('paged') : 1;
$post_type = 'placeholder';
$posts_per_page = 10;
$args = array( 
    'post_type' => $post_type, 
    'posts_per_page' => $posts_per_page, 
    'paged' => $paged,  
);
global $wp_query;
$wp_query = new WP_Query($args);

if ( have_posts() ) :

	/* Start the Loop */
	while ( have_posts() ) : 
		the_post(); 
		require plugin_dir_path( __FILE__ ) . 'the-content-single.php';
	endwhile;

else :

	if (function_exists("get_template_part")) {
		get_template_part( 'template-parts/content', 'none' );
	}
	
endif; // End have_posts() check.

/* Display navigation to next/previous pages when applicable */
if ( function_exists( 'foundationpress_pagination' ) ) :
	foundationpress_pagination();
elseif ( is_paged() ) :
?>
	<nav id="post-nav">
		<div class="post-previous"><?php next_posts_link( __( '&larr; Older posts', 'foundationpress' ) ); ?></div>
		<div class="post-next"><?php previous_posts_link( __( 'Newer posts &rarr;', 'foundationpress' ) ); ?></div>
	</nav>
<?php
endif;
wp_reset_query();