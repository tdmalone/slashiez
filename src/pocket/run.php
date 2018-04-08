<?php
/**
 *
 *
 * @see https://github.com/Azure/azure-functions-templates/tree/dev/Functions.Templates/Templates
 * @see https://github.com/Azure-Samples/functions-quickstart
 */

$inTable = json_decode( file_get_contents( getenv( 'inTable' ) ) );
file_put_contents( getenv( 'res' ), json_encode( $inTable ) );

$inputMessage = file_get_contents( getenv( 'inputMessage' ) );
$inputMessage = rtrim( $inputMessage, "\n\r" );
fwrite( STDOUT, "PHP script processed queue message '$inputMessage'" );
