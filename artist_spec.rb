require 'rspec'
require_relative 'artist'
require_relative 'song'

describe Artist do

  shared_context "create artist instance artist1" do
    before(:all) do 
      @name1 = 'Sadie Smith'
      @artist1 = Artist.new(name: @name1)
    end
  end

  shared_context "add two songs with genre Folk" do
    before(:all) do
      @genre_folk = 'Folk'
      @folkSong1 = Song.new(name: 'Blue Song', genre: @genre_folk)
      @folkSong2 = Song.new(name: 'Gray Song', genre: @genre_folk)
      @artist1.add_song(song: @folkSong1)
      @artist1.add_song(song: @folkSong2)
    end
  end

  describe "Artist::new" do 

    context "with valid initialization params" do

      include_context "create artist instance artist1"

      it "is assigned an @id" do
        expect(@artist1.id).to eq(0)
      end
      it "is assigned the @name param" do
        expect(@artist1.name).to eq(@name1)
      end
      it "is assigned an empty @songs list" do
        expect(@artist1.songs).to eq([])
      end
      it "is assigned a @song_count of 0" do
        expect(@artist1.song_count).to eq(0)
      end
      it "is assigned a @featured_song_id of nil" do
        expect(@artist1.featured_song_id).to eq(nil)
      end
      it "is assigned an empty @top_genres list" do
        expect(@artist1.top_genres).to eq([])
      end
      it "is assigned an empty @artist_genres hash" do
        expect(@artist1.artist_genres).to eq({})
      end
      it "increments ::next_song_instance_id" do
        next_id = @artist1.class.next_artist_instance_id
        expect(next_id).to eq(@artist1.id + 1)
      end
      it "uses a unique id for artists" do 
        artist2 = Artist.new(name: 'Joan Waller')
        expect(artist2.id).not_to eq(@artist1.id)
      end
    end

    context "missing initialization params" do
      it "errors without a name keyword param" do
        expect { Artist.new }.to raise_error(ArgumentError)
      end
      it "errors with empty string for name" do
        expect { Artist.new(name: '')}.to raise_error(RuntimeError)
      end
    end
  end

  describe "#add_song" do 
    
    include_context "create artist instance artist1"

    shared_context "add two songs with genre Blues" do
      before(:all) do
        @genre_blues = 'Blues'
        @bluesSong1 = Song.new(name: 'Orange Song', genre: @genre_blues)
        @bluesSong2 = Song.new(name: 'White Song', genre: @genre_blues)
        @artist1.add_song(song: @bluesSong1)
        @artist1.add_song(song: @bluesSong2)
      end
    end

    shared_context "add two songs with genre Punk" do
      before(:all) do
        @genre_punk = 'Punk'
        @punkSong1 = Song.new(name: 'Red Song', genre: @genre_punk)
        @punkSong2 = Song.new(name: 'Yellow Song', genre: @genre_punk)
        @artist1.add_song(song: @punkSong1)
        @artist1.add_song(song: @punkSong2)
      end
    end


    shared_context "add three songs with genre Jazz" do 
      before(:all) do
        @genre_jazz = 'Jazz'
        @jazzSong1 = Song.new(name: 'Black Song', genre: @genre_jazz)
        @jazzSong2 = Song.new(name: 'Pink Song', genre: @genre_jazz)
        @jazzSong3 = Song.new(name: 'Ruby Song', genre: @genre_jazz)
        @artist1.add_song(song: @jazzSong1)
        @artist1.add_song(song: @jazzSong2)
        @artist1.add_song(song: @jazzSong3)
      end
    end

    context "2 songs of 1 unique genre added" do

      include_context "add two songs with genre Folk"

      it "adds the song to the artist's songs" do 
        expect(@artist1.songs.include? @folkSong1).to be true
        expect(@artist1.songs.include? @folkSong2).to be true
      end
      it "increments the @song_count total" do
        expect(@artist1.song_count).to eq(2)
      end
      it "adds the new genre to empty @top_genres" do
        expect(@artist1.top_genres.include? @genre_folk).to be true
      end
      it "does not duplicate genre in empty @top_genres" do
        expect(@artist1.top_genres.length).to eq(1)
      end     
    end

    context "songs of 2 unique genres added" do

      include_context "add two songs with genre Blues"

      it "adds the new genre to @top_genres" do
        expect(@artist1.top_genres.include? @genre_blues).to be true
      end
      it "does not duplicate genre in @top_genres" do
        expect(@artist1.top_genres.length).to eq(2)
      end

    end

    context "songs of 3 unique genres added" do

      include_context "add two songs with genre Punk"

      it "adds the new genre to empty @top_genres" do
        expect(@artist1.top_genres.include? @genre_punk).to be true
      end
      it "does not duplicate genre in @top_genres" do
        expect(@artist1.top_genres.length).to eq(3)
      end

    end

    context "more songs of 4th unique genre added" do

      include_context "add three songs with genre Jazz" 

      it "updates @top_genres with new top genre" do
        expect(@artist1.top_genres.include? @genre_jazz).to be true
      end
      it "only includes 3 in @top_genres" do
        expect(@artist1.top_genres.length).to eq(3) 
      end
    end 

    it "errors instead of adding a duplicate song" do 
      artist = Artist.new(name: 'Janie Bigs')
      folkSong = Song.new(name: 'Purple Song', genre: 'Folk')
      artist.add_song(song: folkSong)
      expect { artist.add_song(song: folkSong) }.to raise_error(RuntimeError)
    end

    it "errors if param not Song class instance" do 
      notSong = "I am a string, not a song."
      expect { @artist1.add_song(song: notSong) }.to raise_error(RuntimeError)
    end

  end

  describe "#remove_song" do 
    
    include_context "create artist instance artist1"
    include_context "add two songs with genre Folk"

    it "removes song from artist's songs" do 
      expect(@artist1.songs.include? @folkSong1).to be true
      @artist1.remove_song(song: @folkSong1)
      expect(@artist1.songs.include? @folkSong1).to be false
      
    end 

    it "decrements @song_count" do 
      expect(@artist1.song_count).to eq(1)
    end

    context "one song of a genre remains" do
      it "removes the genre with last song" do
        @artist1.remove_song(song: @folkSong2)
        expect(@artist1.top_genres.include? @genre_folk).to be false
        expect(@artist1.top_genres.length).to eq(0)
      end
    end

    it "errors when a song cannot be found" do 
      expect { @artist1.remove_song(song: @folkSong1) }.to raise_error(RuntimeError)
    end

    it "errors if param not Song class instance" do 
      notSong = "I am a string, not a song."
      expect { @artist1.remove_song(song: notSong) }.to raise_error(RuntimeError)
    end

  end

  describe "#set_featured_song" do

    include_context "create artist instance artist1"
    include_context "add two songs with genre Folk"

    it "sets @featured_song_id" do
      @artist1.set_featured_song(song: @folkSong1)
      expect(@artist1.featured_song_id).to eq(@folkSong1.id)
    end

    it "updates @featured_song_id" do 
      @artist1.set_featured_song(song: @folkSong2)
      expect(@artist1.featured_song_id).to eq(@folkSong2.id)
    end

    it "removes featured song if song is removed" do
      @artist1.remove_song(song: @folkSong2)
      expect(@artist1.featured_song_id).to eq(nil)
    end

    it "errors if song set as featured not found" do 
      otherSong = Song.new(name: 'Other Song', genre: 'Punk')
      expect { @artist1.set_featured_song(song: otherSong) }.to raise_error(RuntimeError)
    end

    it "errors if param not Song class instance" do 
      notSong = "I am a string, not a song."
      expect { @artist1.set_featured_song(song: notSong) }.to raise_error(RuntimeError)
    end

  end

  describe "#print_readable" do
    include_context "create artist instance artist1"

  it "can print a readable representation" do 
    readable = "{ id: #{@artist1.id}, name: '#{@artist1.name}', song_count: #{@artist1.song_count}, top_genres: #{@artist1.top_genres}, featured_song_id: #{@artist1.featured_song_id} }"
    expect(@artist1.print_readable).to eq(readable)
  end

  end

end 
