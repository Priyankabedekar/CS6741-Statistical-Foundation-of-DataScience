
characters = 1:78
Actual_Password = zeros(8)
Hacker_Attempt = zeros(8)
matched = 0
for i in 1:8
    Actual_Password[i] = rand(characters)
end
for _ in 1:1000000
    global count = 0
    for i in 1:8
        Hacker_Attempt[i] = rand(characters) 
    end
    for i in 1:8
        if Hacker_Attempt[i] == Actual_Password[i]
            count += 1
        end 
        if count == 2
            global matched += 1
            break
        end
    end
end
Experimental_Prob = matched / 1000000
Theoretical_Prob = 1 - ((77)^8 + binomial(8,1) * (77)^7)/(78)^8
println(Experimental_Prob,"\n", Theoretical_Prob)
println("Absolute Difference:", abs.(Theoretical_Prob - Experimental_Prob))