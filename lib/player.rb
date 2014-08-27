require 'yaml'
require './players/auditeplayer'
require './playlist'

class Player
  attr_reader :player, :current_playlist

  AVAILABLE_PLAYERS = YAML.load_file "players/available_players.yaml"

  def initialize
    @player = AVAILABLE_PLAYERS[:audite].class.new
    @current_playlist = Playlist.new
  end

  def play(source)
    if source.include? '.yaml'
      @player.set_playlist source
      @player.play @player.playlist.song_list.first[:path]
    else
      @player.play source
    end
  end

  def toggle
    @player.toggle
  end

  def stop
    @player.stop
  end

  def seek_forward(seconds)

  end

  def seek_backwards(seconds)

  end
end