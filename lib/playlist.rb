require 'yaml'
require 'mp3info'

class Playlist
  attr_reader :name, :song_list

  def initialize()
    @name = ""
    @song_list = []
    @playlist_directory = Dir.pwd + "/res/playlists/"
  end

  def add(path)
    song = {}
    Mp3Info.open(path) do |mp3|
      song[:title] = mp3.tag1.title
      song[:artist] = mp3.tag1.artist
      song[:album] = mp3.tag1.album
      song[:genre] = mp3.tag1.genre_s
      song[:year] = mp3.tag1.year
    end
    song[:path] = path
    @song_list << song
  end

  def open(name)
    @name = name
    @song_list = YAML.load_file(@playlist_directory + name + ".yaml")
  end

  def save(name)
    File.open(@playlist_directory + name + ".yaml", 'w') do |file|
      file.write(@song_list.to_yaml)
    end
  end

end