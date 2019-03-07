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


function ɸ_max(n::BigFloat)
    return (4 * (div((n+1-2*(sqrt(n))), BigInt(4))))
end

function ɸ_min(n::BigFloat)
    return (3 * (div((n+1-2*(sqrt(n))), BigInt(4))))
end


###############################################
# Finds small solutions to P(x0) = 0 (mod N), #
# as given by the Coppersmith condition       # 
###############################################
function CoppersmithSolve(P, N, ep = 0.03)
    
    # modularize polynomial
    P(x) = P(x)%N;
    d = degree(P);
    
    # set parameters
    m = ceil(1/d/ep)
    mu = ceil(0.5*N^(1/d-ep))
    
    # construct q{i,j}(x)
    q = Array(Function, d, m);
    for i = 1:d
        for j = 1:m
            v(x) = x^i*N^j*f(x)^(m-j)
            q[i, j] = v
        end
    end
            
    # construct lattice of coefficient vectors
    Lambda = Array(Int, d*m, d*m)
    k = 1
    for i = -m+1:1
        for j = 0:delta
            c = zeros(d*m)
            v(x) = q[j, -i](mu*x);
            c[1:length(coeffs(v))] = coeffs(v)
            Lambda[:, k] = flipud(c);
            k = k + 1
        end
    end
    
    # LLL basis reduction
    b_short = LLL_reduce(Lambda)[:, 1];
    
    # construct Q(x) from elements of shortened vector
    Q(x) = 0
    Q_coeffs = flipud(b_short);
    for i = 1:size
        Q(x) = Q + round(Q_coeffs[i]/mu^(i-1))*x^(i-1)
    end

    x0 = roots(Q)
    return x0
end


function DecrpytRSA(guess, C, N, r, ep)
    # construct modular polynomial
    # C is the ciphertext
    # N is the public modulus
    # r is the public exponent
    # ep is passed into Coppersmith solver
    P(x) = ((guess + x)^r - C) % N
    
    result = CoppersmithSolve(P, N, ep) + guess
    println("decrypted text: ", result)
    return result
end

# A decrypted message is m = c^d [mod n]
function decrypt{T <: Integer}(c::T, d::T, n::T)
    return modulo_power(c, d, n)
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
c = BigFloat(1027795314451781443748475386257882516)
r = BigInt(2287529)
n = BigInt( 1029059010426758802790503300595323911)
# decrypt_c = ModExp(c, e, n)

# println(decrypt_c)

# # test for get_primes_to_sqrt:
# println(sqrt)
# println(get_primes_to_sqrt(c))

# test for get_factors:
#println(get_factors(c))


# # test for ɸ:
# ɸ_lower_bound = ɸ_min(c)
# ɸ_upper_bound = ɸ_max(c)

# primes = primes_to_n(ɸ_lower_bound, ɸ_upper_bound)

# println(ɸ_lower_bound)
# println(ɸ_upper_bound)
# println(primes)

println(decrypted_ciphertext = decrypt(c, d, n))