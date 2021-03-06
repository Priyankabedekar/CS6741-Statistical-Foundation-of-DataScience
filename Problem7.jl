using StatsBase

global probability = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
count = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]

for _ in 1:50000
    money = [10, 10, 10, 10, 10, 10, 10, 10, 10]
    global bankrupt = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    for _ in 1:20
        for i in 1:9
            global p = [probability[i], 1-probability[i]]
            global val = [-1, 1]
            outcome = sample(val, Weights(p))
            money[i] = money[i] + outcome
            if money[i] == 0
                bankrupt[i] = 1
            end
        end
    end
    for i in 1:9
        if bankrupt[i] == 1
           count[i] += 1
        end
    end
end
println("For different values of p ranging from 0.1 to 0.9")
println("No of times you go bankrupt out of total experiments")
println(count)
println("probability of that at the end of 20 days, you have gone bankrupt at least once")
println(count/50000)