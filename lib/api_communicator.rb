require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  films_arr = []
  page = 0
  hit = false
  loop do
    page_url = "http://www.swapi.co/api/people/?page=#{page += 1}"
    people_hash = JSON.parse(RestClient.get(page_url))
    character_arr = people_hash['results']
    character_arr.each do |data|
      if data['name'].downcase == character.downcase
        film_urls_array = data['films']
        film_urls_array.each do |url|
          film_hash = JSON.parse(RestClient.get(url))
          films_arr << film_hash
        end
        hit = true
      end
    end
    if hit == true
      break
    elsif people_hash['next'] == nil
      break
    end
  end
  films_arr
end

def parse_character_movies(films_arr)
  p films_arr.map {|film| film['title']}
end

def show_character_movies(character)
  films_arr = get_character_movies_from_api(character)
  parse_character_movies(films_arr)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
