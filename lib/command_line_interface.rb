require "pry"

def welcome
  puts "Welcome to a galaxy. Far, far away, it is."
end

def get_character_from_user
  puts "please enter a character"
  input = gets.chomp.downcase
  # use gets to capture the user's input. This method should return that input, downcased.
end
