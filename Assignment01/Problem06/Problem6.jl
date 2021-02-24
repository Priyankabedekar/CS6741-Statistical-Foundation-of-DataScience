using StatsBase

global probability = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
count = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
for _ in 1:50000
    money = [10, 10, 10, 10, 10, 10, 10, 10, 10]
    for j in 1:20
        for i in 1:9
            global p = [probability[i], 1-probability[i]]
            global val = [-1, 1]
            outcome = sample(val, Weights(p))
            money[i] = money[i] + outcome
        end
    end
    for i in 1:9
        if money[i] >= 10
           count[i] += 1
        end
    end
end
println("For different values of p ranging from 0.1 to 0.9")
println("No of times amount is at least 10 out of total experiments")
println(count)
println("probability of that at the end of 20 days, you have at least Rs 10")
println(count/50000)