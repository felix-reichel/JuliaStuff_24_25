using JuMP
using HiGHS
# using CPLEX

model = Model(HiGHS.Optimizer)
# model = Model(CPLEX.Optimizer) IBM sucks.

@variable(model, x1 >= 0) # Non-neg. constraint
@variable(model, x2 >= 0) # Non-neg. constraint
@objective(model, Max, .88*x1 + .33*x2)
@constraint(model, flour, .1*x1 + .1*x2 <= 200)
@constraint(model, pork, .25*x1 <= 800)
@constraint(model, labour, 3*x1 + 2*x2 <= 12000)

optimize!(model)

println("====================")
println(objective_value(model))
println(value(x1))
println(value(x2))
