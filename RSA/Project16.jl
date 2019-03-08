###############################################################################
# CS 4050 Project 16                                                          #
#                                                                             #
###############################################################################

println("CS 4050 Project 16:", "\n")

# Given values:
a = BigInt(12345)           # Original Message
e = BigInt(53)              # Public exponent
p = BigInt(137)             # Private random prime
q = BigInt(241)             # Private random prime

n = BigInt(p * q)           # Public key
c = ModExp(a, e, n)         # Public encrypted message
println("c = ", c)

ɸ = (p - 1) * (q - 1)
println("ɸ = ", ɸ)
d = gcdx(ɸ, e)[3]
println("d = ", d)
decrypt_c = ModExp(c, d, n)
println("decrypted c = ", decrypt_c)