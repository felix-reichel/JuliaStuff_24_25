# 4.2.1. ILP

using JuMP
using HiGHS



profit = [15, 12, 16, 18, 9, 11]       # Profits
capital = [38, 33, 39, 45, 23, 27]     # Capital requirements
total_capital = 100                    # Total capital

model = Model(HiGHS.Optimizer)
@variable(model, x[1:6], Bin)

@objective(model, Max, sum(profit[i] * x[i] for i in 1:6))

@constraint(model, sum(capital[i] * x[i] for i in 1:6) <= total_capital)

@constraint(model, x[1] + x[2] <= 1)
@constraint(model, x[3] + x[4] <= 1)

@constraint(model, x[3] <= x[1] + x[2])
@constraint(model, x[4] <= x[1] + x[2])

optimize!(model)


for i in 1:6
    println("Investment decision var.: ", i, ": ", value(x[i]))
end
println("OF value: ", objective_value(model))

