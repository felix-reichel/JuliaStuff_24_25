# https://docs.julialang.org/en/v1/stdlib/LinearAlgebra/

import Pkg;

Pkg.add("LinearAlgebra");

using LinearAlgebra;

A = [5. 7.; -2. -4.];

F = schur(A);

F.vectors * F.Schur * F.vectors';

t, z, vals = F; 

t == F.T && z == F.Z && vals == F.values
