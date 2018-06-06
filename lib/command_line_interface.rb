require_relative "./api_communicator.rb"

def welcome
  # puts out a welcome message here!
  puts "Hello!"
end

def get_character_from_user
  puts "please enter a character"
  # use gets to capture the user's input. This method should return that input, downcased.
  search_user_input
end
