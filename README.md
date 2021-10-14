# Coding Technical Challenge OOP In Pure Ruby With Rspec Tests

The following code was created to satisfy a coding challenge after submitting a job application and before interviwing with the company.

## Relevant Notes From Technical Challenge

- add and remove songs to an artist

- An artist can only have one featured song, but it's not required

- When a song is marked as featured, it should replace any currently featured song

- Every time you add or delete a song,
  the artist's top 3 genres and song count are recalculated

- Upon song addition/removal, the output should print the artist's updated information (see example)

>

    $ artist = Artist.new(...)

    $ song = Song.new(...)

    $ artist.add_song(song) # name "add_song" however you wish

    $ { id: 1, name: 'Some Artist', song_count: 2, top_genres: ['Folk', 'Pop', 'Rock'], featured_song_id: 3 }

Review will be based on:

- cleanliness
- method naming/length
- understanding of data design
- appropriate test coverage
