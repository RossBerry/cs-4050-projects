import Base.Slice

function floydAlgorithm(d)
    n = d
end

function readTable(filename)
    data = open(filename) do file
        read(file, String)
    end
    join(filter(x -> (x != '\r' || x != 'n'), data))
    data = parse.(Int64, split(data))
    size = data[1]
    data = Slice(data, 2, 2)
    println(data)
    i = 1
    table = Array{Int64}(undef, size, size, 2)
    for r in 1:size
        for c in 1:size
            table[r, c, 1] = data[i]
            i += 1
        end
    end
    return table
end

t = readTable("test")
print(t)