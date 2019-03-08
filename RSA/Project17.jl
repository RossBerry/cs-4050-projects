###############################################################################
# CS 4050 Project 17                                                          #
#                                                                             #
###############################################################################

using Primes

module MyModule
    using PyCall

    function __init__()
        py"""
        def decode(n):
            return chr(n)
        """
    end
    dec(n) = py"decode"(n)
end

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

function prime_factors(n::BigInt)
    factorization = factor(n)
    factors = [factor.first for factor in factorization]
    factors = tuple(factors[1], factors[2])
    return factors
end

function gcdBigInt(f::BigInt, e::BigInt)
    one = BigInt(1)
    zero = BigInt(0)
    table = Matrix{BigInt}(undef, 100, 6)
    row = 1
    while row <= 100
        col = 1
        while col <= 6
            table[row, col] = zero
            col += 1
        end
        row += 1
    end
    table[1, 1] = f
    table[1, 2] = e
    row = 1
    while table[row, 2] > 0
        table[row, 3] = table[row, 1] % table[row, 2]
        table[row, 4] = divrem(table[row, 1], table[row, 2])[1]
        table[row+1, 1] = table[row, 2]
        table[row+1, 2] = table[row, 3]
        row += 1
    end
    if mod(row, 2) == zero
        table[row, 5] = one
        table[row, 6] = zero
    else
        table[row, 5] = one
        table[row, 6] = one
    end
    for r in row-1:-1:1
        table[r, 5] = table[r+1, 6]
        table[r, 6] = table[r+1, 5] - (table[r+1, 6] * table[r, 4])
    end
    return table[1, 6]
end

function decode_message(a::BigInt)
    s = ""
    while a > 0
        sym = Int64(a % 100)
        a = div(a, 100)
        s = string(MyModule.dec(sym+32)) * s;
    end
    return s
end

println("CS 4050 Project 17", "\n")

# Given values
c = BigInt(1027795314451781443748475386257882516)   # encrypted message
n = BigInt(1029059010426758802790503300595323911)   # public key
e = BigInt(2287529)                                 # public exponent
println("given values:", "\n","c = ", c, "\n","n = ", n, "\n","e = ", e, "\n")

# Calculate p and q:
println("\nfinding prime factors of n, this may take several minutes ... \n")
# factors = prime_factors(n)
# p, q = factors
p = BigInt(216273774599027)
q = BigInt(4758131272895389067293)
println("p = ", p, "\n", "q = ", q, "\n")
ɸ = (p - 1) * (q - 1)
println("phi = ", ɸ)
d = gcdBigInt(ɸ, e)
println("d = ", d, "\n")
coded_message = ModExp(c, d, n)
println("coded message = ", coded_message)
decoded_message = decode_message(coded_message)
println("decoded message = ", decoded_message)