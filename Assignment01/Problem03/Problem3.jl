include("Problem2.jl")
using Plots
pyplot()

# with replacement , 'n' is no of jacks which can be from zero to five jacks.
Probability = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
for i in 0:5
    Probability[i+1] = binomial(5,i) * (4/52)^i * (48/52)^(5-i)
end
p3 = plot(0:5,Probability, marker = "o",label = "With Replacement", xlabel = "No of Jacks",ylabel = "Probabilities")
println(Probability)

#without replacement, 'n' is no of Jacks which can be from zero to four.
Probability1 = [0.0, 0.0, 0.0, 0.0, 0.0]
for i in 0:4
    Probability1[i+1] = (factorial(big(47)) * binomial(5,i) * factorial(big(48)) * factorial(big(4)))/(factorial(big(4-i)) * factorial(big(48-5+i)) * factorial(big(52)) )
end
p4 = plot(0:4,Probability1, marker = "o",color = "orange", label = "Without Replacement", xlabel = "No of Jacks",ylabel = "Probabilities")
println(Probability1)

println("Absolute Difference with Replacement", abs.(Prob_of_jacks - Probability))
println("Absolute Difference without Replacement", abs.(Prob_of_jacks1 - Probability1))
plot(p3, p4)