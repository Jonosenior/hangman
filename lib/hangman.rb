require File.expand_path("../board", __FILE__)
require File.expand_path("../game", __FILE__)
require File.expand_path("../title", __FILE__)

def introduce_game
  write_title
  display_final_gallows
  puts "\n\n\nWelcome to Hangman.\n"
  puts "The computer chooses a random word from the dictionary."
  puts "It's your job to guess it.\n\n"
end

def new_or_load_game
  puts "Choose:"
  puts "1: Start a new game"
  puts "2: Load a saved game"
  ans = gets.chomp.to_i
  case ans
  when 1
    @game = Game.new
  when 2
    load_game
  else
    puts "Choose 1 or 2!\n\n"
    new_or_load_game
  end
end

def load_game
  begin
    output = File.new("save_file.yml", "r")
    saved_board_and_game = YAML.load(output.read)
    output.close
    @board = saved_board_and_game[0]
    @game = saved_board_and_game[1]
    @game.start
  rescue
    puts "No save file found! Starting new game instead..."
    @game = Game.new
  end
end

introduce_game
new_or_load_game
