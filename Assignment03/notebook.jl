### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 911e0a80-9084-11eb-0e52-e1128bd5aa9a
begin
	using Distributions
	using PlutoUI
	using StatsPlots
	using StatsBase
	using LaTeXStrings
	using QuadGK
	using CSV
	using DataFrames
	using Dates
	using Statistics
	using DSP
	using KernelDensity
end

# ╔═╡ e05d19a0-9085-11eb-3fcd-cd73fc4f284b
begin
	using Plots
	plotly()
end

# ╔═╡ 9c86d650-9083-11eb-378e-e7afa7ea08bb
md"# Assignment 03"

# ╔═╡ cdc5cd20-9083-11eb-1336-19bf5ece8738
md"#### Problem 01"

# ╔═╡ 66a3af30-90ac-11eb-17f6-3915123cb745
function KL(P,Q)
	return quadgk(x -> (pdf(P,x) * log(pdf(P,x)/pdf(Q,x))), -30, 30)[1]
end

# ╔═╡ 2611ddc0-9084-11eb-1616-f79eac7973ef
begin
	Dist = []
	for i in 1:5
	   Q = Normal(0,1)
	   P = TDist(i)
	   kl = KL(P,Q)
	   append!(Dist, kl)
	end
end

# ╔═╡ 31e9972e-90b3-11eb-28f8-6d26beb7f71e
Dist

# ╔═╡ 8d5f496e-90b3-11eb-3eaf-ad9c4e5f0323
md"#### Problem 02"

# ╔═╡ aa2946a0-9531-11eb-1d74-3723a1a56537
function KL2(P,Q)
	return quadgk(x -> (pdf(P,x) * log(pdf(P,x)/pdf(Q,x))), -50,50)[1]
end

# ╔═╡ 47b03e2e-9535-11eb-13e0-f309ecb565cf
begin
	Con = rand(Uniform(0,1),1000)
	Distance = []
	for i in 2:10
		p = rand(Uniform(0,1),1000)
		Con = conv(Con,p)
		append!(Distance, KL2(kde(Con), Normal(mean(Con), std(Con))))
	end
end

# ╔═╡ 1b58820e-9536-11eb-0c17-e559f2686df2
Distance

# ╔═╡ 1b39e10e-9537-11eb-398e-29465dfbbce9
plot(Distance, label = "KL Distance",xlabel = "n distributions", ylabel = "Distances")

# ╔═╡ 18b87000-914a-11eb-1376-bdc28621187d
md"#### Problem 03"

# ╔═╡ a94ad960-9153-11eb-0996-f15260e2e8f3
begin
	c = zeros(400)
	append!(c,1 for _ in 1:100)
end

# ╔═╡ db3a8290-9153-11eb-1f6b-1dab11b55932
begin
	append!(c,i for i in 100:200)
	append!(c,i for i in 100:200)
	append!(c,i for i in 100:200)
	append!(c,i for i in 100:200)
	append!(c,i for i in 100:200)
	append!(c,i for i in 990:1000)
end

# ╔═╡ e38db480-9153-11eb-1c49-13fc3fcb035e
length(c)

# ╔═╡ 1387f650-9154-11eb-2852-3d63bddce407
begin
	m1 = mean(c)
	v1 = median(c)
	m01 = mode(c)
	m1,v1,m01
end

# ╔═╡ b67b3fa0-916f-11eb-2e55-2dbd6fc6e853
begin
	density(vec(c))
	plot!([m1,m1],[0,0.00167], label = "mean", line = (1, :red))
	plot!([v1,v1],[0,0.00234], label = "median",  line = (1, :dash, :green))
	plot!([m01,m01],[0,0.0077], label = "mode",  line = (1, :dash, :blue))
end

# ╔═╡ 2a8ce2be-955f-11eb-322a-effd164e99be
md"2nd Plot"

# ╔═╡ b7ea0420-916a-11eb-3e0c-8751a950a4b7
begin
	x = [i for i in 0:100]
	append!(x,x)
	append!(x,x)
	append!(x,x)
	append!(x,x)
	
end

# ╔═╡ b9f26c60-916c-11eb-175c-21c6c439a39c
begin
	# append!(x, 1 for i in 1:250)
	append!(x, i for i in 1:20)
	append!(x, i for i in 1:20)
	append!(x, i for i in 1:20)
	append!(x, i for i in 1:20)
	append!(x, i for i in 1:20)
	append!(x, 51 for _ in 1:200)
	append!(x, i for i in 150:10:350)
