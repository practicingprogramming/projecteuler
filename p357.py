from bisect import bisect
from sieve import sieve_primes

def is_prime(n):
    return n in prime_set

def check(n):
    fits = True
    for d in primes:
        if d > n: break
        other = d + n // d
        if n % d == 0 and not is_prime(other):
            fits = False
            break

    return fits

max_value = 100000000
primes = sieve_primes(max_value)
prime_set = set(primes)

sum = 0
fits = [True] * (max_value + 1)
for i in range(1, max_value):
    j = i
    while j <= max_value:
        d = j // i
        fits[j] = fits[j] and is_prime(d + i)
        j += i
    if fits[i]:
        sum += i

print(sum)
