require 'spec_helper'
require 'yaml'

describe Playlist do
  before :all do
    @playlist = Playlist.new
    @song = Dir.pwd + "/res/sample.mp3"
    @playlist_directory =  Dir.pwd + "/res/playlists/"
    @playlist_name = 'playlist'
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

  describe '#filter' do
    it 'filters songs by a keyword in the song title' do
      @playlist.filter(:title, 'Ruby').should == [@song_object]
    end

    it 'filters songs by a keyword in the artist name' do
      @playlist.filter(:artist, 'Kaiser').should == [@song_object]
    end

    it 'filters songs by a keyword in the album name' do
      @playlist.filter(:album, 'TBC').should == [@song_object]
    end

    it 'filters songs by a year' do
      @playlist.filter(:year, 2000).should_not == [@song_object]
    end
  end
end