end

# ╔═╡ 8c482a80-916b-11eb-057b-bb80545be530
length(x)

# ╔═╡ f45a94b0-916a-11eb-0c7e-75a90913466d
begin
	m =  mean(x)
	v = median(x)
	mo = mode(x)
	m,v,mo
end

# ╔═╡ 7ec916f0-916e-11eb-3992-fd30bcf62999
begin
	histogram(x, normalize = :pdf)
	d = density!(vec(x))
	plot!([m,m],[0,0.014], label = "mean", line = (2, :red))
	plot!([v,v],[0,0.014],  label = "median", line = (2, :dash, :green))
	plot!([mo,mo],[0,0.014],  label = "mode", line = (2, :dash, :pink))
end

# ╔═╡ 0fbab710-9217-11eb-3546-6d5c46821465
md"#### Problem 04"

# ╔═╡ be1a9b90-9217-11eb-1bce-7564947bf177
begin
	Data = []
	for i in 1:10000
		sample = [rand(Uniform(),30)]
		append!(Data,sample)
	end
	Data
end

# ╔═╡ e17c1d10-9218-11eb-3973-edfc82931f03
begin
		Range = []
	for i in 1:10000
		append!(Range, extrema(Data[i])[2] - extrema(Data[i])[1])
	end
	    Range
end

# ╔═╡ 504c7dc0-9219-11eb-00c5-03c007e66771
begin
	histogram(Range, normalize = :pdf)
	density!(Range)
	plot!([mean(Range),mean(Range)], [0,12], label = "mean", line = (2, :red))
	plot!([median(Range),median(Range)],[0,12],  label = "median", line = (2, :dash, :orange))
	plot!([mode(Range),mode(Range)],[0,12],  label = "mode", line = (2, :pink))
end

# ╔═╡ 79dac430-9219-11eb-065c-3135adb9af44
mean(Range), median(Range), mode(Range)

# ╔═╡ 8f63bcee-921c-11eb-130a-b550c3fee7e5
md"#### Problem 06"

# ╔═╡ fa238540-930a-11eb-2e59-a1b2ac596c27
begin
	states =sort(CSV.read("C:\\Users\\Admin\\Desktop\\JULIA\\Assignment1\\Assignment03\\states.csv", DataFrame), 2)
	states[!,"year"] = parse.(Int,getindex.(string.(states.Date), Ref(1:4)))
	states[!,"week"] = Dates.week.(states.Date) .- 4
	maximum(states.week)
end

# ╔═╡ dc2c0530-9319-11eb-11c5-4d8192ef8e8c
begin
	states[!, :week][states[!, :year] .== 2021] .+= 53
	states[!, :week][states[!, :week] .== 102] .= 49
end

# ╔═╡ 2fc1e1c0-930f-11eb-1ae9-23dd696d099a
groupby(states, [:week, :State])

# ╔═╡ 2b0e6f00-9313-11eb-165b-937f83ba6c82
 Table = combine(groupby(states, [:week, :State]),  :Confirmed => sum => :Sum)

# ╔═╡ 0f47e670-9327-11eb-3394-059df70794c1
g = groupby(Table, [:State])

# ╔═╡ 625a6130-9327-11eb-1b14-35d03a5258c7
for i in length(g):-1:1
	for j in nrow(g[i]):-1:2
		g[i][j, :Sum] = g[i][j, :Sum] - g[i][j-1, :Sum]
	end
end

# ╔═╡ 4508cdd0-9325-11eb-2cf1-4db77756d030
T = sort(unstack(Table, :State, :Sum), 1)[!, Not(:"State Unassigned")]

# ╔═╡ 22ac9510-9329-11eb-36b9-a1f327a28e30
begin
	T1 = T[!, Not(:India)]
	Covid = T1[!, Not(:week)]
	for col in names(Covid)
		Covid[ismissing.(Covid[:,col]), col] .= 0.0
	end
end

# ╔═╡ 59c30090-94b7-11eb-04c4-9d710cddab8d
names(Covid)

# ╔═╡ cb9fbd60-9337-11eb-2c72-e9c7d9f046ad
function covmat(df)
       nc = ncol(df)
       t = zeros(nc, nc)
       for (i, c1) in enumerate(eachcol(df))
           for (j, c2) in enumerate(eachcol(df))
               sx, sy = skipmissings(c1, c2)
               t[i, j] = cov(collect(sx), collect(sy), corrected = false)
           end
       end
       return t
