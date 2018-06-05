require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)


  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  films_array = nil
  character_hash["results"].each do |attribute|
    if attribute["name"] == character
      films_array = attribute["films"]
    end
  end



  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  films_hash = {}
  films_array.each do |url|
    films_hash[url] = RestClient.get(url)
    films_hash[url] = JSON.parse(films_hash[url])
  end

  # return value of this method should be collection of info about each film.
  films_hash
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.

end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  return_array = []
  films_hash.each do |film|
    return_array.push(film[1]["title"])

  end
  return_array
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  arr = parse_character_movies(films_hash)
  arr.each do |film|
    puts film
  end
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?

def get_user_input
  gets.chomp
end

def search_user_input
  puts "Input search term: "
  get_user_input
end

show_character_movies("Luke Skywalker")
