require 'rspec'
require_relative 'song'

describe Song do

  let(:songName) {'Blue Song'}
  let(:genreString) {'Folk'}

  it "creates a song" do
    song = Song.new(name: songName, genre: genreString)
    expect(song.id).to eq(0)
    expect(song.name).to eq(songName)
    expect(song.genre).to eq(genreString)
  end

  it "increments a class variable for the next ID" do
    nextID = Song.nextSongInstanceID
    expect(nextID).to eq(1)
  end

  it "errors without a name keyword param" do
    expect { Song.new(genre: genreString)}.to raise_error(ArgumentError)
  end

  it "errors without a genre keyword param" do
    expect { Song.new(name: songName)}.to raise_error(ArgumentError)
  end

end
