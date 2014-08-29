require 'audite'

class AuditePlayer
  attr_reader :adapter, :playlist, :current_song_index, :repeat, :playing
  def initialize
    @adapter = Audite.new
    @playing = false
    @repeat = false
    @current_song_index = 0
    @adapter.events.on(:complete) do
      @playing = false
      play_next true
    end
  end

  def play(song)
    if !@playing || song
      @playing = true
      @adapter.load(song)
      @adapter.start_stream
    else
      toggle
    end
  end

  def stop
    if @playing
      @adapter.stop_stream
      @playing = false
    end
  end

  def toggle
    @adapter.toggle if @playing
  end

  def play_next(command = false)
    if @repeat or command
      stop if !@adapter.active
      if @playlist.song_list.size >= 1
        if @current_song_index < @playlist.song_list.size - 1
          @current_song_index += 1
        else
          @current_song_index = 0
        end
      end
      play @playlist.song_list[@current_song_index][:path]
    end
  end

  def current_song
    @playlist.song_list[@current_song_index]
  end

  def play_previous
    stop if !@adapter.active
    if @playlist.song_list.size >= 1
      if @current_song_index > 0
        @current_song_index -= 1
      else
        @current_song_index = @playlist.song_list.size - 1
      end
    end
    play @playlist.song_list[@current_song_index][:path]
  end

  def set_playlist(source)
    @playlist = source
  end

  def seek_forward(seconds = 2)
    @player.forward seconds
  end

  def seek_backwards(seconds = 2)
    @player.rewind seconds
  end

  def close
    @adapter.start_stream
    exit
  end
end