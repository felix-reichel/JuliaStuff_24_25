# Exercise 3.1
using JuMP
using HiGHS

ingridients_perc_matrix = [
    3   18  16  4;   # Fiber percentages
    6   46  9   9;   # Fat percentages
    20  5   4   0    # Sugar percentages
]
ingridients_item_price = [2, 4, 1, 2]
min_ingri_mix_requirements = [10, 2, 5]

model = Model(HiGHS.Optimizer)

# Decision variables
@variable(model, x[1:4] >= 0) # Non-negativity constraint

# Objective: Minimize the cost 
@objective(model, Min, ingridients_item_price' * x)  # transpose price vector multiply by decision vars vector then


@constraint(model, ingridients_perc_matrix * x .>= min_ingri_mix_requirements)  # 3 min_ingri_mix_requirements constraints
@constraint(model, sum(x) == 1)                             # Total weight constraint per dec var constraint

set_silent(model)
optimize!(model)

optimal_value = objective_value(model)
optimal_solution = value.(x)

println("OF (minimum cost): ", optimal_value)
println("Optimal values (x1, x2, x3, x4): ", optimal_solution)
