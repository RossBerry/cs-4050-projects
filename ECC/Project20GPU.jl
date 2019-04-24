using CUDAdrv, CUDAnative, CuArrays

function fracMod(num::BigInt, den::BigInt, m::BigInt)
    if num < 0 
        num = m + num
    end
    if den < 0
        den = m + den
    end
    return (num*invmod(den, m)) % m
end

tangent_λ(Xp::BigInt, Yp::BigInt, a::BigInt, mod::BigInt) = fracMod((3*(Xp^2) + a),(2*Yp), mod)
secant_λ(Xp::BigInt, Yp::BigInt, Xq::BigInt, Yq::BigInt, mod::BigInt) = fracMod((Yp-Yq), (Xp-Xq), mod)

function addPoints(P::Array{BigInt}, Q::Array{BigInt}, a::BigInt, b::BigInt, mod::BigInt)
    Xp, Yp = P
    Xq, Yq = Q
    if P == Q
        λ = tangent_λ(Xp, Yp, a, mod)
    else
        λ = secant_λ(Xp, Yp, Xq, Yq, mod)
    end
    Xr = (λ^2 - Xp - Xq) % mod
    Yr = (Yp + λ*(Xr - Xp)) % mod
    R = [Xr, Yr]
    if Xr < 0
        Xr = mod + Xr
    end
    Yr = -Yr
    if Yr < 0
        Yr = mod + Yr
    end
    S = [Xr, Yr]
    return S
end

function calc_mP(m, pointP, a, b, mod)
    pointQ = pointP
    for n in 2:m
        pointQ = addPoints(pointP, pointQ, a, b, mod)
    end
    return pointQ
end

function findM(P::Array{BigInt}, mP::Array{BigInt}, a::BigInt, b::BigInt, mod::BigInt)
    count = 1
    print_counter = 10
    Q = P
    while  Q != mP
        if count == print_counter
            println(count)
            print_counter*=10
        end
        Q = addPoints(P, Q, a, b, mod)
        count+=1
    end
    return count
end

start_P = [BigInt(55066263022277343669578718895168534326250603453777594175500187360389116729240),
           BigInt(32670510020758816978083085130507043184471273380659243275938904335757337482424)]
var_a = BigInt(0)
var_b = BigInt(7)
p = BigInt(115792089237316195423570985008687907853269984665640564039457584007908834671663)
target_mP = [BigInt(98333898174860222763621164809560426900902581988820015661720799616398614033468),
      BigInt(60703462459530085880474331476429053299167650471903125187953999331805378093068)]
println("Finding m ...")
@time begin
    found_m = findM(start_P, target_mP, var_a, var_b, p)
    @show found_m
end
# println(findM(start_P, target_mP, var_a, var_b, p))

# #  Tests:
# test_1P = [2, 7]
# test_2P = [14, 15]
# test_19P = [9, 6]
# test_a = 2
# test_b = 3
# test_mod = 17
# println("1P = $test_1P")
# println("2P = $test_2P")
# println("1P = 2P : ", Bool(test_1P == test_2P))
# println("test: 1P + 1P = 2P = ", addPoints(test_1P, test_1P, test_a, test_b, test_mod))
# println("test: 2P + 1P = 3P = ", addPoints(test_1P, test_2P, test_a, test_b, test_mod))
# println("test 19P = ", calc_mP(19, test_1P, test_a, test_b, test_mod))
# println(findM(test_1P, test_19P, test_a, test_b, test_mod))