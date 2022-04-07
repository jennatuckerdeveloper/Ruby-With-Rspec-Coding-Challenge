class Song

  @@next_song_instance_id = 0

  attr_reader :id, :genre, :name

  def initialize(name:, genre:)
    set_song_ID
    @name = name
    @genre = genre
    check_params
  end

  private def check_params
    if @name.empty?
      raise 'The name param cannot be an empty string.'
    end
    if @genre.empty?
      raise 'The genre param cannot be an empty string'
    end
  end

  private def set_song_ID
    @id = @@next_song_instance_id
    @@next_song_instance_id += 1
  end

  def self.next_song_instance_id
    @@next_song_instance_id
  end

end