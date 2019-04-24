function Sums(n)
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
            push!(sums, [n, 1])
        end
    end
    return sums
end

foreach(println, reverse(Sums(100)))