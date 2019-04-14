import BenchmarkTools.@btime

function components(n)
    comps = []
    if n == 1
        comps = [1]
    elseif n % 2 == 0
        next = n ÷ 2
        append!(comps, [next, next])
    else
        next = (n ÷ 2) + 1
        next_comp = components(next)
        append!(comps, [next, next_comp[1]])
    end
    return comps
end

function opSums(n)
    sums = []
    if n % 2 != 0
        append!(sums, [[n-1, 1]])
        n-=1
    end
    while n > 1
        if n % 2 == 0
            next = n ÷ 2
            append!(sums, [[next, next]])
        else
            next = (n ÷ 2) + 1
            next_comp = components(next)
            append!(sums, [[next, next_comp[1]]])
        end
        n = next
    end
    return sums
end

# Test
foreach(println, opSums(19))