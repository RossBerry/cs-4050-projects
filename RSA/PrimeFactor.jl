function prime_factor(n::BigInt)
    println("finding prime factors of: ", n)
    primes = []
    p = BigInt(2)
    while n >= p^2
        if mod(n, p) == 0
            append!(primes, p)
            println(p)
            n = div(n, p)
        else
            p += 1
        end
    end
    return primes
end

function get_factors(n, primes)
    factors = []
    one = BigInt(1)
    for p in primes
        for q in primes
            if (p - one) * (q - one) == n
                append!(factors, [p, q])
                println("[",p,", ",q,"]")
            end
        end
    end
    return factors
end

p = BigInt(4008793)
q = BigInt(4011409)
n = p * q
c = BigInt(1027795314451781443748475386257882516)
primes = prime_factor(c)
factors = get_factors(c, primes)