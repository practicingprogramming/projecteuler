#!/usr/bin/env ruby

require './common.rb'

class P094
  MAX_PERIMETER = 1000000000

  def initialize
  end

  def main
    result = 0
    x = 3
    while x <= MAX_PERIMETER / 3
      s = (3 * x + 1) * (x + 1) * (x + 1) * (x - 1)
      if s % 16 == 0 && square?(s / 16)
        puts "#{x} #{x} #{x + 1}"
        result += 3 * x + 1
      end
      s = (3 * x - 1) * (x - 1) * (x - 1) * (x + 1)
      if s % 16 == 0 && square?(s / 16)
        puts "#{x} #{x} #{x - 1}"
        result += 3 * x - 1
      end
      x += 2
    end
    puts "Answer: #{result}"
  end
end

P094.new.main
