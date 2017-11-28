class Game

  def initialize
    @dictionary = File.readlines('5desk.txt').map {|word| word.chomp}
    @possible_answers = @dictionary.select do |word|
      (word.length > 4) && (word.length < 13)
    end
    @solution = @possible_answers.sample.downcase
    @board = Board.new(@solution.length)
    @incorrect_guesses_made = 0
    @incorrect_guesses_allowed = 7
    @incorrect_guesses_remaining = (@incorrect_guesses_allowed - @incorrect_guesses_made)
    @total_guesses_made = 0
    start
    #puts @board.display_gapped_solution
    #puts @solution
  end

  def start
    introduce_game
    while @incorrect_guesses_made < @incorrect_guesses_allowed
      new_turn
      if !(is_guess_valid?)
        puts "Ugh - make a real guess."
        redo
      elsif is_guess_repeated?
        puts "You already guessed #{@guess}. Try again..."
        redo
      end
      if is_guess_correct?
        @board.update_gapped_solution(return_indices_of_guess, @guess)
      else
        incorrect_guess
      end
      if is_solution_complete? then win end
      @total_guesses_made += 1
    end
    lose
  end

  def is_guess_repeated?
    @board.already_guessed.include?(@guess) || @board.gapped_solution.include?(@guess)
  end

  def new_turn
    puts "\n\nGUESS #{@total_guesses_made + 1}\n\n"
    @board.user_display
    ask_user_input
  end

  def lose
    @board.display_final_gallows
    puts "\n\n                                YOU LOSE\n\n"
    puts "The solution was #{@solution} (obviously).\n\n"
    play_again
  end

  def win
    @board.display_gapped_solution
    puts "\n\nYOU WIN\n\n"
    puts "The answer was #{@solution}"
    puts "You live to guess another day!"
    puts "Well done!\n\n"
    play_again
  end

  def play_again
    puts "Do you want to play again (y/n)?"
    ans = gets.chomp
    case ans.downcase
    when "y"
      game = Game.new
    when "n"
      puts "See you next time!"
      exit
    else
      puts "Choose y or n!"
      play_again
    end
  end

  def is_solution_complete?
    @board.gapped_solution.join == @solution
  end

  def is_guess_correct?
    @solution.include?(@guess)
  end

  def return_indices_of_guess
    indices_of_matches = []
    @solution.split("").each_with_index do |letter, index|
      if letter == @guess then indices_of_matches.push(index) end
    end
    indices_of_matches
  end

  def incorrect_guess
    puts "Uh-oh! That's not right.\n\n"
    @incorrect_guesses_made += 1
    @board.update_gallows(@incorrect_guesses_made)
    @board.update_already_guessed(@guess)
    #puts "You have #{@incorrect_guesses_remaining} incorrect guesses left..."
  end

  def introduce_game
    write_title
    @board.display_final_gallows
    puts "\n\n\nWelcome to Hangman.\n"
    puts "The computer chooses a random word from the dictionary."
    puts "It's your job to guess it.\n\n"
  end

  def ask_user_input
    puts "Please choose a letter."
    @guess = gets.chomp
  end

  def is_guess_valid?
    return false if @guess.length > 1
    return false if @guess[/[a-zA-Z]+/] != @guess
    true
  end

end
