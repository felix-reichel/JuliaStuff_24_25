import Pkg;

Pkg.add("RCall")


using RCall # .@R_str

R"optim(0, $(x -> x+sin(x)), method='BFGS')"

# RObject{VecSxp}
# $par
# [1] -3.133789

# $value
# [1] -3.141593

# $counts
# function gradient 
#       14       13 

# $convergence
# [1] 0

# $message
# NULL