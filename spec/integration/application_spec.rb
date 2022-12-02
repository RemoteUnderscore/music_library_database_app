require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "GET /albums" do
    it "should return the list of albums" do
      response = get('/albums')

      # expected_response = 'Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, Folklore, I Put a Spell on You, Baltimore, Here Comes the Sun, Fodder on My Wings, Ring Ring'
     
      expect(response.status).to eq (200)
      expect(response.body).to include ('<a href="/albums/ 6">Lover</a>')
      expect(response.body).to include ('<a href="/albums/ 3">Waterloo</a>')
      expect(response.body).to include ('<a href="/albums/ 2">Surfer Rosa</a>')
    end
  end

  context "GET /albums/new" do
    it "should return a form to create a new album" do
      response = get('/albums/new')

      expect(response.status).to eq(200)
      expect(response.body).to include('<form method="POST" action="/albums">')
      expect(response.body).to include('<input type="text" name="title" />')
      expect(response.body).to include('<input type="text" name="release_year" />')
      expect(response.body).to include('<input type="text" name="artist_id" />')
  
    end
  end

  context "GET /albums/:id" do
    it "should return the info for album with id 1" do
      response = get('/albums/2')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Surfer Rosa</h1>')
      expect(response.body).to include('Release year: 1988')
      expect(response.body).to include('Artist: Pixies')

    end
  end

  context "GET /artists" do
    it "should return the list of artists" do
      response = get('/artists')

      expect(response.status).to eq (200)
      expect(response.body).to include ('<a href="/artists/ 1">Pixies</a>')
      expect(response.body).to include ('<a href="/artists/ 2">ABBA</a>')
      expect(response.body).to include ('<a href="/artists/ 3">Taylor Swift</a>')
    end
  end

  context "GET /artists/:id" do
    it "should return the info for the artist with id 2" do
      response = get('/artists/2')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>ABBA</h1>')
      expect(response.body).to include('Genre: Pop')
    end
  end

  context "GET /artists/new" do
    it "should return a form to create a new artist" do
      response = get('/artists/new')

      expect(response.status).to eq(200)
      expect(response.body).to include('<form method="POST" action="/artists">')
      expect(response.body).to include('<input type="text" name="name" />')
      expect(response.body).to include('<input type="text" name="genre" />')
    end
  end
  
  context "POST /albums" do
    it "inserts a new database entry" do
    response = post(
      '/albums',
      title: 'Voyage',
      release_year: '2022',
      artist_id: '2'
      )

    expect(response.status).to eq(200)
    expect(response.body).to eq ('')

    response = get('/albums')

    expect(response.body).to include('Voyage')
  end
end

#  context "POST /albums/new" do
#    it "should create an album, Selected Works, and return a confirmation" do
#      response = post('/albums', album_name: 'Selected Works')

#      expect(response.status).to eq(200)
#      expect(response.body).to include('')
#    end

#    it "should create an album, Day of the Dead, and return a confirmation" do
#      response = post('/albums', album_name: 'Day of the Dead')

#      expect(response.status).to eq(200)
#      expect(response.body).to include('')
#    end
#  end
  
  context "GET /artists" do
    it "should get a list of artists" do
      response = get('/artists')

      # expected_response = 'Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos'

      expect(response.status).to eq(200)
      expect(response.body).to include('Nina Simone')
    end

  context "POST /artists" do
    it "inserts a new database entry" do
    response = post(
      '/artists',
      name: 'Wild Nothing',
      genre: 'Indie'
      )

    expect(response.status).to eq(200)
    expect(response.body).to include ('Artist successfully added!')

    response = get('/artists')

    expect(response.body).to include('Wild Nothing')
  end
  end
end
end





