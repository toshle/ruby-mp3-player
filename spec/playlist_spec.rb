require 'spec_helper'

describe Playlist do
  before :all do
    @playlist = Playlist.new
    @song = Dir.pwd + "/res/sample.mp3"
    @playlist_directory =  Dir.pwd + "res/playlists/"
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

    end
  end
end