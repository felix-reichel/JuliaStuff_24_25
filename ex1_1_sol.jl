### Exercise 1.1
using Random
Random.seed!(1)

# --------------------------
# get maximum with method 1

function method1(v)

    println("via method 1:")
    println(maximum(v))
    println(argmax(v))

end

# --------------------------
# get maximum with method 2

function method2(v)

    max = 0
    idx = -1
    for i in eachindex(v)
        if v[i] >= max
            max = v[i]
            idx = i
        end
    end

    println("via method 2:")
    println(max)
    println(idx)

end

# ---------------------
# main script

# make a random vector
n = 5
v = rand(1:100, n)
println(v)

# call the functions
method1(v)
method2(v)