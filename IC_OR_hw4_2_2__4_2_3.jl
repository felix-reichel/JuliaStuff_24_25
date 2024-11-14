# 4.2.2. LP (ILP relaxed)
# 4.2.3 Branch and Bound

using JuMP
using HiGHS

profit = [15, 12, 16, 18, 9, 11]       # Profits
capital = [38, 33, 39, 45, 23, 27]     # Capital requirements
total_capital = 100                    # Total capital


model = Model(HiGHS.Optimizer)
@variable(model, 0 <= x[1:6] <= 1)
@objective(model, Max, sum(profit[i] * x[i] for i in 1:6))

@constraint(model, sum(capital[i] * x[i] for i in 1:6) <= total_capital)
@constraint(model, x[1] + x[2] <= 1)
@constraint(model, x[3] + x[4] <= 1)
@constraint(model, x[3] <= x[1] + x[2])
@constraint(model, x[4] <= x[1] + x[2])

# Additional Branch-and-bound constraints (for exploration of integer solutions)
# Uncomment each line to manually explore the branch-and-bound tree
#@constraint(model, branch_bound_x1, x[1] == 1)  # Branching x[1] == 1 (feasible branch)
#@constraint(model, branch_bound_x1, x[1] == 0)  # Branching x[1] == 0
#@constraint(model, branch_bound_x6, x[6] == 1)  # Branching x[6] == 1 (feasible branch)
#@constraint(model, branch_bound_x6, x[6] == 0)  # Branching x[6] == 0
#@constraint(model, branch_bound_x3, x[3] == 1)  # Branching x[3] == 1 (no feasible solution)
#@constraint(model, branch_bound_x3, x[3] == 0)  # Branching x[3] == 0 (feasible branch)
#@constraint(model, branch_bound_x4, x[4] == 1)  # Branching x[4] == 1 (no feasible solution)
#@constraint(model, branch_bound_x4, x[4] == 0)  # Branching x[4] == 0 (feasible branch)


optimize!(model)

for i in 1:6
    println("Investment decision var.:  ", i, ": ", value(x[i]))
end
println("OF value: ", objective_value(model))


