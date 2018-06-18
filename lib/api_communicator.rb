# June 5 2018
# Star Wars API Lab
# by Laura Nadolski and Risher Randall

require 'rest-client'
require 'json'
require 'pry'


def web_request_helper(url)
  film_information = RestClient.get(url)
  film_information_hash = JSON.parse(film_information)
  return film_information_hash
end


def get_character_movies_from_api(character)
  #make the web request
  helper_array = []
  api_link = 'http://www.swapi.co/api/people/'

  while helper_array.length == 0
    all_characters = RestClient.get(api_link)
    character_hash = JSON.parse(all_characters)

    character_hash["results"].each do |character_array|
      if character_array["name"].downcase == character.downcase
        character_array["films"].map do |film|
          helper_array.push web_request_helper(film)
        end
      end
    end
        api_link = character_hash["next"]
  end
  return helper_array

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

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.each_with_index do |movie_hash, index|
    movie_title = movie_hash["title"]
    puts "#{index + 1} " + movie_title
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end



## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
