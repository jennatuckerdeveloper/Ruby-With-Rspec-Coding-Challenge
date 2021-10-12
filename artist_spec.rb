require 'rspec'
require_relative 'artist'
require_relative 'song'

describe Artist do

  let(:artist_name1) {'Sadie Smith'}
  let(:artist_name2) {'Joan Waller'}
  let(:artist1) {Artist.new(name: artist_name1)}


  it "creates an artist" do
    expect(artist1.id).to eq(0)
    expect(artist1.name).to eq(artist_name1)
    expect(artist1.songs).to eq([])
    expect(artist1.song_count).to eq(0)
    expect(artist1.featured_song_id).to eq(nil)
    expect(artist1.top_genres).to eq([])
    expect(artist1.artist_genres).to eq({})
  end

  it "uses a unique id for artists" do 
    artist2 = Artist.new(name: artist_name2)
    expect(artist2.id).to eq(1)
  end

  it "increments a class variable for the next ID" do
    nextID = Artist.next_artist_instance_id
    expect(nextID).to eq(2)
  end

  it "errors without a name keyword param" do
    expect { Artist.new }.to raise_error(ArgumentError)
  end

  let(:song_name1) {'Blue Song'}
  let(:genreFolk) {'Folk'}
  let(:song1) {Song.new(name: song_name1, genre: genreFolk)}
  

  it "can add a song to the artist's songs" do 
    artist1.add_song(song: song1)
    expect(artist1.songs.include? song1).to be true
    expect(artist1.song_count).to eq(1)
    expect(artist1.top_genres.include? genreFolk).to be true
  end

  it "errors instead of adding a duplicate song" do 
    artist1.add_song(song: song1)
    expect { artist1.add_song(song: song1) }.to raise_error(RuntimeError)
  end

  let(:genrePunk) {'Punk'}
  let(:genreBlues) {'Blues'}
  let(:genreJazz) {'Jazz'}
  let(:song2) {Song.new(name: 'Red Song', genre: genreFolk)}
  let(:song3) {Song.new(name: 'Green Song', genre: genreBlues)}
  let(:song4) {Song.new(name: 'Black Song', genre: genreJazz)}
  let(:song5) {Song.new(name: 'Yellow Song', genre: genrePunk)}
  let(:song6) {Song.new(name: 'Gray Song', genre: genrePunk)}

  it "keeps track of top genres as songs are added" do 
    # top_genres starts empty []

    artist1.add_song(song: song1)
    # expect the first genre to be added 
    expect(artist1.top_genres.include? genreFolk).to be true
    expect(artist1.top_genres.length).to eq(1)

    # expect a repeated genre not to be added 
    artist1.add_song(song: song2) # New song, same genre 
    expect(artist1.top_genres.include? genreFolk).to be true
    expect(artist1.top_genres.length).to eq(1)

    # expect a second genre to be added with the first 
    artist1.add_song(song: song3) # New song, new genre 
    expect(artist1.top_genres.include? genreFolk).to be true
    expect(artist1.top_genres.include? genreBlues).to be true
    expect(artist1.top_genres.length).to eq(2)

    # expect a third genre to be added with the first 
    artist1.add_song(song: song4) # New song, new genre 
    expect(artist1.top_genres.include? genreFolk).to be true
    expect(artist1.top_genres.include? genreBlues).to be true
    expect(artist1.top_genres.include? genreJazz).to be true
    expect(artist1.top_genres.length).to eq(3)

    # expect a fourth genre with higher prevlance to replace 1 of the 3
    artist1.add_song(song: song5) # New song, new genre 
    artist1.add_song(song: song6) # New song, more prevalent genre 
    expect(artist1.top_genres.length).to eq(3)
    expect(artist1.top_genres.include? genrePunk).to be true
  end

  it "can remove a song from an artist's songs" do 
    artist1.add_song(song: song1)
    artist1.add_song(song: song3)
    artist1.remove_song(song: song1)
    expect(artist1.songs.include? song1).to be false
    expect(artist1.song_count).to eq(1)
    expect(artist1.top_genres.include? genreFolk).to be false
    expect(artist1.top_genres.length).to eq(1)
  end 

  it "errors when a song cannot be found to be removed" do 
    expect { artist1.remove_song(song: song1) }.to raise_error(RuntimeError)
  end

  it "can set a featured song" do
    artist1.add_song(song: song1)
    artist1.set_featured_song(song: song1)
    song1ID = song1.id
    expect(artist1.featured_song_id).to eq(song1ID)
  end

  it "can update the featured song" do 
    artist1.add_song(song: song1)
    artist1.add_song(song: song2)
    artist1.set_featured_song(song: song1)
    song1ID = song1.id
    song2ID = song2.id
    expect(artist1.featured_song_id).to eq(song1ID)
    artist1.set_featured_song(song: song2)
    expect(artist1.featured_song_id).to eq(song2ID)
  end

  it "errors if song set as featured not found" do 
    expect { artist1.set_featured_song(song: song1) }.to raise_error(RuntimeError)
  end

  it "will remove a featured song if that song is removed" do
    artist1.add_song(song: song1)
    artist1.set_featured_song(song: song1)
    song1ID = song1.id
    expect(artist1.featured_song_id).to eq(song1ID)
    artist1.remove_song(song: song1)
    expect(artist1.featured_song_id).to eq(nil)
  end

  it "can print a readable representation" do 
    readable = "{ id: #{artist1.id}, name: '#{artist1.name}', song_count: #{artist1.song_count}, top_genres: #{artist1.top_genres}, featured_song_id: #{artist1.featured_song_id} }"
    expect(artist1.print_readable).to eq(readable)
  end

end
