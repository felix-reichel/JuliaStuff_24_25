using JuMP
using HiGHS
using LinearAlgebra
using Random




# DGP
function generateDistanceMatrix(n::Int64)
    coord = [rand(0:100, 2) for i in 1:n]
    X = [coord[i][1] for i in 1:n]
    Y = [coord[i][2] for i in 1:n]
    return [norm(coord[i] - coord[j]) for i in 1:n, j in 1:n]
end

function solve_tsp(n::Int64)


    Random.seed!(1234)     # for deterministic DGP initialization
    d = generateDistanceMatrix(n)  # init DGP
    model = Model(HiGHS.Optimizer) # init model

    @variable(model, x[1:n, 1:n], Bin)    # Binary var for traveling from i to j
    @variable(model, u[1:n] >= 0)         # Continuous vars for the subtour elimination

    # min total dist
    @objective(model, Min, sum(d[i, j] * x[i, j] for i in 1:n, j in 1:n))


    # Each location is left EXACTLY once
    @constraint(model, [j in 1:n], sum(x[i, j] for i in 1:n if i != j) == 1)
   
    # Each location is entered EXACTLY once
    @constraint(model, [i in 1:n], sum(x[i, j] for j in 1:n if i != j) == 1)

    # No self-loops
    @constraint(model, [i in 1:n], x[i, i] == 0)

    # Subtour elimination (MTZ)
    @constraint(model, [i in 2:n, j in 2:n; i != j], u[j] ≥ u[i] + 1 - (n - 1) * (1 - x[i, j]))

    optimize!(model)

    print(model[:x])

    if termination_status(model) == MOI.OPTIMAL
        println("Optimal route found:")

        # Extract the optimal route
        route = []
        current_location = 1
        push!(route, current_location)

        while length(route) < n + 1
            next_location = findfirst(j -> value(x[current_location, j]) > 0.5, 1:n)
            if next_location === nothing
                println("Error: Unable to construct a complete route.")
                return
            end
            push!(route, next_location)
            current_location = next_location
        end

        println("Route: ", route)
        println("Total distance: ", objective_value(model))
    else
        println("No optimal solution found.")
    end
end

solve_tsp(10)

# Optimal route found:
# Route: Any[1, 2, 8, 5, 6, 4, 10, 9, 3, 7, 1]
# Total distance: 294.7060464767702


