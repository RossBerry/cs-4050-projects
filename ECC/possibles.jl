macro find_str

function possible(Z::BigInt)
    possible_m = []
    for n in 1:Z
        if n % 2 == 0
            for m in 10:99
                o = m + n
                if find(possible_m .== o)
                    append!(possible_m, o)
                end
            end
        end
    end
    return possible_m
end

foreach(println, possible(BigInt(10)))
