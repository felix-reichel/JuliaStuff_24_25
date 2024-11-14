# 7.2 Scheduling example, ILP

using JuMP
using HiGHS

# Given example data 
i = 2
j = 5

p1 = [3, 2, 4, 5, 3]  # Example Processing times machine 1
p2 = [4, 3, 2, 3, 5]  # Example Processing times machine 2

num_jobs = length(p1)

# Create the model
model = Model(HiGHS.Optimizer)

# @variable(model, C[1:2] >= 0)  #   for the completion times for each machine, Non-negativity
@variable(model, x[1:2, 1:num_jobs], Bin)  # x_ij Decision Vars for machine:job assignment, Binary

# minimize makespan T
@variable(model, T >= 0)  # Auxiliary variable T, non-negative

# T must be greater than completion time of each machine j
@constraint(model, T >= sum(p1[j] * x[1, j] for j in 1:num_jobs)) # completion time of machine 1
@constraint(model, T >= sum(p2[j] * x[2, j] for j in 1:num_jobs)) # completion time of machine 2

# exactly one job j assigned to machine i 
for j in 1:num_jobs
    @constraint(model, sum(x[i, j] for i in 1:2) == 1) # i:j assignments 
end

@objective(model, Min, T)

optimize!(model)

if termination_status(model) == MOI.OPTIMAL
    println("An Optimal solution was found!")
    println("Minimum makespan (= total completion time): ", value(T))
    println("Found Job assignments:")
    # assigment results
    for i in 1:2
        for j in 1:num_jobs
            if value(x[i, j]) > 0.5  # Check if a job j is assigned to a machine i
                println("Job $j -> machine $i")
            end
        end
    end
else
    println("No optimal solution was found.")
end


# 7.3 (B)(I)LP

weights = [4, 7, 5, 3, 6, 2, 4]
num_items = length(weights)

max_containers = num_items # Upper bound Assumption for worst case: 1 container contains 1 item
container_capacity = 10

model = Model(HiGHS.Optimizer)

# Decision variables
@variable(model, y[1:max_containers], Bin)  # y_k Binary decsion vars for container k is used
@variable(model, x[1:num_items, 1:max_containers], Bin)  # x_jk Binary decsion vars  if item j is in container k

# Min the number of containers
@objective(model, Min, sum(y[k] for k in 1:max_containers))

# Container Capacity constraints
for k in 1:max_containers
    @constraint(model, sum(weights[j] * x[j, k] for j in 1:num_items) <= container_capacity * y[k])
end
# Item in exactly One Conatiner Constraints
for j in 1:num_items
    @constraint(model, sum(x[j, k] for k in 1:max_containers) == 1)
end

optimize!(model)

println("Minimum number of containers is: ", sum(value(y[k]) for k in 1:max_containers))
for k in 1:max_containers
    if value(y[k]) > 0.5  # = container k is used
        println("Container $k contains items: ", [j for j in 1:num_items if value(x[j, k]) > 0.5])
    end   end


#     LP iterations     79 (total)
#     0 (strong br.)
#     58 (separation)
#     0 (heuristics)
# Minimum number of containers is: 4.0
# Container 1 contains items: [1, 3]
# Container 5 contains items: [2, 6]
# Container 6 contains items: [4]
# Container 7 contains items: [5, 7]