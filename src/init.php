<?php
/**
 * Initialise the Slashiez environment.
 *
 * @author Tim Malone <tdmalone@gmail.com>
 */

parse_str( file_get_contents( getenv( 'req' ) ), $vars );
define( 'COMMAND', $vars['command'] );
