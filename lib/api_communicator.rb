require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  collected_films = []
  films_hash = {}
  character_hash["results"].each do |hash|
    hash.find do |name, value|
      if name == "name" && value.downcase == "#{character}"
        hash["films"].each do |url|
          collected_films << url
        end
      end
    end
  end
  collected_films.each do |url|
    film_api = RestClient.get(url)
    film_info_hash = JSON.parse(film_api)
    films_hash[url] = film_info_hash
  end
  films_hash
end

def parse_character_movies(films_hash)
  titles_array = []
  films_hash.each do |url, movie_data|
    movie_data.find do |key, title|
      if key == "title"
        titles_array << title
      end
    end
  end
  titles_array.each_with_index do |name, index|
    puts "#{index+1} #{name}"
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end
## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
