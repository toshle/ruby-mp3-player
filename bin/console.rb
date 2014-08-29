require 'thor'
require 'io/console'
require_relative './../lib/player'

class Console < Thor
  desc "play FILE", "Plays FILE. FILE can be either an audio file or a playlist file"
  option :player
  option :hotkeys, :type => :boolean , :default => true
  def play(source = "now_playing.yaml")
    if options[:player]
      adapter = options[:player].to_sym
    else
      adapter = :audite
    end
    player = Player.new adapter

    player.play source
    clear
    print_instructions
    while player.playing?
      hotkeys player if options[:hotkeys]
    end
    player.close
  end

  desc "show PLAYLIST", "Shows the contents of PLAYLIST"
  option :all, :type => :boolean
  def show(playlist = nil)
    clear
    all = Dir[Playlist.playlist_directory + "*.yaml"].map do |file|
      file.split('/').last.split('.').first
    end

    if playlist == nil and options[:all]
      puts
      puts "Playlists:"
      puts all
      puts
    end
    if playlist != nil
      list = YAML.load_file Playlist.playlist_directory + playlist + ".yaml"
      puts "Playlist (" + playlist + "):"
      list.each do |song|
        puts song[:title].to_s + " - " + song[:artist].to_s + " | " + song[:album].to_s + " " + song[:year].to_s
      end
    end
  end

  desc "add_to_playlist FILE PLAYLIST", "Adds FILE to the PLAYLIST"
  option :new_name
  def add_to_playlist(file, playlist = "now_playing")
    list = Playlist.new
    list.load playlist + ".yaml"
    list.add file
    playlist = options[:new_name] if options[:new_name]
    list.save playlist + ".yaml"
    show playlist
  end

  desc "filter PLAYLIST CRITERIA KEYWORD", "Returns all occurences of KEYWORD in the CRITERIA in PLAYLIST"
  #option :play, :type => :boolean
  def filter(playlist, criteria, keyword)
    list = Playlist.new
    list.load(playlist + ".yaml")
    list.song_list = list.filter criteria.to_sym, keyword
    list.save "now_playing.yaml"
    show "now_playing"
  end


  no_commands do
    def clear
      system "clear"
      system "cls"
    end

    def print_instructions
      puts "'q' - quit, 'space' - toggle pause/unpause"
      puts "'.' - next, ',' - previous"
      puts "'i' - song information"
    end

    def hotkeys(player)
      STDIN.echo = false
      key = STDIN.getch
      case key
        when 'q'
          STDIN.echo = true
          player.close
        when ' '
          player.toggle
        when '.'
          player.play_next
          clear
          print_instructions
        when ','
          player.play_previous
          clear
          print_instructions
        when 'i'
          clear
          print_instructions
          puts player.current_song[:title].to_s + " - " + player.current_song[:artist].to_s
          print "Album: " + player.current_song[:album].to_s + " "
          print player.current_song[:year].to_s + "\n"
      end
    end
  end
end
Console.start(ARGV)