end

# ╔═╡ 1a8a43e0-9339-11eb-28a1-f1d75aecd4d3
Covariance = covmat(Covid)

# ╔═╡ 0c529940-933d-11eb-1f5f-7979c3887ece
begin
	heatmap(names(Covid), names(Covid), Covariance, c = cgrad([:purple, :white, :red, :yellow]), xrotation = 30,xlabel="X Values", ylabel="Y Values", title="Covariance Heatmap")
end

# ╔═╡ 69bc2910-9339-11eb-093b-69d5f4ebed8c
function corrmat(df)
       nc = ncol(df)
       t = zeros(nc, nc)
       for (i, c1) in enumerate(eachcol(df))
           for (j, c2) in enumerate(eachcol(df))
               sx, sy = skipmissings(c1, c2)
               t[i, j] = cor(collect(sx), collect(sy))
           end
       end
       return t
end

# ╔═╡ 640ded80-933b-11eb-15e5-b1ede0a8ca36
Correlation = corrmat(Covid)

# ╔═╡ ec184100-933e-11eb-3d44-b53d963f921f
begin
	heatmap(1:size(Covid, 2), 1:size(Covid, 2), Correlation, c = cgrad([:purple, :white, :red, :yellow]), xlabel="X Values", ylabel="Y Values", title="Correlation Heatmap")
end

# ╔═╡ 4cab07d0-933c-11eb-283e-bdf02a829918
find(x) = [indexin(x[i],sort(x))[1] for i in 1:length(x)]

# ╔═╡ ff3c0850-933b-11eb-213a-ffcaf46e5453
function s_cor(x,y)
	t = cor(find(x), find(y))
	return t
end

# ╔═╡ a916a840-933b-11eb-23dc-670813289215
function scorrmat(df)
       nc = ncol(df)
       t = zeros(nc, nc)
       for (i, c1) in enumerate(eachcol(df))
           for (j, c2) in enumerate(eachcol(df))
               sx, sy = skipmissings(c1, c2)
               t[i, j] = s_cor(collect(sx), collect(sy))
           end
       end
       return t
end

# ╔═╡ b3b21c80-933b-11eb-0616-294262ec39a0
Spearman_Corr = scorrmat(Covid)

# ╔═╡ 0c2f20d0-933f-11eb-005f-3d9cf6ee4684
begin
	heatmap(1:size(Covid, 2), 1:size(Covid, 2), Spearman_Corr, c = cgrad([:darkblue, :white, :orange, :yellow]), xlabel="X Values", ylabel="Y Values", title="Spearman Correlation Heatmap")
end

# ╔═╡ d7821092-9497-11eb-0af0-5f668838cc11
md"#### Problem 07"

# ╔═╡ e1d77b20-9497-11eb-24b5-fb219297e945
begin
	N = Normal(0,1)
	T_dist = TDist(10)
	val = 95
end

# ╔═╡ 171691e0-94a2-11eb-2f5d-d953b0ce96ac
function OneSidedTail_Normal(x)
	return quantile(Normal(0,1), (100-x)/100)
end

# ╔═╡ f40bf910-9497-11eb-1b16-9518b872b843
begin
	xval = OneSidedTail_Normal(95)
	plot(x->x, x->pdf(N, x), xval, -5, fill = (0,:red), fillalpha = 0.5, title = "OneSidedTail("*string(val)*") is " * string(100-val)*" Percentile", label = "Area under 100-x %")
	plot!(x->x, x->pdf(N,x), -5, 5, line = 3, label = "Normal Dist")
end

# ╔═╡ 4bedfc70-94c8-11eb-2f4b-a7956cfe5e85
cdf(N, xval)

# ╔═╡ 3a5ff57e-94b9-11eb-00a2-074edc5b9f59
function OneSidedTail_Tdist(x)
	return quantile(TDist(10), (100-x)/100)
end

# ╔═╡ 7b0daaa0-94a5-11eb-3954-0fe0e8f25ae0
begin
	xval_1 = OneSidedTail_Tdist(val)
	plot(x->x, x->pdf(T_dist, x), xval_1, -5, fill = (0,:blue), fillalpha = 0.5, title = "OneSidedTail("*string(val)*") is " * string(100-val)*" Percentile", label = "Area under 100-x %")
	plot!(x->x, x->pdf(T_dist,x), -5, 5, line = 3,  label = "Student T Dist")
end

