# frozen_string_literal: true

require_relative 'hangman'
require_relative 'serialize'

word_list = File.readlines('/Users/carisaelam/odin-repos/ruby/odin-hangman/dictionary.txt').map(&:chomp)

filtered_words = word_list.select { |word| word.length.between?(5, 12) }

game = Hangman.new(filtered_words)
game.start
