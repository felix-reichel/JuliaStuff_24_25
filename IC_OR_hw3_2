# Exercise 3.2 - Donaudampfschifffahrtsgesellschaft
using JuMP, HiGHS

cost = [
    500  400  600  700;  # shipping cost to AS
    600  600  700  500;  # shipping cost to KS
    700  500  700  600;  # shipping cost to JS
    500  400  600  600   # shipping cost to PS
]


model = Model(HiGHS.Optimizer)

@variable(model, x[1:4, 1:4], Bin) # bin. decision vars.

# Minimize total shipping cost
@objective(model, Min, sum(cost[i, j] * x[i, j] for i in 1:4, j in 1:4))

# shopAtOnePortMax
@constraint(model, [i=1:4], sum(x[i, j] for j in 1:4) == 1)

# OnePortOneShipAtMax
@constraint(model, [j=1:4], sum(x[i, j] for i in 1:4) == 1)

set_silent(model)
optimize!(model)

optimal_value = objective_value(model)
optimal_solution = value.(x)

println("OF (min TC):", optimal_value)
println("Opt.decision vars (x_ij):")
for i in 1:4, j in 1:4
    if optimal_solution[i, j] > 0.5
        println("Ship $i -> Port $j")
    end
end
