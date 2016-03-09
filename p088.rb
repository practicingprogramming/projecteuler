#!/usr/bin/env ruby

require 'set'

class P088
  MAX_LENGTH = 12000

  def initialize
  end

  def try(start_position, non_zero_length, length, sum, mult)
    return if mult >= @current_min || sum >= @current_min
    if mult == sum
      @current_min = mult
    end
    return if start_position >= non_zero_length
    backup_start = @a[start_position]
    backup_sum = sum
    backup_mult = mult
    while true
      @a[start_position] += 1
      mult = backup_mult / backup_start * @a[start_position]
      sum += 1
      if mult > @current_min || sum > @current_min || (start_position > 0 && @a[start_position] > @a[start_position - 1])
        break
      end
      try(start_position + 1, non_zero_length, length, sum, mult)
    end
    @a[start_position] = backup_start
    mult = backup_mult
    sum = backup_sum
  end

  def solve(length)
    @current_min = 2 * length
    non_zero_length = 2
    while non_zero_length < Math.log2(length) + 1
      @a = Array.new(non_zero_length)
      @a.fill(2)
      sum = @a.inject(0) { |s, e| s + e } + (length - non_zero_length)
      mult = @a.inject(1) { |s, e| s * e }
      try(0, non_zero_length, length, sum, mult)
      non_zero_length += 1
    end
    @current_min
  end

  def main
    all_results = Set.new
    (2..MAX_LENGTH).each do |length|
      local_result = solve(length)
      puts "#{length}: #{local_result}"
      all_results << local_result
    end
    puts "Answer: #{all_results.inject(0) { |s, e| s + e }}"
  end
end

P088.new.main
