#!/usr/bin/env ruby

require './sieve.rb'

class P095
  MAX_NUMBER = 1000000

  def initialize
    @primes = get_primes(MAX_NUMBER)
    @next_in_chain = Array.new(MAX_NUMBER + 1)
    @visited = Array.new(MAX_NUMBER + 1).fill(false)
    @max_length = 0
    @start_of_cycle = 0
  end

  def get_prime_divisors(x)
    result = []
    @primes.each do |prime|
      return result if prime > x
      count = 0
      while x % prime == 0
        count += 1
        x /= prime
      end
      if count > 0
        result << { divisor: prime, count: count }
      end
    end
    result
  end

  def get_divisors_sum(prime_divisors, start, product)
    if start >= prime_divisors.length
      return product
    end
    sum = 0
    (0..prime_divisors[start][:count]).each do
      sum += get_divisors_sum(prime_divisors, start + 1, product)
      product *= prime_divisors[start][:divisor]
    end
    sum
  end

  def get_next_in_chain(x)
    prime_divisors = get_prime_divisors(x)
    get_divisors_sum(prime_divisors, 0, 1) - x
  end

  def dfs(x, depth, start)
    return if @visited[x] || x < 1
    @visited[x] = true
    if @next_in_chain[x] <= MAX_NUMBER
      if @visited[@next_in_chain[x]]
        if (@next_in_chain[x] == start && depth > @max_length)
          @max_length = depth
          @start_of_cycle = start
        end
      else
        dfs(@next_in_chain[x], depth + 1, start)
      end
    end
    @visited[x] = false
  end

  def main
    puts 'Started'
    puts 'Calculating next in chain...'
    (1..MAX_NUMBER).each do |n|
      if n % 10000 == 0
        puts n
      end
      @next_in_chain[n] = get_next_in_chain(n)
    end
    puts 'DFS...'
    (1..MAX_NUMBER).each do |n|
      dfs(n, 1, n)
    end
    result = @start_of_cycle
    current = @next_in_chain[@start_of_cycle]
    while current != @start_of_cycle
      if (current < result)
        result = current
      end
      current = @next_in_chain[current]
    end
    puts result
  end
end

P095.new.main
