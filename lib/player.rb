require './players/auditeplayer'

class Player
  attr_reader :player, :current_playlist

  AVAILABLE_PLAYERS = {
    audite: AuditePlayer
  }

  def initialize
    @player = AVAILABLE_PLAYERS[:audite].new
  end

  def play(source)
    @player.play(source)
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