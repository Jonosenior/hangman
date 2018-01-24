require 'sinatra'
require 'erb'
require 'sinatra/reloader'

enable :sessions

def random_word
  dictionary = File.readlines('lib/5desk.txt').map {|word| word.chomp}
  possible_answers = dictionary.select { |word| (word.length > 4) && (word.length < 13) }
  possible_answers.sample.downcase
end

get '/' do
  erb :home
end

post '/' do
  reset_variables
  redirect '/play'
end

get '/play' do
  get_all_session_data
  redirect to('/win') if success?
  redirect to('/lose') if failure?
  erb :play
end

post "/play" do
  get_all_session_data
  evaluate_guess
  session[:guesses_remaining] -= 1
  # work out if guess matches solution
  redirect "/play"
end

get '/win' do
  erb :win
end

get '/lose' do
  erb :lose
end


def reset_variables
  solution = random_word.split("")
  session[:solution] = solution
  session[:guesses_remaining] = 6
  session[:incorrect_guesses] = []
  session[:gapped_solution] = []
  solution.length.times { session[:gapped_solution] << "__" }
end

def get_all_session_data
  @gapped_solution = session[:gapped_solution]
  @incorrect_guesses = session[:incorrect_guesses]
  @solution = session[:solution]
  @guesses_remaining = session[:guesses_remaining]
  @guess = params["guess"] if params["guess"]
end

def evaluate_guess
  if @solution.include?(@guess)
    session[:gapped_solution] = update_gapped_solution
  else
    session[:incorrect_guesses] << @guess
  end
end

def update_gapped_solution
  correct_letters = @solution.each_index.select { |index| @solution[index] == @guess }
  correct_letters.each { |e| @gapped_solution[e] = @guess  }
  @gapped_solution
end

def success?
  false
  # @solution == @gapped_solution
  # !@gapped_solution.include?("__")
end

def failure?
  @guesses_remaining < 1
end





#####
# @good_guesses = []
# @secret_word.length.times do
#   @good_guesses << "_"
# end
# @bad_guesses = []
# end
#
# def evaluate_guess(guess)
#   if @secret_word.include?(guess)
#     correct_letters = @secret_word.each_index.select { |index| @secret_word[index] == guess }
#     correct_letters.each { |e| @good_guesses[e] = guess  }
#   else
#     @bad_guesses << guess
#   end
# end
#
#
#
# #### Jono's gapped solution
#
#
# def return_indices_of_guess
#   indices_of_matches = []
#   @solution.split("").each_with_index do |letter, index|
#     if letter == @guess then indices_of_matches.push(index) end
#   end
#   indices_of_matches
# end
#
#
# def update_gapped_solution(indices_of_matches, guess)
#   indices_of_matches.each do |index_of_match|
#     @gapped_solution[index_of_match] = guess
#   end
# end
