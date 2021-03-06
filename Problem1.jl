using Plots

y = []
sum1 = 0
for i in 1:5000
    global sum1 = sum1 + rand(-1000:1000)
    push!(y,sum1/i)
end
println(sum1/5000)
p1 = plot(1:5000,y,xlabel = "Samples", ylabel = "Mean")
display(p1)

y = []
sum1 = 0
for i in 1:50000
    global sum1 = sum1 + rand(-1000:1000)
    push!(y,sum1/i)
end
println(sum1/50000)
p2 = plot(1:50000,y,xlabel = "Samples", ylabel = "Mean")
display(p2)

y = []
sum1 = 0
for i in 1:80000
    global sum1 = sum1 + rand(-1000:1000)
    push!(y,sum1/i)
end
println(sum1/80000)
plot(1:80000,y,xlabel = "Samples", ylabel = "Mean")
