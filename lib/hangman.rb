class Hangman
  attr_reader :lives, :board, :secret_word, :guesses

  def initialize(word_list)
    @lives = 7
    @secret_word = word_list.sample
    @board = setup_board
    @guesses = []
  end

  def setup_board
    Array.new(secret_word.size, '_')
  end

  def start
    puts 'WELCOME TO HANGMAN'
    while lost? && !won?
      puts "You have #{lives} lives left."
      puts board_state
      guess = make_guess
      update_board(guess)
      add_letters_to_guesses(guess)
    end

    puts board_state
    if won?
      puts 'You won!'
    else
      puts "You lost! The word was #{secret_word}"
    end
  end

  def add_letters_to_guesses(guess)
    guesses.push(guess)
    puts "Letters Guessed: [#{guesses.sort.join(', ')}]"
  end

  def lost?
    lives >= 1
  end

  def won?
    board.join('') == secret_word
  end

  def update_board(guess)
    if secret_word.include?(guess)
      i = 0
      while i < secret_word.size
        board[i] = secret_word[i] if guess.downcase == secret_word[i].downcase
        i += 1
      end
    else
      @lives -= 1
    end
  end

  def make_guess
    print 'Please guess a letter...'
    guess = gets.chomp
    if guesses.include?(guess)
      puts "You've already guessed #{guess}. Pick another letter."
      make_guess
    else
      guess
    end
  end

  def board_state
    board.join(' ')
  end
end
