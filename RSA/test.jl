module MyModule
    using PyCall

    function __init__()
        py"""
        def decode(n):
            return chr(n)
        """
    end
    dec(n) = py"decode"(n)
end

println(MyModule.dec(88))
