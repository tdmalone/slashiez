<?php
/**
 * Slashies function for /slack.
 * Provides Slack related tools, including searching through the entire conversation archives.
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
