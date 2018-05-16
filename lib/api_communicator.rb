require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #parsing all characters
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  #finding the character we passed in
  character_data = character_hash['results']
  selected_character = character_data.find do |character_info|
      character_info['name'].downcase == character
  end

  #collecting the list of films for the character
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

# def parsing_all_characters(api='http://www.swapi.co/api/people/')
#   all_characters = RestClient.get(api)
#   character_hash = JSON.parse(all_characters)
# end
#
# def find_char(character_hash)
#   character_data = character_hash['results']
#   selected_character = character_data.find do |character_info|
#       character_info['name'].downcase == character
#   end
#   selected_character
# end
#
# def list_films(selected_char)
#   char_films = selected_char["films"]
#   films_hash = char_films.collect do |film|
#     RestClient.get(film)
#   end
#   films_hash
# end
#
# def bonus_show_character_movies(character)
#   all_characters = parsing_all_characters
#   find_char(all_characters)
#   films_hash = list_films(find_char)
#   parse_character_movies(films_hash)
#   binding.pry
# end
