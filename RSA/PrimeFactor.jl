using Primes

function prime_factors(n::BigInt)
    factorization = factor(n)
    factors = [factor.first for factor in factorization]
    factors = tuple(factors[1], factors[2])
    return factors
end


p = BigInt(13)
q = BigInt(3)
n = p * q
c = BigInt(1027795314451781443748475386257882516)

prime_factors(n)
#p, q = factors


