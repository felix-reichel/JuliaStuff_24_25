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




### Exercise 1.2
using Random
Random.seed!(1)

# ------------------------------
# returns the maximum value of 
# a vector and its index
# ------------------------------

function getMaximum(v)

    max = 0
    idx = -1
    for i in eachindex(v)
        if v[i] >= max
            max = v[i]
            idx = i
        end
    end

    return max, idx

end

# ------------------------------------------
# prints the maximum and second maximum
# elements of a vector and their respective
# indices
# ------------------------------------------

function firstAndSecond(v)

    # search for the maximum

    max, idx = getMaximum(v)
    println("First max: ", max)
    println("index: ", idx)

    # set the maximum to a small value
    # note: that way, the second maximum becomes the maximum

    v[idx] = -1

    # search for the maximum again

    max, idx = getMaximum(v)
    println("Second max: ", max)
    println("index: ", idx)

end

# ---------------------
# main script
# ---------------------

# make a random vector
n = 5
v = rand(1:100, n)

# call the functions
firstAndSecond(v)




# Exercise 1.3, 1.4, 1.5
using Random
Random.seed!(1)

# ===========================================
#               METHOD 1
# ===========================================

# ------------------------------
# returns the maximum value of 
# a vector and its index
# ------------------------------

function getMaximum(v::Vector{Int})

    max = 0
    idx = -1
    for i in eachindex(v)
        if v[i] >= max
            max = v[i]
            idx = i
        end
    end

    return max, idx

end

# ------------------------------------------
# print all values and their respective
# indices, from the largest to the smallest
# value
# ------------------------------------------

function allMax(v::Vector{Int})

    n = length(v)

    for i in 1:n

        # search for the maximum

        max, idx = getMaximum(v)
        #println("New max: ", max)
        #println("index: ", idx)

        # set the maximum to a small value

        v[idx] = -1
    end

end


# ===========================================
#               METHOD 2
# ===========================================

# ------------------------------------------
# print all values and their respective
# indices, from the largest to the smallest
# value
# ------------------------------------------

function allMax2(v::Vector{Int})

    sortedIndices = sortperm(v, rev=true)
    for i in sortedIndices
        #println("New max: ", v[i])
        #println("index: ", i)
    end

end


# ===========================================
#               MAIN PART
# ===========================================

# make a random vector
n = 100000
v = rand(1:100, n)
#println(v)

# call the functions
@time allMax(v)
@time allMax2(v)


