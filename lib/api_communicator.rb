require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  character_data = character_hash['results']
  selected_character = character_data.find do |character_info|
      character_info['name'] == character
  end
  return selected_character["films"]

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

def parse_character_movies(films_array) #films_hash
  # some iteration magic and puts out the movies in a nice list
  # films_array.collect do |film|
  #   scraped_films = RestClient.get(film)
  #   parsed_films = JSON.parse(scraped_films)
  # end
  #JSON.parse(RestClient.get(films_array[0]))['title']
  binding.pry
end

def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  parse_character_movies(films_array)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?

show_character_movies('Luke Skywalker')
