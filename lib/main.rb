require_relative 'hangman'

# [ ] dictionary_file = 'dictionary.txt'
# [ ] game = Game.new(dictionary_file)
# [ ] game.start

word_list = File.readlines('/Users/carisaelam/odin-repos/ruby/odin-hangman/dictionary.txt').map(&:chomp)

filtered_words = word_list.select { |word| word.length.between?(5, 12) }

game = Hangman.new(filtered_words)
game.start
