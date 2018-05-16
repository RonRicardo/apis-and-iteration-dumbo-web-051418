require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  # character_hash['results'].each do |the_character, character_data|
  #   puts "#{the_character}"
  #   binding.pry
  #
  # end
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

def parse_character_movies(character_name)
  counter = 0
  # some iteration magic and puts out the movies in a nice list
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  char_data = character_hash['results']
  selected_char = char_data.find do |character|
    character['name'] == character_name
    while counter < character['films'].length do
      puts "#{counter}. #{character['films']}"
      counter += 1
    end
  end
  binding.pry
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?

#puts get_character_movies_from_api('Luke Skywalker')
puts parse_character_movies('Luke Skywalker')
