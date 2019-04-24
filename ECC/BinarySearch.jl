function binarySearch(arr, l, r, x)
    if r >= l
        mid = l + (r - l) ÷ 2
        if arr[mid] == x
            return true
        elseif arr[mid] > x
            return binarySearch(arr, l, mid-1, x)
        else
            return binarySearch(arr, mid + 1, r, x)
        end
    else
        return false
    end
end

A = [1, 2, 4, 5, 6, 7, 8, 9]

@show binarySearch(A, 0, length(A), 2)
@show binarySearch(A, 0, length(A), 3)
