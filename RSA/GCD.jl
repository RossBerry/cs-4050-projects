function myGCD(a::Int, b::Int)
    table = zeros(Int, 100, 6)
    table[1, 1] = a
    table[1, 2] = b
    row = 1
    while table[row, 2] > 0
        table[row, 3] = table[row, 1] % table[row, 2]
        table[row, 4] = divrem(table[row, 1], table[row, 2])[1]
        table[row+1, 1] = table[row, 2]
        table[row+1, 2] = table[row, 3]
        row += 1
    end
    if row % 2 == 0
        table[row, 5] = 1
        table[row, 6] = 0
    else
        table[row, 5] = 1
        table[row, 6] = 1
    end
    for r in row-1:-1:1
        table[r, 5] = table[r+1, 6]
        table[r, 6] = table[r+1, 5] - (table[r+1, 6] * table[r, 4])
    end
    return table[1, 6]
end

print(myGCD(439, 211))