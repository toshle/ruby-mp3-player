ruby-mp3-player
===============

An mp3 player written in ruby

Dependenices
------------
You need mpg123 and PortAudio libraries installed.
Also the player uses audite gem.

Feature plan
------------

* ~~Player will play songs from files~~ - play PATH_TO_FILE
* ~~Songs in playlists can be filtered by tags(title, artist, album, year, etc.)~~ - filter PLAYLIST_NAME CRITERA(title, artist, album or year) KEYWORD
* ~~Songs can be added to playlists~~ - add_to_playlist PATH_TO_SONG PLAYLIST_NAME
* ~~Create playlist~~ - add_to_playlist PATH_TO_SONG --new_name NEW_NAME
* ~~Delete a playlist~~ - just delete the file
* ~~See all playlists~~ - show --all
* ~~See all songs in a playlist~~ - show PLAYLIST_NAME
* ~~Play a playlist~~ - play PLAYLIST_FILE

Next Steps
----------
* Write an mpg123 wrapper for the player - will add support for other file formats and play from URL
* Finish the GUI
* Allow playlist merge
* Add more flow control commands (seek forward, rewind, adjust volume)
* Add more tests
* Create a gem