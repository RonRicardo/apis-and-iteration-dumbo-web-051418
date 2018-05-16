require 'pry'

def welcome
  puts "please enter a character"
end

def get_character_from_user
  user_input = gets.chomp
  user_input.downcase
  # use gets to capture the user's input. This method should return that input, downcased.
end
