#!/usr/bin/env ruby

class P493
  BALLS = 70
  COLORS = 7
  PICKS = 20

  def main
    result = 0
    (2..COLORS).each do |x|
      p = exactly_these(x) * c(COLORS, x)
      result += x * p
    end
    puts result.round(9)
  end

  private

  # Exactly these x colors out of 7
  def exactly_these(x)
    these_or_their_subset = (0...PICKS).inject(1) { |p, i| p * (10 * x - i).to_f / (BALLS - i) }
    (2...x).inject(these_or_their_subset) { |r, i| r - exactly_these(i) * c(x, i) }
  end

  def c(n, k)
    if k < 0 || n < 0 || n < k
      return 0
    end
    if k > n - k
      return c(n, n - k)
    end
    result = 1
    (0...k).each do |i|
      result = result * (n - i) / (i + 1)
    end
    result
  end
end

P493.new.main
