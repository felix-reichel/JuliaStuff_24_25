using HiGHS
"""
https://jump.dev/JuMP.jl/stable/background/algebraic_modeling_languages/
"""
function highs_knapsack(c, w, b)
    n = length(c)
    model = Highs_create()
    Highs_setBoolOptionValue(model, "output_flag", false)
    for i in 1:n
        Highs_addCol(model, c[i], 0.0, Inf, 0, C_NULL, C_NULL)
        Highs_changeColIntegrality(model, i-1, 1)
    end
    Highs_changeObjectiveSense(model, -1)
    Highs_addRow(
        model,
        -Inf,
        b,
        Cint(length(w)),
        collect(Cint(0):Cint(n-1)),
        w,
    )
    Highs_run(model)
    if Highs_getModelStatus(model) != kHighsModelStatusOptimal
        error("Not solved correctly")
    end
    x = fill(NaN, 2)
    Highs_getSolution(model, x, C_NULL, C_NULL, C_NULL)
    Highs_destroy(model)
    return x
end


highs_knapsack([1.0, 2.0], [0.5, 0.5], 1.25)