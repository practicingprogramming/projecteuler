def sieve_primes(max_value):
    is_prime = [True] * (max_value + 1)
    is_prime[0] = False
    is_prime[1] = False
    primes = []
    for i in range(2, max_value):
        if not is_prime[i]: continue
        primes.append(i)
        cur = 2 * i
        while cur <= max_value:
            is_prime[cur] = False
            cur += i
    return primes
