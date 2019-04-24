#=
Project20.jl
Kenneth Berry

Project 20: Breaking ECC by Social Hacking

Values for exchanging encrypted information:
p = 115 792 089 237 316 195 423 570 985 008 687 907 853
    269 984 665 640 564 039 457 584 007 908 834 671 663
a = 0
b = 7
P = (55 066 263 022 277 343 669 578 718 895 168 534 326
     250 603 453 777 594 175 500 187 360 389 116 729 240,

     32 670 510 020 758 816 978 083 085 130 507 043 184
     471 273 380 659 243 275 938 904 335 757 337 482 424)

It is overheard that m was calculated by taking a power of 2
plus a two-digit number, and mP is intercepted.

mP = (98 333 898 174 860 222 763 621 164 809 560 426 900
      902 581 988 820 015 661 720 799 616 398 614 033 468,

      60 703 462 459 530 085 880 474 331 476 429 053 299
      167 650 471 903 125 187 953 999 331 805 378 093 068)

This program determines the value of m by brute-forcing through
all of the possible values of m, calculating mP, and returning
the value for m that matches the intercepted target mP.

The program saves each mP that is calcualted to a dictionary with
m as the key to avoid calculating the same mP more than once.
=#


function tangentλ(Xp::BigInt, Yp::BigInt, a::BigInt, mod::BigInt)
    return fracMod((3(Xp^2) + a),(2Yp), mod)
end

function secantλ(Xp::BigInt, Yp::BigInt, Xq::BigInt, Yq::BigInt, mod::BigInt)
    return fracMod((Yp-Yq), (Xp-Xq), mod)
end


function fracMod(numerator::BigInt, denominator::BigInt, mod::BigInt)
    if numerator < 0
        numerator = mod + numerator
    end
    if denominator < 0
        denominator = mod + denominator
    end
    return (numerator * invmod(denominator, mod)) % mod
end


function componentSums(n::BigInt)
    components_sums = Array{Array{BigInt}, 1}()
    one = BigInt(1)
    if n % 2 != 0
        n -= 1
        push!(components_sums, [n, 1])
    end
    while n > 1
        if n % 2 == 0
            n = n ÷ 2
            push!(components_sums, [n, n])
        else
            n -= 1
            push!(components_sums, [n, one])
        end
    end
    return reverse(components_sums)
end


function addPoints(P::Array{BigInt}, Q::Array{BigInt}, a::BigInt, mod::BigInt)
    Xp, Yp = P
    Xq, Yq = Q
    λ = (P == Q) ? tangentλ(Xp, Yp, a, mod) : secantλ(Xp, Yp, Xq, Yq, mod)
    Xr = (λ^2 - Xp - Xq) % mod
    Yr = -((Yp + λ * (Xr - Xp)) % mod)
    R = [Xr, Yr]
    if Xr < 0
        Xr = mod + Xr
    end
    if Yr < 0
        Yr = mod + Yr
    end
    return [Xr, Yr]
end


function findM(target_mP::Array{BigInt}, a::BigInt, mod::BigInt, mP_dict)
    exp = BigInt(0)
    curr_mP = mP_dict[1]
    while true
        power_of_two = BigInt(2^exp)
        for i in 10:99
            curr_m = BigInt(power_of_two + i)
            comp_m = componentSums(curr_m)
            for j in 1:length(comp_m)
                curr_comp = comp_m[j]
                comp_sum = BigInt(sum(curr_comp))
                if haskey(mP_dict, comp_sum)
                    curr_mP = mP_dict[comp_sum]
                else
                    P = mP_dict[curr_comp[1]]
                    Q = mP_dict[curr_comp[2]]
                    curr_mP = addPoints(P, Q, a, mod)
                    mP_dict[comp_sum] = curr_mP
                end
                if curr_mP == target_mP
                    return (exp, i, curr_m)
                end
            end
        end
        exp += 1
    end
end


################### Given variables ###################

P_ = zeros(BigInt, 2)
P_[1] = BigInt(55066263022277343669578718895168534326250603453777594175500187360389116729240)
P_[2] = BigInt(32670510020758816978083085130507043184471273380659243275938904335757337482424)
mP_ = zeros(BigInt, 2)
mP_[1] = BigInt(98333898174860222763621164809560426900902581988820015661720799616398614033468)
mP_[2] = BigInt(60703462459530085880474331476429053299167650471903125187953999331805378093068)
p_ = BigInt(115792089237316195423570985008687907853269984665640564039457584007908834671663)
a_ = BigInt(0)
b_ = BigInt(7)
mP_dict_ = Dict{BigInt, Array{BigInt}}()
mP_dict_[BigInt(1)] = P_

#######################################################


println("Finding m ...")
result_ = BigInt()

@time begin
    global result_ = findM(mP_, a_, p_, mP_dict_)
end

exp_, two_digit_, m_ = result_
@show m_
println("m = 2^$exp_ + $two_digit_")
