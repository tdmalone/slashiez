<?php
/**
 * Slashiez function for /evernote.
 * Manage and search through your Evernote notes.
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
