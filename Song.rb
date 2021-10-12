class Song

  @@nextSongInstanceID = 0

  attr_accessor :id, :genre, :name

  def initialize(name:, genre:)
    set_song_ID
    @name = name
    @genre = genre
  end

  def set_song_ID
    @id = @@nextSongInstanceID
    @@nextSongInstanceID += 1
  end

  def self.nextSongInstanceID
    @@nextSongInstanceID
  end

end
