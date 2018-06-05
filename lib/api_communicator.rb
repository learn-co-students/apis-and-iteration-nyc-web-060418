require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
end

def find_character(character)
  character_result_hash = get_character_movies_from_api(character)
  character_result_hash.each do |key, value|
    if key == "results"
      value.each do |individual_character_hash|
        individual_character_hash.each do |attribute, detail|
          if detail == character
            return individual_character_hash
          end
        end
      end
    end
  end
end

def find_movies(character)
  target_hash = find_character(character)
  target_hash.each do |attribute, detail|
    if attribute == "films"
      return detail
    end
  end
end

def film_info_request(character)
  film_array = find_movies(character)
  film_array.collect do |url|
    film_result = RestClient.get(url)
    film_result_hash = JSON.parse(film_result)
  end
end


  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.



def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
