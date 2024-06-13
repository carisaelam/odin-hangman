# [ ] Load dictionary and randomly select 5-12 char word
# [ ] Display number of incorrect guesses remaining
# [ ] Display board '_ _ _' => 'c _ t' => 'c a t'
# [ ] Collect guess from player
# [ ] Update board accordingly '_ _ _' => 'c _ t' => 'c a t'

dictionary = '/Users/carisaelam/odin-repos/ruby/odin-hangman/dictionary.txt'

# Open the file and read its contents
word_list = File.open(dictionary, 'r') do |file|
  contents = file.readlines
end

# [x] Randomly select 5–12 char word from a list
def secret_word(word_list)
  filtered_list = word_list.select { |word| word.chars.length > 5 && word.chars.length < 12 }
  secret_word = filtered_list.sample
  puts secret_word
end

secret_word(word_list)
