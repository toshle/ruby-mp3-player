require 'audite'

class AuditePlayer
  attr_reader :adapter, :playlist, :current_song_index
  def initialize
    @adapter = Audite.new
    @playing = false
    @current_song_index = 0
    @adapter.events.on(:complete) do
      play_next
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

  def play_next
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
    @playlist = Playlist.new
    @playlist.load source
  end

  def close
    @adapter.start_stream
    exit
  end
end