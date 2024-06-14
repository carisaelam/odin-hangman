require 'yaml'

module Serialize
  def load_game
    if File.exist?('saved_games') && !Dir.children('saved_games').empty?
      puts "Saved files: #{Dir.children('saved_games').join(', ')}"
      puts 'Type the name of your game (without the .yml)'
      filename = gets.chomp
      from_yaml(filename)
    else
      puts "No saved games\n\n"
      nil
    end
  end

  def to_yaml(filename)
    Dir.mkdir('saved_games') unless File.exist?('saved_games')
    File.open("saved_games/#{filename}.yml", 'w') do |file|
      YAML.dump({
                  secret_word: @secret_word,
                  board: @board,
                  lives: @lives,
                  guesses: @guesses
                }, file)
    end
    puts "\nGame Saved"
  end

  def from_yaml(filename)
    f = YAML.load(File.read("saved_games/#{filename}.yml"))
    @secret_word = f[:secret_word]
    @board = f[:board]
    @lives = f[:lives]
    @guesses = f[:guesses]
    puts "\nGame Loaded"
  end

  def load_or_new
    puts 'Type "load" to load a game or "new" to start a new game!'
    selection = gets.chomp
    puts ' '
    selection == 'load' ? load_game : return
  end
end
