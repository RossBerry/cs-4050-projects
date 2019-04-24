function tangentλ(Xp::BigInt, Yp::BigInt, a::BigInt, mod::BigInt)
    return fracMod((3*(Xp^2) + a),(2*Yp), mod)
end

function secantλ(Xp::BigInt, Yp::BigInt, Xq::BigInt, Yq::BigInt, mod::BigInt)
    return fracMod((Yp-Yq), (Xp-Xq), mod)
end

function fracMod(num::BigInt, den::BigInt, m::BigInt)
    if num < 0 
        num = m + num
    end
    if den < 0
        den = m + den
    end
    return (num*invmod(den, m)) % m
end

function addPoints(P::Array{BigInt}, Q::Array{BigInt}, a::BigInt, b::BigInt, mod::BigInt)
    Xp, Yp = P
    Xq, Yq = Q
    λ = (P == Q) ? tangentλ(Xp, Yp, a, mod) : secantλ(Xp, Yp, Xq, Yq, mod)
    Xr = (λ^2 - Xp - Xq) % mod
    Yr = -((Yp + λ*(Xr - Xp)) % mod)
    R = [Xr, Yr]
    if Xr < 0
        Xr = mod + Xr
    end
    if Yr < 0
        Yr = mod + Yr
    end
    S = [Xr, Yr]
    return S
end

function componentSums(n::BigInt)
    sums = []
    if n % 2 != 0
        n -= 1
        push!(sums, [n, 1])
    end
    while n > 1
        if n % 2 == 0
            n = n ÷ 2
            push!(sums, [n, n])
        else
            n -= 1
            push!(sums, [n, BigInt(1)])
        end
    end
    return reverse(sums)
end

function findM(mP::Array{BigInt, 1}, a::BigInt, b::BigInt, mod::BigInt, dict)
    pow = BigInt(0)
    curr_mP = dict[1]
    while true
        base = BigInt(2^pow)
        for i in 10:99
            curr_m = BigInt(base + i)
            comp_to_m = componentSums(curr_m)
            for j in 1:length(comp_to_m)
                curr_comp = comp_to_m[j]
                comp_sum = BigInt(sum(curr_comp))
                if haskey(dict, comp_sum)
                    curr_mP = dict[comp_sum]
                else
                    P = dict[curr_comp[1]]
                    Q = dict[curr_comp[2]]
                    curr_mP = addPoints(P, Q, a, b, mod)
                    dict[comp_sum] = curr_mP
                end
                if curr_mP == mP
                    return curr_m
                end
            end
        end
        pow += 1
    end
end


################### Given variables ###################
Px = BigInt(55066263022277343669578718895168534326250603453777594175500187360389116729240)
Py = BigInt(32670510020758816978083085130507043184471273380659243275938904335757337482424)
mPx = BigInt(98333898174860222763621164809560426900902581988820015661720799616398614033468)
mPy = BigInt(60703462459530085880474331476429053299167650471903125187953999331805378093068)
p = BigInt(115792089237316195423570985008687907853269984665640564039457584007908834671663)
target_mP = [mPx, mPy]
point_P = [Px, Py]
var_a = BigInt(0)
var_b = BigInt(7)
mP_dict = Dict{BigInt, Array{BigInt}}()
mP_dict[BigInt(1)] = point_P

#######################################################
println("Finding m ...")
@time begin
    result = findM(target_mP, var_a, var_b, p, mP_dict)
end

println("m = $result")
