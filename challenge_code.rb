# RSpec App test code

context "POST /artists" do
  it "inserts a new database entry" do
  response = post(
    '/artists',
    name: 'Wild Nothing',
    genre: 'Indie'
    )

  expect(response.status).to eq(200)
  expect(response.body).to eq ('')

  response = get('/artists')

  expect(response.body).to include('Wild Nothing')
end

# App code

post '/artists' do
  repo = ArtistRepository.new
  new_artist = Artist.new
  new_artist.name = params[:name]
  new_artist.genre = params[:genre]

  repo.create(new_artist)

  return ''
end
