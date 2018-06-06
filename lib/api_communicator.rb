require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  format_film_hash(film_hash_to_array(character_hash, character))
end

# collect those film API urls, make a web request to each URL to get the info
#  for that film
# return value of this method should be collection of info about each film.
def format_film_hash(array)
  films_hash = {}
  array.each do |url|
    films_hash[url] = get_hash(url)
  end
  films_hash
end

def film_hash_to_array(hash, character)
  films_array = nil
  hash["results"].each do |attribute|
    if attribute["name"] == character
      films_array = attribute["films"]
    end
  end
  films_array
end

  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.

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
  user = get_user_input
  format_entry_hash(return_entry_hash(user))
end

def get_hash(url)
  JSON.parse(RestClient.get(url))
end

def return_entry_hash(input_string)
  data_hash = get_hash('http://www.swapi.co/api/')

  data_hash.each do |category, url|
    url_info = get_hash(url)
    end_of_file = 0
      while end_of_file == 0 do
        url_info["results"].each do |entry|
          if entry["name"]
            return entry if entry["name"] == input_string
          elsif entry["title"]
            return entry if entry["title"] == input_string
          end
        end
        if url_info["next"]
          url_info["results"] = get_hash(url_info["next"])["results"]
          url_info["next"] = get_hash(url_info["next"])["next"]
        else
          end_of_file = 1
        end
      end
    end
end

def format_entry_hash(hash)
  hash.each do |category, value|
    if value.class == String
      puts "#{category.capitalize}: #{value}."
    elsif value.class == Array
      display_string = "#{category.capitalize}: "
      value.each do |url|
        url_info = get_hash(url)
        if url_info["name"]
          display_string += url_info["name"] + ", "
        elsif url_info["title"]
          display_string += url_info["title"] + ", "
        end
      end
      puts display_string.chomp(", ")
    end
  end
end
