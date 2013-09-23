class WordChains
  attr_reader :dictionary
  # delete this comment
  def initialize
    @dictionary = File.readlines("dictionary.txt").map(&:chomp).select { |item| !item.nil? }
    @visited_words = []
    @current_words = []
    @new_words = []
    @visited_words_hash = Hash.new(0)
    @visited_words_path = []
  end

  def one_different_char?(str, other)
    other_str = other.dup
    mismatches = 0
    return false if str.split("").count != other.split("").count
    other_str.split("").count.times do |i|
      if other_str[i] != str[i]
        mismatches += 1
      end
    end
    mismatches == 1
  end
  
  def adjacent_words(word)
    [].tap do |adjacent_word_list|
      @dictionary.each do |dictionary_word|
        if one_different_char?(word, dictionary_word)
          adjacent_word_list << dictionary_word
        end
      end
    end
  end

  def find_chain(start_word, end_word)

    @same_length_dictionary_words = @dictionary.select { |dictionary_word| dictionary_word.size == start_word.size }  
    @current_words << start_word
    @visited_words << start_word
    @visited_words_hash[start_word] = nil
    
    until @current_words.empty? || @visited_words_hash.has_key?(end_word) 
      parent_word = @current_words.shift
      adjacent_words(parent_word).each do |word|
        @visited_words_hash[word] = parent_word unless @visited_words_hash.has_key?(word)
        @new_words << word unless @visited_words.include?(word)
        @visited_words << word unless @visited_words.include?(word)
        p @visited_words_hash
        return word if word == end_word
        end
                
      @current_words += @new_words
      @new_words.clear
    end
  end

  def build_chain(word)
    return word if @visited_words_hash[word] == nil
    prev_parents = build_chain(@visited_words_hash[word])
    prev_parents << " " + word
  end
end
      
