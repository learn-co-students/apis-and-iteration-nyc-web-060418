require 'rest-client'
require 'json'
require 'pry'


def find_character (character)

  api_url = 'https://www.swapi.co/api/people/'
  chara_name = {}
  loop do


    all_characters = RestClient.get(api_url)
    character_hash = JSON.parse(all_characters)

    chara_name = character_hash["results"].find do |character_info|
      character_info["name"] == character
    end
    #p chara_name
    #p character_hash["next"]
    #p api_url
    if chara_name
      break
    elsif chara_name == nil
      api_url = character_hash["next"]
    end

  end

  chara_name
  #binding.pry
end


def get_character_movies_from_api(character)
  #make the web request
  film_hash_array = []

  name_hash = find_character(character)
  #binding.pry

  name_hash["films"].map do |film|
    film_list = RestClient.get(film)
    film_hash = JSON.parse(film_list)
    film_hash_array << film_hash
  end

  film_hash_array

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
  #binding.pry
end
#get_character_movies_from_api("Tion Medon")



def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.select do |movie_hash|
    puts "Episode #{movie_hash["episode_id"]}: #{movie_hash["title"]}"
  end
#binding.pry

end


#binding.pry


def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
