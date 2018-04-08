<?php
/**
 * Slashiez function for /pokedex.
 * Retrieve information on hundreds of Pokemon.
 *
 * @author Tim Malone <tdmalone@gmail.com>
 */

$main_menu = (

  'Coming soon...'

);

$response = [

  'isRaw'  => true,
  'status' => 200,
  'body'   => $main_menu,

  'headers' => [
    'Content-Type' => 'text/html',
  ],

];

// Output response.
file_put_contents( getenv( 'res' ), json_encode( $response ) );
