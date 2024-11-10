# #########################################################
#                 0/1 Knapsack Max Profit Value
#
# The following function computes the max. profit for a 0/1-knapsack
# problem.
#
# input:
# - p_i: An array of prices for each asset A
# - e_i: An array of expected returns for each asset A
# - b:  Budgets, An array or constant.
#
# output:
# - max_profit: max. profit achievable given A, p_i and e_i within the budget b.
# #########################################################

function knapsack_max_profit(p_i, e_i, b)

    n = length(p_i)  # Number of Assets A

    # Init 2D array for storing subproblem solutions,
    # Dims are (n + 1) x (b + 1)
    P = zeros(
        Int, 
        n + 1, 
        b + 1)

    # Table Construction
    for α in 1:n        # for every asset 
        for β in 1:b    # for potentially multiple budgets. (Not needed currently)

            # If asset price > current budget 
            # Then do not include, and thus assign the prev to curr asset row value.
            if p_i[α] > β

                P[ α + 1, 
                   β + 1] =
                    P[ α, 
                       β + 1]
            else
                # If the asset price < current budget:
                # Calculate max. profit of including or excluding the current asset α.
                
                exclusion_value = P[α, β + 1]

                ret_payoff_within_current_budget = e_i[α] 

                inclusion_value_with_calc_payoff = P[α, β + 1 - p_i[α]] + ret_payoff_within_current_budget


                P[α + 1, β + 1] = max(exclusion_value, inclusion_value_with_calc_payoff)
            end
        end
    end
    
    # Return the bottom-right cell 
    # as Knapsack is finished now.
    return P[n + 1, b + 1]
end


function test_knapsack_max_profit()

    p_i = [4, 1, 3]           # Prices of assets A
    e_i = [8, 4, 6]           # Expected returns from assets A
    b = 4                    # Total available budget (Constant)
    
    expected_max_profit = 10
    computed_max_profit = knapsack_max_profit(p_i, e_i, b)

    if computed_max_profit == expected_max_profit
        println("Test passed.")
    else
        println("Test failed.")
    end
end


test_knapsack_max_profit()


function run_investment_knapsack()
    p_i = [4, 4, 10, 8, 1, 10, 3, 1, 6, 6]      
    e_i = [5, 9, 8, 7, 13, 5, 14, 9, 1, 9]     
    b = 26                                     

    max_profit = knapsack_max_profit(p_i, e_i, b)
    println("The maximum profit for the investment problem is: $max_profit.")
end


run_investment_knapsack()

# Test passed.
# The maximum profit for the investment problem is: 62.


