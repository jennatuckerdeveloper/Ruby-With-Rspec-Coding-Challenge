class Song

  @@next_song_instance_id = 0

  attr_reader :id, :genre, :name

  def initialize(name:, genre:)
    set_song_ID
    @name = name
    @genre = genre
  end

  def set_song_ID
    @id = @@next_song_instance_id
    @@next_song_instance_id += 1
  end

  def self.next_song_instance_id
    @@next_song_instance_id
  end

end
