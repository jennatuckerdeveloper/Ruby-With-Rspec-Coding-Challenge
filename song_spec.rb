require 'rspec'
require_relative 'song'

describe Song do

  describe "Song::new" do 

      let(:song_name) {'Blue Song'}
      let(:genre_string) {'Folk'}
      let(:song) { Song.new(name: song_name, genre: genre_string) } 

    context "with valid initialization params" do
      it "is assigned an @id" do
        expect(song.id).to eq(0)
      end
      it "is assigned the @name param" do
        expect(song.name).to eq(song_name)
      end
      it "is assigned the @genre param" do
        expect(song.genre).to eq(genre_string)
      end
      it "increments ::next_song_instance_id" do
        next_id = song.class.next_song_instance_id
        expect(next_id).to eq(song.id + 1)
      end
      it "uses a unique id for songs" do 
        song2 = Song.new(name: 'Red Song', genre: 'Punk')
        expect(song2.id).not_to eq(song.id)
      end

    end

    context "without all initialization params" do
      it "errors without name keyword param" do
        expect { Song.new(genre: genre_string)}.to raise_error(ArgumentError)
      end
      it "errors without genre keyword param" do
        expect { Song.new(name: song_name)}.to raise_error(ArgumentError)
      end
      it "errors with empty string for name" do
        expect { Song.new(name: '', genre: genre_string)}.to raise_error(RuntimeError)
      end
      it "errors with empty string for genre" do
        expect { Song.new(name: song_name, genre: '')}.to raise_error(RuntimeError)
      end
    end
  end  
end

