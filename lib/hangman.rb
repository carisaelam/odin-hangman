require 'yaml'
require_relative 'serialize'

class Hangman
  include Serialize

  attr_reader :lives, :board, :secret_word, :guesses, :word_list

  def initialize(word_list)
    @lives = 7
    @secret_word = word_list.sample
    @board = setup_board
    @guesses = []
    @word_list = word_list
  end

  def save_game
    puts 'Name your saved game. No spaces.'
    filename = gets.chomp
    to_yaml(filename)
    puts 'Your game has been saved!'
  end

  def setup_board
    Array.new(secret_word.size, '_')
  end

  def add_letters_to_guesses(guess)
    guesses.push(guess)
    puts "\n\nLetters Guessed: [#{guesses.sort.join(', ')}]"
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
    print "\nPlease guess a letter..."
    guess = gets.chomp
    if guess == 'save'
      save_game
      make_guess
    elsif guesses.include?(guess)
      puts "You've already guessed #{guess}. Pick another letter."
      make_guess
    else
      guess
    end
  end

  def board_state
    board.join(' ')
  end

  def reset_game
    @lives = 7
    @secret_word = word_list.sample
    @board = setup_board
    @guesses = []
  end

  def replay_game
    puts "\n\nDo you want to play again? (Y/N)"
    response = gets.chomp.downcase
    if response == 'y'
      reset_game
      start
    else
      nil
    end
  end

  def start
    puts "\nWELCOME TO HANGMAN\n\n"
    load_or_new
    puts "New Game!\n\nType save at the start of any guess to save your game."

    while lost? && !won?
      puts board_state
      puts "You have #{lives} lives left."
      guess = make_guess
      update_board(guess)
      add_letters_to_guesses(guess)

    end

    puts board_state
    if won?
      puts "\nYou won!"
    else
      puts "\nYou lost! The word was #{secret_word}"
    end
    replay_game
  end
end
