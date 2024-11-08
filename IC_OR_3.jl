using JuMP
using HiGHS

n=5 # number of alloys
m=3 # number of elements having reqs.

c=[22,20,25,24,27]#cost per lb per alloy array
p = [0.6 0.25 0.45 0.2 0.5;
    0.1 0.15 0.45 0.5 0.4
    0.3 0.6 0.1 0.3 0.1]#matrix proportion of element i in alloy j

t =[0.4, 0.35, 0.25]

model = Model(HiGHS.Optimizer)
set_silent(model)

@variable(model, x[j=1:n] >= 0)

@objective(model,Min,sum(c[j] * x[j] for j in 1:n))

@constraint(model, element[i=1:m], sum(p[i,j] * x[j] for j in 1:n) == t[i])

optimize!(model)

println( "Quantities of each alloy: ", value.(x))
println( " Total cost: ", objective_value(model))


# ex4_2 - SOLUTION
using JuMP
using HiGHS

# data of the problem
m = 2 # number of factories
n = 3 # number of customers
c = [
    600  800  700;
    400  900  600] # cost of shipping one unit from factory i to customer j
p = [400  500] # maximum production of factory i
o = [300, 200, 400] # demand of customer j

# create a model
model = Model(HiGHS.Optimizer)
set_silent(model)

# variables
@variable(model, x[i=1:m, j=1:n] >= 0) # quantities shipped from factory i to customer j

# objective function
@objective(model, Min, sum(c[i,j] * x[i,j] for i in 1: m for j in 1:n)) # minimize the total cost

# constraints
@constraint(model, production[i=1:m], sum(x[i,j] for j in 1:n) <= p[i]) # produciton constraints
@constraint(model, order[j=1:n], sum(x[i,j] for i in 1:m) == o[j]) # order constraints

# solve the model
optimize!(model)

# display the solution
println(" Quantities of shipped: ", value.(x))
println(" Total cost: ", objective_value(model))


# ex4_3
n = 3
m = 3

