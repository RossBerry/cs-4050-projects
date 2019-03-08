# CS 4050 Project 17

using Primes

function ModExp(a, e, n)
    squares = a
    exp = e
    one = BigInt(1)
    two = BigInt(2)
    prod = one
    while exp >= one
        if exp % two == one
            prod = (prod * squares) % n
        end
        squares = (squares * squares) % n
        exp = div(exp, two)
    end
    return prod
end

# function decode(encoded)
#     code_split = encoded.split("0")
#     return code_split
# end

# function sieve(n::BigInt)
#     primes = [true for n in 1:n]

#     k = BigInt(2)
#     while k >= n + BigInt(1)
        


# end


function primes_to_n(low::BigFloat, hi::BigFloat)
    primes = [BigInt(2)]
    one = BigInt(1)

    for n in low:hi
        #n = divrem(n, one)
        if Primes.isprime(n)
            append!(primes, BigInt(n))
            println(BigInt(n))
        end
    end
    return primes
end

# function get_factors(n::BigInt)
#     factors = []
#     one = BigInt(1)
#     primes = get_primes_to_sqrt(n)
#     for p in primes
#         for q in primes
#             if (p - one) * (q - one) == n
#                 append!(factors, [p, q])
#             end
#         end
#     end
#     return factors
# end


function ɸ_max(n::BigInt)
    return BigInt(divrem((4 * (div((n+1-2*(sqrt(n))), BigInt(4)))), 1)[1])
end

function ɸ_min(n::BigInt)
    return BigInt(divrem((3 * (div((n+1-2*(sqrt(n))), BigInt(4)))), 1)[1])
end

function prime_factors(lo::BigInt, hi::BigInt, n::BigInt)
    factors = []
    current = lo
    while current < hi
        if isprime(current) && n % current == 0
            append!(factors, current)
        end
        current += BigInt(1)
    end
    return factors
end

# Project 16
# println("Project 16:")
# a = BigInt(12345)
# e = BigInt(53)
# p = BigInt(137)
# q = BigInt(241)
# n = BigInt(p * q)
# c = ModExp(a, e, n)
# println("c = ", c)
# ɸ = (p - 1) * (q - 1)
# println("ɸ = ", ɸ)
# d = gcdx(ɸ, e)[3]
# println("d = ", d)
# decrypt_c = ModExp(c, d, n)
# println("decrypted c = ", decrypt_c)

# Project 17
c = BigInt(1027795314451781443748475386257882516)
println("c = ", c)
e = BigInt(2287529)
println("e = ", e)
n = BigInt(1029059010426758802790503300595323911)
println("n = ", n)
p = BigInt(216273774599027)
q = BigInt(4758131272895389067293)
est_n = p * q
println("est_n = ", est_n)
ɸ = (p - 1) * (q - 1)
println("phi = ", ɸ)
# d = gcdx(ɸ, e)[3]
d = BigInt(941852144648755861760623254442258121)
println("d = ", d)
decrypted_code = ModExp(c, d, n)
println("decrypted code = ", decrypted_code)
# println("\nfinding prime factors of n...")
# factors = prime_factors(lower_bound, upper_bound, test_n)

# for factor in factors
#     println(factor)
# end
