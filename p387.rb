#!/usr/bin/env ruby

require './common.rb'

MAX_HARSHAD_PRIME = 100_000_000_000_000
MAX_HARSHAD_NUMBER = MAX_HARSHAD_PRIME / 10

class P387
  def initialize
    @right_trancatable_harshad_numbers = []
    @strong_right_trancatable_harshad_primes = []
  end

  def main
    gen_harshad_numbers
    puts "Strong right trancatable harshad primes: #{@strong_right_trancatable_harshad_primes}"
    sum = @strong_right_trancatable_harshad_primes.inject(&:+)
    puts sum
  end

  def gen_harshad_numbers
    (1..9).each do |i|
      @right_trancatable_harshad_numbers << i
    end
    index = 0
    while index < @right_trancatable_harshad_numbers.size do
      current = @right_trancatable_harshad_numbers[index]
      index += 1
      (0..9).each do |right|
        candidate = current * 10 + right
        break if candidate > MAX_HARSHAD_NUMBER
        sod = sum_of_digits(candidate)
        if (candidate % sod == 0)
          @right_trancatable_harshad_numbers << candidate
          div = candidate / sod
          if prime?(div)
            check_number(candidate)
          end
        end
      end
    end
  end

  def check_number(number)
    (1..9).each do |right|
      candidate = number * 10 + right
      @strong_right_trancatable_harshad_primes << candidate if candidate < MAX_HARSHAD_PRIME && prime?(candidate)
    end
  end
end

P387.new.main
