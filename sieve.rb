def get_primes(max_value)
  is_prime = Array.new(max_value + 1).fill(true)
  is_prime[0] = false
  is_prime[1] = false
  primes = []
  (2..max_value).each do |i|
    next if !is_prime[i]
    primes << i
    cur = 2 * i
    while cur <= max_value
      is_prime[cur] = false
      cur += i
    end
  end
  primes
end
