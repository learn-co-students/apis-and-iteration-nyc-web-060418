require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  films_arr = []
  character_hash['results'].each do |data|
    if data['name'].downcase.include?(character)
      film_urls_array = data['films']
      film_urls_array.each do |url|
        film_json = RestClient.get(url)
        film_hash = JSON.parse(film_json)
        films_arr << film_hash
      end
    end
  end
  films_arr
end

def parse_character_movies(films_arr)
  films_arr.each {|film| puts film['title']}
end

def show_character_movies(character)
  films_arr = get_character_movies_from_api(character)
  parse_character_movies(films_arr)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
