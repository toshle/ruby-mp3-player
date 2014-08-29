require 'green_shoes'
require_relative './../lib/player'

Shoes.app title: "Mp3 Player", top: 0, left: 0, width: 400, height: 200 do
  @player = Player.new :audite
  background "#dadada"
  stack margin: 10 do

    flow margin_left: 10 do
      button('Open') do
        filename = ask_open_file
        filename = filename.split('/').last if filename.include? ".yaml"
        @player.play filename
        #song.text = @player.current_song[:title] + " - " + @player.current_song[:artist]
      end
      button('Filter') do

      end
    end
    fill lime
    @progress_bar = rect(left:  20, top: 50, width: 360, height: 6)
    fill black
    @progress_handle = rect(left: 20, top: 44, width: 6, height: 18)
    @move = false

    @progress_bar.click do
      left = @progress_handle.left
      @progress_handle.move mouse[1], 44
      puts (@progress_handle.left - left).floor
      @player.seek_forward (@progress_handle.left - left).floor
    end

    @progress_handle.click do
      @move = true
      motion do |left, top|
        if left >= 20 and left <= 380 and @move
          puts left
          @progress_handle.move left, 44
        end
      end
    end

    release do
      @move = false
    end

    @player.player.adapter.events.on(:position_change) do |pos|
      puts pos
      #puts @player.player.adapter.length_in_seconds
      #puts @player.player.adapter.length_in_seconds / 360
      @progress_handle.move 20 + pos.floor * @player.player.adapter.length_in_seconds / 360, 44
    end

  end

end