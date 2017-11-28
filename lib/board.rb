class Board
  attr_reader :gapped_solution, :already_guessed

  def initialize(solution_length)
    @gapped_solution = []
    solution_length.times {@gapped_solution.push("__")}
    @gallows_array = ["        ________","       |       ", "       |       ","       |       ","       |       ","       |       ","     __|__     "]
    @already_guessed = []
  end

  def user_display
    display_gallows
    display_gapped_solution
    display_already_guessed
  end

  def display_gapped_solution
    puts "\n\n#{@gapped_solution.join("   ")}\n\n"
  end

  def update_gapped_solution(indices_of_matches, guess)
    indices_of_matches.each do |index_of_match|
      @gapped_solution[index_of_match] = guess
    end
  end

  def display_gallows
    @gallows_array.each do |element|
      puts element
    end
  end

  def update_gallows(incorrect_guesses_made)
    case incorrect_guesses_made
    when 1
      @gallows_array[1] = "       |       |"
    when 2
      @gallows_array[2] = "       |       0\n"
    when 3
      @gallows_array[3] = "       |       |"
    when 4
      @gallows_array[3] = "       |      /|"
    when 5
      @gallows_array[3] = "       |      /|\\"
    when 6
      @gallows_array[4] = "       |      /"
    when 7
      @gallows_array[4] = "       |      /\\"
    end
  end

  def update_already_guessed(guess)
    @already_guessed.push(guess)
  end

  def display_already_guessed
    puts "Already guessed: #{@already_guessed.join(", ")}\n\n" unless @already_guessed.length < 1
  end

  def display_final_gallows
    final_gallows_array = ["   ________","  |       |","  |       0\n","  |      /|\\ ","  |      / \\","  |         ","__|__"]
    final_gallows_array.each do |element|
      puts "                                #{element}"
    end
  end

end
