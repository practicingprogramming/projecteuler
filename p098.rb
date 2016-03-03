#!/usr/bin/env ruby

require 'set'

class P098
  MAX_SQUARE = 10000000000

  def initialize
    @squares = {}
    @words = { }
    @max_square = 0
  end

  def calc_squares
    (1..Math.sqrt(MAX_SQUARE)).each do |i|
      square = i * i
      len = number_length(square)
      if !@squares.key?(len)
        @squares[len] = Set.new
      end
      @squares[len] << square
    end
  end

  def number_length(x)
    return 1 if x < 10
    sum = 0
    while x > 0
      sum += 1
      x /= 10
    end
    sum
  end

  def valid_match?(word, square)
    match = {}
    (0...word.length).each do |i|
      char = word[word.length - i - 1]
      digit = square % 10
      square /= 10
      if match.key?(char) && match[char] != digit
        return false
      end
      match[char] = digit
    end
    match.values.length == match.values.uniq.length
  end

  def transform(square, w1, w2)
    match = {}
    (0...w1.length).each do |i|
      char = w1[w1.length - i - 1]
      digit = square % 10
      square /= 10
      match[char] = digit
    end
    sum = 0
    (0...w2.length).each do |i|
      char = w2[i]
      sum = sum * 10 + match[char]
    end
    sum
  end

  def try_words(words, len)
    (0...words.length).each do |i|
      (i+1...words.length).each do |j|
        w1 = words[i]
        w2 = words[j]
        next if !anagrams?(w1, w2)
        @squares[len].each do |square|
          next if !valid_match?(w1, square)
          square2 = transform(square, w1, w2)
          next if square == square2
          next unless @squares[len].include?(square2)
          puts "#{w1} and #{w2} match as #{square} and #{square2}"
          @max_square = square if square > @max_square
          @max_square = square2 if square2 > @max_square
        end
      end
    end
  end

  def anagrams?(w1, w2)
    w1.chars.to_a.sort.join == w2.chars.to_a.sort.join
  end

  def read_words
    content = File.read('./p098_words.txt')
    words = content.split(',')
    words.each do |word|
      word = word.gsub('"', '')
      len = word.length
      @words[len] = [] if !@words.key?(len)
      @words[len] << word
    end
  end

  def main
    calc_squares
    read_words
    @words.keys.each do |len|
      try_words(@words[len], len)
    end
    puts "Answer: #{@max_square}"
  end
end

P098.new.main
