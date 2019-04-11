function sumCell(A, j, k)
    if j == 1 && k == 1
        return A[j, k]
    elseif j == 1 && k > 1
        return sum(A[j, k], sumCell(A, j, k-1))
    elseif k == 1 && j > 1
        return sum(A[j, k], sumCell(A, j-1, k))
    else
        return ((sumCell(A, j-1, k) + sumCell(A, j, k-1)) - sumCell(A, j-1, k-1)) + A[j, k]
    end
end

A = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24]

A = reshape(A, 4, 6)

println(sumCell(A, 2, 2))
