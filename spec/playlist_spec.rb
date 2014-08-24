require 'spec_helper'
require 'yaml'

describe Playlist do
  before :all do
    @playlist = Playlist.new
    @song = Dir.pwd + "/res/sample.mp3"
    @playlist_directory =  Dir.pwd + "/res/playlists/"
    @playlist_name = 'playlist'
  end

  describe '#new' do
    it 'creates a new Playlist object' do
      @playlist.should be_an_instance_of Playlist
    end
  end
  
  describe '#add' do
    it 'adds a song to the Playlist' do
      size = @playlist.song_list
      @playlist.add @song
      @playlist.song_list.map { |song| song[:path] }.should include @song
    end
  end

  describe '#save' do
    it 'saves the playlist in a file' do
      @playlist.save @playlist_name
      songs = YAML.load_file(@playlist_directory + @playlist_name + ".yaml")
      songs.should == @playlist.song_list
    end
  end

  describe '#load' do
    it 'loads a playlist from a file' do
      playlist = Playlist.new
      playlist.load(@playlist_name)
      [@playlist_name, @playlist.song_list].should == [playlist.name, playlist.song_list]
    end
  end
end