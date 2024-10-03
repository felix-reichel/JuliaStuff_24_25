
# https://jump.dev/JuMP.jl/stable/tutorials/getting_started/getting_started_with_JuMP/

import Pkg;

Pkg.add("JuMP");
using JuMP;

Pkg.add("HiGHS")
using HiGHS




model = Model(HiGHS.Optimizer)

@variable(model, x >= 0, Int) # Non-negativity constraint

@variable(model, 0 <= y <= 3) # value range constr.

@objective(model, Min, 12x + 20y)

@constraint(model, c1, 6x + 8y >= 100)

@constraint(model, c2, 7x + 12y >= 120)

print(model)

optimize!(model)

termination_status(model)

primal_status(model)

#dual_status(model)

objective_value(model)

value(x)
value(y)

#shadow_price(c1)
#shadow_price(c2)

#Pkg.add("CPLEX"); m2 chip problemzssss...