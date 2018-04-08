<?php
/**
 * Slashies function for /pocket.
 * Provides various tools for integrating with a Pocket account.
 *
 * @see https://github.com/Azure/azure-functions-templates/tree/dev/Functions.Templates/Templates
 * @see https://github.com/Azure-Samples/functions-quickstart
 */

$main_menu = (

  '*Welcome to <https://getpocket.com|Pocket> on Slack!* :smile_cat:' . "\n" .
  'Available subcommands are:' . "\n\n" .

  '• `' . COMMAND . ' add <url> [#tags]`             :white_check_mark: Adds a new article to your list' . "\n" .
  '• `' . COMMAND . ' archive <url>|<id>|last`   :file_folder: Immediately archives a new or existing ' .
  'article' . "\n" .
  '• `' . COMMAND . ' unarchive <id>`                  :open_file_folder: Unarchive a previous archived article' . "\n" .
  '• `' . COMMAND . ' share <url>|<id>|last`      :sunglasses: Publicly shares a new or existing article in ' .
  'the current channel' . "\n" .
  '• `' . COMMAND . ' remove <id>|last`               :x: Removes an existing article from your list' . "\n\n" .

  '• `' . COMMAND . ' tag|untag <id>|last [#tags]` :bookmark: Adds/removes tags on a specific article' . "\n" .
  '• `' . COMMAND . ' random [#tags]`                   :grey_question: Returns a random article from ' .
  'your list' . "\n" .
  '• `' . COMMAND . ' newest|oldest [#tags]`       :rolled_up_newspaper: Returns either the newest or oldest ' .
  'article in your list' . "\n" .
  '• `' . COMMAND . ' search <query> [#tags]`      :mag: Searches for articles in your list by title, URL or ' .
  'excerpt' . "\n" .
  '• `' . COMMAND . ' status`                                 :hash: Counts all your articles by ' .
  'tag and status (both reading list and archived)' . "\n\n" .
  '• `' . COMMAND . ' remind`                                 :timer_clock: Reminds you of articles due today that you have tagged with `#remind-yyyy-mm-dd`' . "\n\n" .

  ':paperclip: Article IDs are returned by the `add`, `random`, `newest`, `oldest` and `search` commands.' . "\n" .
  ':bulb: The keyword `last` will always refer to the most recent _single_ article returned by the above ' .
  'commands.' . "\n" .
  ':bookmark: Tags are optional for commands that support them. They can help narrow down what ' .
  'you\'re interested in reading.' . "\n" .
  ':monkey_face: Special tags can help even more. Try these: ' .
  '`' . join( '` `', $valid_special_tags ) . '`.' . "\n\n" .

  'Please see <@' . MAINTAINER . '> if you have any questions about this command. :ok_hand:'

);

fwrite( STDOUT, $main_menu );