# ╔═╡ Cell order:
# ╟─9c86d650-9083-11eb-378e-e7afa7ea08bb
# ╠═911e0a80-9084-11eb-0e52-e1128bd5aa9a
# ╠═e05d19a0-9085-11eb-3fcd-cd73fc4f284b
# ╟─cdc5cd20-9083-11eb-1336-19bf5ece8738
# ╠═66a3af30-90ac-11eb-17f6-3915123cb745
# ╠═2611ddc0-9084-11eb-1616-f79eac7973ef
# ╠═31e9972e-90b3-11eb-28f8-6d26beb7f71e
# ╟─8d5f496e-90b3-11eb-3eaf-ad9c4e5f0323
# ╠═aa2946a0-9531-11eb-1d74-3723a1a56537
# ╠═47b03e2e-9535-11eb-13e0-f309ecb565cf
# ╠═1b58820e-9536-11eb-0c17-e559f2686df2
# ╠═1b39e10e-9537-11eb-398e-29465dfbbce9
# ╟─18b87000-914a-11eb-1376-bdc28621187d
# ╠═a94ad960-9153-11eb-0996-f15260e2e8f3
# ╠═db3a8290-9153-11eb-1f6b-1dab11b55932
# ╠═e38db480-9153-11eb-1c49-13fc3fcb035e
# ╠═1387f650-9154-11eb-2852-3d63bddce407
# ╠═b67b3fa0-916f-11eb-2e55-2dbd6fc6e853
# ╠═2a8ce2be-955f-11eb-322a-effd164e99be
# ╠═b7ea0420-916a-11eb-3e0c-8751a950a4b7
# ╠═b9f26c60-916c-11eb-175c-21c6c439a39c
# ╠═8c482a80-916b-11eb-057b-bb80545be530
# ╠═f45a94b0-916a-11eb-0c7e-75a90913466d
# ╠═7ec916f0-916e-11eb-3992-fd30bcf62999
# ╠═0fbab710-9217-11eb-3546-6d5c46821465
# ╠═be1a9b90-9217-11eb-1bce-7564947bf177
# ╠═e17c1d10-9218-11eb-3973-edfc82931f03
# ╠═504c7dc0-9219-11eb-00c5-03c007e66771
# ╠═79dac430-9219-11eb-065c-3135adb9af44
# ╟─8f63bcee-921c-11eb-130a-b550c3fee7e5
# ╠═fa238540-930a-11eb-2e59-a1b2ac596c27
# ╠═dc2c0530-9319-11eb-11c5-4d8192ef8e8c
# ╠═2fc1e1c0-930f-11eb-1ae9-23dd696d099a
# ╠═2b0e6f00-9313-11eb-165b-937f83ba6c82
# ╠═0f47e670-9327-11eb-3394-059df70794c1
# ╠═625a6130-9327-11eb-1b14-35d03a5258c7
# ╠═4508cdd0-9325-11eb-2cf1-4db77756d030
# ╠═59c30090-94b7-11eb-04c4-9d710cddab8d
# ╠═22ac9510-9329-11eb-36b9-a1f327a28e30
# ╠═cb9fbd60-9337-11eb-2c72-e9c7d9f046ad
# ╠═1a8a43e0-9339-11eb-28a1-f1d75aecd4d3
# ╠═0c529940-933d-11eb-1f5f-7979c3887ece
# ╠═69bc2910-9339-11eb-093b-69d5f4ebed8c
# ╠═640ded80-933b-11eb-15e5-b1ede0a8ca36
# ╠═ec184100-933e-11eb-3d44-b53d963f921f
# ╠═4cab07d0-933c-11eb-283e-bdf02a829918
# ╠═ff3c0850-933b-11eb-213a-ffcaf46e5453
# ╠═a916a840-933b-11eb-23dc-670813289215
# ╠═b3b21c80-933b-11eb-0616-294262ec39a0
# ╠═0c2f20d0-933f-11eb-005f-3d9cf6ee4684
# ╟─d7821092-9497-11eb-0af0-5f668838cc11
# ╠═e1d77b20-9497-11eb-24b5-fb219297e945
# ╠═171691e0-94a2-11eb-2f5d-d953b0ce96ac
# ╠═f40bf910-9497-11eb-1b16-9518b872b843
# ╠═4bedfc70-94c8-11eb-2f4b-a7956cfe5e85
# ╠═3a5ff57e-94b9-11eb-00a2-074edc5b9f59
# ╠═7b0daaa0-94a5-11eb-3954-0fe0e8f25ae0
