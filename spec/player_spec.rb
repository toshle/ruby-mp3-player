require 'spec_helper'
require 'yaml'
require 'playlist'

describe Player do
  before :all do
    @player = Player.new :audite
    @song = Dir.pwd + "/res/sample.mp3"
    @playlist =  "playlist.yaml"
    @song_object = {
      title: 'Ruby',
      artist: 'Kaiser Chiefs',
      album: 'TBC',
      genre: 'Other',
      year: 2013,
      path: Dir.pwd + '/res/sample.mp3'
    }
  end

  describe '#new' do
    it 'creates a new Player object' do
      @player.should be_an_instance_of Player
    end
  end
  
  describe '#play' do
    it 'plays a song' do
      @player.play(@song)
      @player.current_song.should == @song_object
    end
    it 'plays a playlist' do
      @player.play(@playlist)
      @player.current_song.should == @song_object
    end
  end
end