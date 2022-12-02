# Ruby code from app.rb

get '/artists' do
    repo = ArtistRepository.new
    @artists = repo.all

      response = @artists.map do |artist|
      @name = artist.name
      @genre = artist.genre
      @id = artist.id
      artist
    end

    return erb(:artists)
  end

get '/artists/:id' do
  id = params[:id]

  repo = ArtistRepository.new
  artist = repo.find(id)
  @name = artist.name
  @genre = artist.genre

  return erb(:artist)
end

# html code using ERB

<html>
<head></head>
<body>
  <h1>Artists</h1>
  <% @artists.each do |artist| %>
    <div>
    Name: 
    <a href="/artists/ <%= artist.id %>"><%= artist.name %></a> - 
      Genre: <%= artist.genre %>
    </div>
    <% end %>
  </body>
</html>

<html>
  <head></head>
    <body>
      <h1><%= @name %></h1>
      <p>
        Genre: <%= @genre %>
        <br>
      </p>
      <a href="/artists">Back</a>
    </body>
</html>