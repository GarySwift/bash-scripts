<?php
class PluginTools {
	const CPT = 'placeholder';
	private $plugin_tools_options;
	private $slug = 'edit.php?post_type='.self::CPT;
	private $title = 'Plugin Tools';
	private $menu_slug = self::CPT.'-tools';

	public function __construct() {
		add_action( 'admin_menu', array( $this, 'plugin_tools_add_plugin_page' ) );
	}

	public function plugin_tools_add_plugin_page() {
		add_submenu_page(
			$this->slug,
			$this->title, // page_title
			$this->title, // menu_title
			'manage_options', // capability
			$this->menu_slug, // menu_slug
			array( $this, 'plugin_tools_create_admin_page' ) // function
		);
	}

	public function plugin_tools_create_admin_page() {
		$this->plugin_tools_options = get_option( 'plugin_tools_option_name' ); ?>

		<div class="wrap">
			<h2><?php echo $this->title ?></h2>

			<p>Use the buttons below to add custom tasks for this plugin.</p>

			<div class="catch">
				<?php
					if (isset( $_POST["default"] )) {
						$this->default( $action = "default" );
					} 	
				?>							
			</div>
			<hr>
			<?php $this->buttons(); ?>
		</div>	
		<?php 
	}

	private function buttons() {
		?>
			<div class="buttons">
				<div class="left">
					<form method="post" action="<?php echo $this->slug ?>&page=<?php echo $this->menu_slug ?>">
						<input type="hidden" name="default" value="1">
						<?php submit_button("Default Action"); ?>
					</form>					
				</div>
			</div>
		<?php
	}
	private function default($action) {
		?>
			<h3>Default Action Successful</h3>
			<hr>
			<p>This doesn't do anything for the moment. You will need to add an action.</p>	
		<?php
	}
}
if ( is_admin() ) $plugin_tools = new PluginTools();