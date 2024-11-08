# Julia's PyPlot Pkg
using Pkg
Pkg.add("PyPlot")
using PyPlot
for i=1:5
    y=cumsum(randn(500))
    plot(y)
end



# Calling C or Fortran rountines
# https://docs.julialang.org/en/v1/manual/calling-c-and-fortran-code/
function mycompare(a, b)::Cint
    return (a < b) ? -1 : ((a > b) ? +1 : 0)
end

mycompare_c = @cfunction(mycompare, Cint, (Ref{Cdouble}, Ref{Cdouble}))

A = [1.3, -2.7, 4.4, 3.1]

@ccall qsort(
    A::Ptr{Cdouble}, 
    length(A)::Csize_t, 
    sizeof(eltype(A))::Csize_t, 
    mycompare_c::Ptr{Cvoid})::Cvoid

print(A)
