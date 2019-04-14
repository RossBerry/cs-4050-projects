function find(x, y)
    found = false
    for i in x
        if i == y
            found = true
            break
        end
    end
    return found
end

function possible(Z::BigInt)
    possible_m = []
    for n in 1:Z
        if n % 2 == 0
            for m in 10:99
                o = m + n
                if !find(possible_m, o)
                    append!(possible_m, o)
                end
            end
        end
    end
    return possible_m
end

possibles = possible(BigInt(115792089237316195423570985008687907853269984665640564039457584007908834671663))

@show length(possibles)
