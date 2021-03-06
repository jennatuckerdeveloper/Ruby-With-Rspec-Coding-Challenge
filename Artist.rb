class Artist

  @@next_artist_instance_id = 0

 def initialize(name:)
  @name = name
  check_params
  set_artist_ID
  @songs = []
  @song_count = 0
  @featured_song_id = nil
  @top_genres = []
  @artist_genres = {}
 end

 attr_reader :id, :name, :songs, :song_count, :featured_song_id,
 :artist_genres, :top_genres

private def check_params
  if @name.empty?
    raise 'The name param cannot be an empty string.'
  end
end

private def set_artist_ID
  @id = @@next_artist_instance_id
  @@next_artist_instance_id += 1
 end
 
def self.next_artist_instance_id
  @@next_artist_instance_id
 end

private def expect_song(object)
  if !object.is_a?(Song) 
    raise "This method expects a Song class instance."
  end
 end

private def update_song_count 
  @song_count = @songs.length
 end

private def find_song(song)
  selected_song = @songs.select { |s| s.id == song.id }
  if selected_song.empty?
    return false
  else 
    return selected_song
  end
 end

 def add_song(song:) 
  expect_song(song)
  if find_song(song)
    raise "Song already found in artist's current songs."
  else  
    store_new_song(song)
    update_song_count
    add_to_artist_genres(song.genre)
  end
  print_readable
 end

private def store_new_song(song)
  @songs.push(song)
 end 

private def add_to_artist_genres(genre)
  add_genre_to_count(genre)
  derive_top_three_genres
end

private def add_genre_to_count(genre)
  if @artist_genres.include? genre
    @artist_genres[genre] += 1
  else
    @artist_genres[genre] = 1 
  end
end 

def remove_song(song:)
  expect_song(song)
  if find_song(song)
    delete_song(song)
    update_song_count
    remove_from_artist_genres(song.genre)
    if @featured_song_id == song.id 
      @featured_song_id = nil
    end
  else  
    raise "Cannot find this song in the artist's current songs."
  end
  print_readable
end

private def delete_song(song)
  @songs.delete(song)
end

private def remove_from_artist_genres(genre)
  remove_genre_from_count(genre)
  derive_top_three_genres
end

private def remove_genre_from_count(genre)
  count = @artist_genres[genre]
  if count == 1 
    @artist_genres.delete(genre)
  else 
    @artist_genres[genre] -= 1
  end
end 

private def derive_top_three_genres
  sortedNestedArray = @artist_genres.sort_by(&:last).reverse
  topThree = []
  maxIndex = sortedNestedArray.length < 3 ? sortedNestedArray.length : 3
  sortedNestedArray.slice(0,maxIndex).each do | innerArray | 
    topThree.push(innerArray[0]) 
  end
  @top_genres = topThree
end

def set_featured_song(song:)
  expect_song(song)
  if find_song(song)
    set_featured_song_id(song.id)
  else   
    raise "Cannot find this song in the artist's current songs."
  end
 end

 private def set_featured_song_id(id)
  @featured_song_id = id
 end

def print_readable 
  readable = "{ id: #{@id}, name: '#{@name}', song_count: #{@song_count}, top_genres: #{@top_genres}, featured_song_id: #{@featured_song_id} }"
  print readable
  readable
 end

end
