def square?(x)
  int_root = Math.sqrt(x).to_i
  int_root * int_root == x
end

def prime?(x)
  (2..Math.sqrt(x).round).all? { |i| x % i != 0 }
end

def sum_of_digits(x)
  res = 0
  while x > 0
    res += x % 10
    x /= 10
  end
  res
end
