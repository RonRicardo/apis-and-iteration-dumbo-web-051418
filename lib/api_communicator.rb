require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  character_data = character_hash['results']
  selected_character = character_data.find do |character_info|
      character_info['name'] == character
  end
  char_films = selected_character["films"]
  films_hash = char_films.collect do |film|
    RestClient.get(film)
  end
  films_hash
end

def parse_character_movies(films_hash)
  parsed_films = films_hash.collect do |unparsed_film|
    JSON.parse(unparsed_film)
  end
  film_titles = parsed_films.collect do |film|
    film['title']
  end
  film_titles.each_with_index {|film, index| puts "#{index + 1} #{film}"}
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
