#!/usr/bin/env ruby

MOD = 1000000
MAX_N = 1000000

# https://en.wikipedia.org/wiki/Partition_%28number_theory%29#Generating_function
def main
  a = []
  a[0] = 1
  a[1] = 1
  n = 1
  while n < MAX_N
    n += 1
    k = 0
    a[n] = 0
    while true
      if k > 0
        k = -k
      else
        k = -k + 1
      end
      pentagon = get_pentagon(k)
      break if pentagon > n
      sign = k % 2 != 0 ? 1 : -1
      a[n] += sign * a[n - pentagon]
      a[n] %= MOD
    end
    if a[n] % MOD == 0
      puts n
      return
    end
  end
end

def get_pentagon(x)
  (3 * x * x - x) / 2
end

main
