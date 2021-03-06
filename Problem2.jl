using Plots
pyplot()

cards = 1:52
# with replacement , 'n' is no of jacks which can be from zero to five jacks.
Prob_of_jacks = [0.00, 0.00, 0.00, 0.00, 0.00, 0.00]
for _ in 1:50000
    n = 0
    for _ in 1:5
        global pickedcard = rand(cards)
        if pickedcard % 13 == 11
            n += 1
        end
    end
    Prob_of_jacks[n+1] += 1
end
Prob_of_jacks /= 50000
println(Prob_of_jacks)
print(sum(Prob_of_jacks))
p1 = plot(0:5,Prob_of_jacks, marker = "o",label = "With Replacement", xlabel = "No of Jacks",ylabel = "Probabilities")

#without replacement, 'n' is no of Jacks which can be from zero to four.
Prob_of_jacks1 = [0.00, 0.00, 0.00, 0.00, 0.00]
cards = 1:52
deck = zeros(52)
for _ in 1:50000
    for i in 1:52
        deck[i] = i
    end
    n = 0
    for _ in 1:5
        while true
            global pickedcard = rand(cards)
            deck[pickedcard] == 0 || break
        end
        if pickedcard % 13 == 11
            n += 1
        end
        deck[pickedcard] = 0
    end
    Prob_of_jacks1[n+1] += 1  
end
Prob_of_jacks1 /= 50000
println(Prob_of_jacks1)
print(sum(Prob_of_jacks1))
p2 = plot(0:4,Prob_of_jacks1, marker = "o",color = "orange", label = "Without Replacement", xlabel = "No of Jacks",ylabel = "Probabilities")