require 'yaml'
require_relative "players/auditeplayer"
require_relative 'playlist'

class Player
  attr_reader :player, :current_playlist

  AVAILABLE_PLAYERS = YAML.load_file File.join(File.dirname(__FILE__), "players/available_players.yaml")

  def initialize(adapter = :audite)
    @player = AVAILABLE_PLAYERS[adapter].class.new
    @current_playlist = Playlist.new
  end

  def play(source)
    if source.include? '.yaml'
      @current_playlist.load source
    else
      @current_playlist.add source
    end
    @player.set_playlist @current_playlist
    @player.play @player.playlist.song_list.first[:path]
  end

  def playing?
    @player.playing
  end

  def current_song
    @player.current_song
  end

  def toggle
    @player.toggle
  end

  def stop
    @player.stop
  end

  def close
    @player.close
  end

  def play_next
    @player.play_next true
  end

  def play_previous
    @player.play_previous
  end

  def seek_forward(seconds)
    @player.seek_forward seconds
  end

  def seek_backwards(seconds)
    @player.seek_backwards seconds
  end
end