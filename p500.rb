#!/usr/bin/env ruby

require './sieve.rb'

MAX_PRIME = 10000000

#TARGET_POWER = 100
#TARGET_POWER = 4
TARGET_POWER = 500500

MODULO = 500500507

# TODO: save "best existing candidate"
class P500

  def initialize
    @primes = get_primes(MAX_PRIME)
  end

  def get_next
    min = @primes[@max_used_prime_index + 1]
    chosen_prime = @primes[@max_used_prime_index + 1]
    if @used_candidate == -1
      min_used = -1
      (0..@max_used_prime_index).each do |i|
        used_prime = @primes[i]
        current_power = @current_divisors[used_prime]
        option = used_prime ** (current_power + 1)
        if chosen_prime == -1 || option < min
          min = option
          chosen_prime = used_prime
        end
        if min_used == -1 || option < min_used
          @used_candidate = used_prime
          @used_option = option
          min_used = option
        end
      end
    else
      #puts 'Saving re-calculating used primes'
      if @used_option < min
        chosen_prime = @used_candidate
        min = @used_option
      end
    end
    if chosen_prime == @primes[@max_used_prime_index + 1]
      @current_divisors[@primes[@max_used_prime_index + 1]] = 1
      @max_used_prime_index += 1
    else
      @current_divisors[chosen_prime] = @current_divisors[chosen_prime] * 2 + 1
      #puts 'Resetting used option'
      @used_candidate = -1
    end
  end

  def main
    puts 'Started'

    @current_divisors = {2 => 1}
    @max_used_prime_index = 0

    @used_candidate = -1
    @used_option = -1

    (TARGET_POWER - 1).times do |i|
      if i % 100 == 0
        puts "Iteration #{i}"
      end
      get_next
      #puts @current_divisors
    end

    res = 1
    (0..@max_used_prime_index).each do |i|
      used_prime = @primes[i]
      @current_divisors[used_prime].times do
        res = (res * used_prime) % MODULO
      end
    end
    puts "Answer: #{res}"
  end
end

P500.new.main
