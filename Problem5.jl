#Theoretically
i = 0
Probability = 1
while Probability > 0.001
    global Probability = Probability - (binomial(8,i) * (1/78)^i * (77/78)^(8-i))
    global i += 1
end
println("The probability of password getting stored is less than or equal to 0.001 when at least " , i , " characters are same.")