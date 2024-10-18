# IC OR #2
using JuMP
using HiGHS

# Exercise 3.2
println("---")
model = Model(HiGHS.Optimizer)
set_silent(model)

@variable(model, x1 >= 0)
@variable(model, x2 >= 0)
@variable(model, x3 >= 0)
@variable(model, x4 >= 0)
@variable(model, x5 >= 0)

@objective(model, Min, 22*x1 + 20*x2 + 25*x3 + 24*x4 + 27*x5)

@constraint(model, 0.6*x1+ 0.25*x2 + 0.45*x3 + 0.2*x4 + 0.5*x5 == 0.4)
@constraint(model, 0.1*x1+ 0.15*x2 + 0.45*x3 + 0.5*x4 + 0.4*x5 == 0.35)
@constraint(model, 0.3*x1+ 0.6*x2 + 0.1*x3 + 0.3*x4 + 0.1*x5 == 0.25)


optimize!(model)

println("OPT. Vars.:")
println(value(x1))
println(value(x2))
println(value(x3))
println(value(x4))
println(value(x5))

println("OF:")
println(22*value(x1) + 20*value(x2) + 25*value(x3) + 24*value(x4) + 27*value(x5))


# Exercise 3.3
println("---")
model = Model(HiGHS.Optimizer)
set_silent(model)

@variable(model, x11 >= 0)  # Units shiped from Factory 1 to Cust 1

@variable(model, x12 >= 0)  # Units shiped from Factory 1 to Cust 2

@variable(model, x13 >= 0)  # Units shiped from Factory 1 to Cust 3

@variable(model, x21 >= 0)  # Units shiped from Factory 2 to Cust 1

@variable(model, x22 >= 0)  # Units shiped from Factory 2 to Cust 2

@variable(model, x23 >= 0)  # Units shiped from Factory 2 to Cust 3

# OF
@objective(model, Min, 600*x11+800*x12+700*x13+400*x21+900*x22+600*x23)


@constraint(model, outputF1, x11+x12+x13 <= 400) # max. output Factory 1

@constraint(model, outputF2, x21+x22+x23 <= 500) # max. output Factory 2

@constraint(model, orderC1, x11+x21 == 300) # order of customer 1 fulfilled

@constraint(model, orderC2, x12+x22 == 200) # order of customer 1 fulfilled

@constraint(model, orderC3, x13+x23 == 400) # order of customer 1 fulfilled

# solve the model
optimize!(model)


print("shipping units matrix elements amount from factory to cust.:")
println(value(x11))
println(value(x12))
println(value(x13))
println(value(x21))
println(value(x22))
println(value(x23))

print("shipping cost")

println(600*value(x11)+800*value(x12)+700*value(x13)+400*value(x21)+900*value(x22)+600*value(x23))


# Exercise 1.3
println("---")
model = Model(HiGHS.Optimizer)
set_silent(model)

# variables
@variable(model, xF1 >= 0, Int) # full-time consultants starting in shift 1
@variable(model, xF2 >= 0, Int) # full-time consultants starting in shift 2
@variable(model, xF3 >= 0, Int) # full-time consultants starting in shift 3
@variable(model, xP1 >= 0, Int) # part-time consultants starting in shift 1
@variable(model, xP2 >= 0, Int) # part-time consultants starting in shift 2
@variable(model, xP3 >= 0, Int) # part-time consultants starting in shift 3
@variable(model, xP4 >= 0, Int) # part-time consultants starting in shift 4

# objective function
@objective(model, Min, 320 * (xF1 + xF2 + xF3) + 120 * (xP1 + xP2 + xP3 + xP4)) # minimize the total cost

# constraints
@constraint(model, minReqShift1, xF1 + xP1 >= 4) # minimal requirement on the total number of consultants in shift 1
@constraint(model, minReqShift2, xF1 + xF2 + xP2 >= 8) # minimal requirement on the total number of consultants in shift 2
@constraint(model, minReqShift3, xF2 + xF3 + xP3 >= 10) # minimal requirement on the total number of consultants in shift 3
@constraint(model, minReqShift4, xF3 + xP4 >= 6) # minimal requirement on the total number of consultants in shift 4

@constraint(model, ratioFullPart1, xF1 >= 2 * xP1) # two full-time consultants for one part-time consultant in shift 1
@constraint(model, ratioFullPart2, xF1 + xF2 >= 2 * xP2) # two full-time consultants for one part-time consultant in shift 2
@constraint(model, ratioFullPart3, xF2 + xF3 >= 2 * xP3) # two full-time consultants for one part-time consultant in shift 3
@constraint(model, ratioFullPart4, xF3 >= 2 * xP4) # two full-time consultants for one part-time consultant in shift 4

# solve the model
optimize!(model)

# display the solution
println(" Number of full-time consultants starting in shift 1: ", value(xF1))
println(" Number of full-time consultants starting in shift 2: ", value(xF2))
println(" Number of full-time consultants starting in shift 3: ", value(xF3))
println(" Number of part-time consultants starting in shift 1: ", value(xP1))
println(" Number of part-time consultants starting in shift 2: ", value(xP2))
println(" Number of part-time consultants starting in shift 3: ", value(xP3))
println(" Number of part-time consultants starting in shift 4: ", value(xP4))
println(" Total cost per day: ", objective_value(model), " \$")