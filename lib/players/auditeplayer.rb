require 'audite'

class AuditePlayer
  attr_accessor :adapter
  def initialize
    @adapter = Audite.new
    @playing = false
  end

  def play(song)
    unless @playing || song.nil?
      @playing = true
      @adapter.load(song)
      @adapter.start_stream
    end
  end

  def stop
    if @playing
      @adapter.stop_stream
      @playing = false
    end
  end

  def toggle
    if @playing
      @player.toggle
    end
  end
end