### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 43c174d0-7a7b-11eb-04e9-6b12d65df547
using DataFrames

# ╔═╡ d166d9b0-7b2f-11eb-1b25-a78253a1bf13
using CSV

# ╔═╡ 40c1da40-7b48-11eb-31e3-b39dca7f33b5
using JSON

# ╔═╡ aef7435e-7b5c-11eb-3a0d-a7b05baa136f
using HTTP

# ╔═╡ 06824840-7cad-11eb-031c-557c08c73dda
using Dates

# ╔═╡ f3ecdf42-7ca4-11eb-28db-e5b75002643d
begin
	using Plots, Statistics
	gr()
end

# ╔═╡ dbb1e640-7a7a-11eb-1c2c-55a1d675e952
md"# Assignment - 02"

# ╔═╡ 38db6300-7a7b-11eb-3dc6-df1675729ce2
md"#### Problem 01"

# ╔═╡ 301b67b0-7a8a-11eb-1dd3-49042c9da3a2
begin
	df = DataFrame()
	df.Religion = ["Agnostic", "Atheist", "Buddhist", "Catholic", "Don’t   know/refused", "Evangelical Prot", "Hindu", "Historically Black Prot", "Jehovah's Witness", "Jewish"]
	df."<\$10k" = [27, 12, 27, 418, 15, 575, 1, 228, 20, 19]
	df."\$10-20k" = [34, 27, 21, 617, 14, 869, 9, 244, 27, 19]
	df."\$20-30k" = [60, 37, 30, 732, 15, 1064, 7, 236, 24, 25]
	df."\$30-40k" = [81, 52, 34, 670, 11, 982, 9, 238, 24, 25]
	df."\$40-50k" = [76, 35, 33, 638, 10, 881, 11, 197, 21, 30]
	df."\$50-75k" = [137, 70, 58, 1116, 35, 1486, 34, 223, 30, 95]
	df."\$75-100k" = [122, 25, 64, 1563, 46, 150, 69, 489, 256,74]
	df."\$100-150k" = [109, 34, 60, 81, 76, 13, 907,23, 231, 45]
	df.">\$150k" = [84, 14, 15, 11, 10, 35, 123, 156, 696, 54]
	df."Don't know/refused" = [96, 12, 21, 617, 14, 869, 9, 244, 27, 19]
	df
end


# ╔═╡ 67adbf70-7aa3-11eb-059d-1be6696a36f3
untidy_data = df

# ╔═╡ 083d1b30-7a8a-11eb-2b22-9d385fc58cf4
md" Figure 1(a): Untidy data"


# ╔═╡ ff8157b0-7cdf-11eb-3b6e-6d3d4eb0b508
Tidy_Data = stack(untidy_data, 2:11, variable_name = :Income, value_name = :Frequency)

# ╔═╡ f0d2b210-7aa3-11eb-21e0-1552ca1899c9
sort(Tidy_Data, [1])

# ╔═╡ a2698630-7ac6-11eb-344b-d1aa6e58b9f4
md"Figure 1(b): Tidy data"

# ╔═╡ bf77fc40-7aab-11eb-029f-1599d7829e56
md"#### Problem 02"

# ╔═╡ ccd24262-7aab-11eb-032c-a93cfbdf89d1
df1 = DataFrame(
	id      = ["MX17004", "MX17004", "MX17004", "MX17004", "MX17004", "MX17004", "MX17004", "MX17004", "MX17004", "MX17004"], 
    year    = [2010, 2010, 2010, 2010, 2010, 2010, 2010, 2010,  2010, 2010],
    month   = [1, 1, 2, 2, 3, 3, 4, 4, 5, 5],
    element = ["tmax", "tmin", "tmax", "tmin", "tmax", "tmin", "tmax", "tmin", "tmax", "tmin"],
    d01      = [missing, missing, missing, missing, missing, missing, missing, missing, missing, missing ],
    d02      = [missing, missing, 27.3, 14.4, missing, missing, missing, missing, missing, missing],
    d03      = [missing, missing, 24.1, 14.4, missing, missing, missing, missing, missing, missing],
    d04      = [missing, missing, missing, missing, missing, missing, missing, missing, missing, missing],
    d05      = [missing, missing, missing, missing, 32.1, 14.2, missing, missing, missing, missing],
	d06      = [missing, missing, missing, missing, missing, missing, missing, missing, missing, missing],
	d07      = [missing, missing, missing, missing, missing, missing, missing, missing, missing, missing],
	d08      = [missing, missing, 27.6, 21.8, missing, missing, missing, missing, missing, missing],
	d09      = [missing, missing, missing, missing, missing, missing, missing, missing, missing, missing],
	d10     = [missing, missing, missing, missing, 34.5, 16.8, missing, missing, missing, missing],
	d11     = [missing, missing, 29.7, 13.4, missing, missing, missing, missing, missing, missing],
	d12     = [missing, missing, missing, missing, missing, missing, missing, missing, missing, missing],
	d13     = [missing, missing, missing, missing, missing, missing, missing, missing, missing, missing],
	d14     = [missing, missing, missing, missing, missing, missing, missing, missing, missing, missing],
	d15     = [missing, missing, missing, missing, missing, missing, missing, missing, missing, missing],
	d16     = [missing, missing, missing, missing, 31.1, 17.6, missing, missing, missing, missing],
	d17     = [missing, missing, missing, missing, missing, missing, missing, missing, missing, missing],
	d18     = [missing, missing, missing, missing, missing, missing, missing, missing, missing, missing],
	d19     = [missing, missing, missing, missing, missing, missing, missing, missing, missing, missing],
	d20     = [missing, missing, missing, missing, missing, missing, missing, missing, missing, missing],
	d21     = [missing, missing, missing, missing, missing, missing, missing, missing, missing, missing],
	d22     = [missing, missing, missing, missing, missing, missing, missing, missing, missing, missing],
	d23     = [missing, missing, 29.9, 10.7, missing, missing, missing, missing, missing, missing],
	d24     = [missing, missing, missing, missing, missing, missing, 34.5, 23.6, missing, missing],
	d25     = [missing, missing, missing, missing, missing, missing, missing, missing, missing, missing],
	d26     = [missing, missing, missing, missing, missing, missing, missing, missing, missing, missing],
	d27     = [missing, missing, missing, missing, missing, missing, 36.3, 16.7, 33.2, 18.2],
	d28     = [missing, missing, missing, missing, missing, missing, missing, missing, 34.6, 18.5],
	d29     = [missing, missing, missing, missing, missing, missing, missing, missing, missing, missing],
	d30     = [27.8, 14.5, missing, missing, missing, missing, missing, missing, missing, missing],
	d31     = [missing, missing, missing, missing, missing, missing, missing, missing, missing, missing])

# ╔═╡ a3374100-7ac7-11eb-0034-0b2f9c236164
md"Figure 2(a): Untidy data"

# ╔═╡ d4f1be80-7ac9-11eb-0062-9769f10db702
df2 = dropmissing(stack(df1, 5:35))

# ╔═╡ 4f8234f0-7ad8-11eb-3f2b-2d214387a590
df2[!, "day"] = getindex.(string.(df2.variable), Ref(2:3))

# ╔═╡ 3ab1e100-7ad9-11eb-3d57-e9407f5b54f7
df2

# ╔═╡ 62fcbdde-7acc-11eb-0d82-0b5ca0239e6f
Date = transform!(df2, [:year, :month, :day]  => ByRow((year, month, day) -> string(year, "-0", month, "-",day)) => :Date)

# ╔═╡ 6833d0d0-7ace-11eb-16c4-8bb8d7a519af
tidy = sort(Date[!,[1,8,4,6]], 2)

# ╔═╡ 122d5bb0-7ad4-11eb-0898-479accc3a3f6
unstack(tidy, :element, :value)

# ╔═╡ 826d389e-7ad9-11eb-15ee-0d0ed9d6ac3f
md"Figure 2(b): Tidy data"

# ╔═╡ 91b995ae-7b24-11eb-136a-6586f2224f10
md"#### Problem 03"

# ╔═╡ b39623e0-7b30-11eb-36d4-65c1df7006c3
billboard = sort(CSV.read("C:\\Users\\Admin\\Desktop\\JULIA\\Assignment2\\Billboard.csv", DataFrame), 2)

# ╔═╡ a0981cf0-7b47-11eb-33bd-fbdd3583c463
md"Figure 3(a): Untidy data"

# ╔═╡ 373046d0-7b46-11eb-01e4-8fb1c1b29ef8
insertcols!(billboard, 1, :id => 1:317, makeunique=true)

# ╔═╡ 41b36400-7b39-11eb-0a12-2120db5658fb
b1 = billboard[!, [1,2,3,4,5,7,9,10,11,12,13,14,15,16,17,18]]

# ╔═╡ 619c126e-7b3a-11eb-019c-418fb3c49900
b2 = sort(stack(b1, 7:16, variable_name = :week, value_name = :rank), 3)

# ╔═╡ 979bd030-7b3b-11eb-0b84-ed315decd42c
b3 = unique(b2[!,[ :id,:artist, :track, :time]])

# ╔═╡ 6198d5c0-7b48-11eb-0c28-87a9cb35de69
md"Figure 3(b): tidy data (DataFrame 1)"

# ╔═╡ 04329060-7b43-11eb-12b3-dbb35e4fd6a9
b4 = b2[!,[:id, :date, :rank]]

# ╔═╡ b2bce370-7b47-11eb-0cfa-639f25075cd3
md"Figure 3(b): tidy data (DataFrame 2)"

# ╔═╡ 351ac260-7b48-11eb-226f-c35b467128e9
md"#### Problem 04"

# ╔═╡ 0e4df5d0-7b5c-11eb-3bf9-cfbba68fcf4d
begin
	Data = HTTP.request("GET", "https://api.covid19india.org/data.json")
	str = String(Data.body)
    Json = JSON.parse(str)
end

# ╔═╡ 8e39f610-7c3b-11eb-1df9-512b26dcd8ac
tested = vcat(DataFrame.(Json["tested"])...)

# ╔═╡ c2f2d160-7c3b-11eb-1451-d34022d03511
covid_1 = vcat(DataFrame.(Json["cases_time_series"])...)

# ╔═╡ de2d8ce0-7ca4-11eb-0689-8b2f8bdd57f8
md"DataFrame for Covid Cases"

# ╔═╡ e3221560-7ca2-11eb-1a83-7fe55bffc229
describe(covid_1)

# ╔═╡ 9d0342a0-7c95-11eb-0354-91111a755b26
begin
	covid_1[!, "month"] = getindex.(string.(covid_1.date), Ref(4:6))
	covid_1[!, "year"] = getindex.(string.(covid_1.dateymd), Ref(1:4))
	transform!(covid_1, [:month, :year]  => ByRow((month, year) -> string(month, " ",       year)) => :Month_year)
	sort(covid_1, (:dateymd))
end

# ╔═╡ 84bfdc70-7ca0-11eb-0c57-9575c80a6860
covid_1[!,:D] = parse.([Int],covid_1[!,:dailydeceased])

# ╔═╡ 77a89d50-7ca1-11eb-3c3c-3d85710b5946
covid_1[!,:C] = parse.([Int],covid_1[!,:dailyconfirmed])

# ╔═╡ 9ac14b70-7ca1-11eb-2c62-b723ff0839f2
covid_1[!,:R] = parse.([Int],covid_1[!,:dailyrecovered])

# ╔═╡ 4eed9cb2-7cb2-11eb-1877-b5afafa7ff06
covid = covid_1[!,[4,5,6,7,8,11,12,13,14]]

# ╔═╡ 01bfc2b0-7ca3-11eb-0380-93f0d685d3be
describe(covid)

# ╔═╡ 8e5441f0-7c95-11eb-0ac4-e721ec23f088
covid_by_month = groupby(covid, :Month_year)

# ╔═╡ deea0770-7c96-11eb-3239-f56043f36932
Aggregate = combine(covid_by_month,  :C => sum => :Confirmed, :D => sum => :Deceased, :R => sum => :Recovered)

# ╔═╡ 40b0d910-7ca2-11eb-14ec-5d7a8b93f5a0
insertcols!(Aggregate, 1, :Month_No => 1:15, makeunique=true)

# ╔═╡ c603ca30-7ca4-11eb-28d3-610f338c2971
md"Month-wise Aggregate values "

# ╔═╡ bce028e0-7ca4-11eb-1471-3fb028c89c39
md"#### Problem 05"

# ╔═╡ 1c12c9d0-7caa-11eb-1f0d-1da3b950b1cb
plot_covid = covid[!,[8,7,9,2,6,3,4,5]]

# ╔═╡ 3a6b8870-7cb6-11eb-1c52-534bb2a82792
begin
	conf = plot_covid[!, :C]
	Dece = plot_covid[!, :D]
	Recov = plot_covid[!, :R]
end

# ╔═╡ a12b5af0-7cb5-11eb-1e4c-25a6ab392010
begin
	moving_avg_C = [0.0 for _ in 1:399]
	moving_avg_D = [0.0 for _ in 1:399]
	moving_avg_R = [0.0 for _ in 1:399]
end

# ╔═╡ b7be1a30-7cc6-11eb-285a-090e236cb806
for i in 7:399
	mean = 0.0
	mean = (conf[i-6] + conf[i-5] + conf[i-4] + conf[i-3] + conf[i-2] + conf[i-1] + 			  conf[i])/7
    moving_avg_C[i] = mean
	mean = 0.0
	mean = (Dece[i-6] + Dece[i-5] + Dece[i-4] + Dece[i-3] + Dece[i-2] + Dece[i-1] + 			  Dece[i])/7
    moving_avg_D[i] = mean
	mean = 0.0
	mean = (Recov[i-6] + Recov[i-5] + Recov[i-4] + Recov[i-3] + Recov[i-2] + Recov[i-1] + 			  Recov[i])/7
    moving_avg_R[i] = mean
end


# ╔═╡ 1fc82880-7cdd-11eb-1402-e323fcd04224
begin
	plot_covid[!, "Confirmed"] = moving_avg_C
	plot_covid[!, "Deceased"] = moving_avg_D
	plot_covid[!, "Recovered"] = moving_avg_R
end

# ╔═╡ 36e133ee-7cdc-11eb-253b-fd1e05b39dba
plot_covid

# ╔═╡ 75ca0000-7ca6-11eb-2812-3f4ee8f7b544
begin
	plot(plot_covid.dateymd, plot_covid.C, title = "Covid-Cases", label = "Confirmed")
	plot!(plot_covid.dateymd, plot_covid.D, label = "Deceased")
	plot!(plot_covid.dateymd, plot_covid.R, label = "Recovered")
	xlabel!("Date")
	ylabel!("Number of Cases")
end

# ╔═╡ 108cadd0-7cb2-11eb-2765-db5c2ac1e9f9
begin
	plot(plot_covid.dateymd, plot_covid.Confirmed, title = "Covid-Cases moving Average", label = "Confirmed")
	plot!(plot_covid.dateymd, plot_covid.Deceased, label = "Deceased")
	plot!(plot_covid.dateymd, plot_covid.Recovered, label = "Recovered")
	xlabel!("Date")
	ylabel!("Number of Cases")
end

# ╔═╡ dca464f0-7cdd-11eb-24cc-e9f37f0e0b1f
begin
	p1 = plot(plot_covid.dateymd, plot_covid.C, title = "Covid-Cases", label = "Confirmed")
	p2 = plot(plot_covid.dateymd, plot_covid.Confirmed, title = "Moving average", label = "Confirmed")
	p3 = plot(plot_covid.dateymd, plot_covid.D, label = "Deceased")
	p4 = plot(plot_covid.dateymd, plot_covid.Deceased, label = "Deceased")
	p5 = plot(plot_covid.dateymd, plot_covid.R, label = "Recovered")
	p6 = plot(plot_covid.dateymd, plot_covid.Recovered, label = "Recovered")
	plot(p1,p2,p3,p4,p5,p6, layout = (3,2), legend = false)
end

# ╔═╡ Cell order:
# ╟─dbb1e640-7a7a-11eb-1c2c-55a1d675e952
# ╟─38db6300-7a7b-11eb-3dc6-df1675729ce2
# ╠═43c174d0-7a7b-11eb-04e9-6b12d65df547
# ╠═301b67b0-7a8a-11eb-1dd3-49042c9da3a2
# ╠═67adbf70-7aa3-11eb-059d-1be6696a36f3
# ╠═083d1b30-7a8a-11eb-2b22-9d385fc58cf4
# ╠═ff8157b0-7cdf-11eb-3b6e-6d3d4eb0b508
# ╠═f0d2b210-7aa3-11eb-21e0-1552ca1899c9
# ╟─a2698630-7ac6-11eb-344b-d1aa6e58b9f4
# ╟─bf77fc40-7aab-11eb-029f-1599d7829e56
# ╠═ccd24262-7aab-11eb-032c-a93cfbdf89d1
# ╟─a3374100-7ac7-11eb-0034-0b2f9c236164
# ╠═d4f1be80-7ac9-11eb-0062-9769f10db702
# ╠═4f8234f0-7ad8-11eb-3f2b-2d214387a590
# ╠═3ab1e100-7ad9-11eb-3d57-e9407f5b54f7
# ╠═62fcbdde-7acc-11eb-0d82-0b5ca0239e6f
# ╠═6833d0d0-7ace-11eb-16c4-8bb8d7a519af
# ╠═122d5bb0-7ad4-11eb-0898-479accc3a3f6
# ╟─826d389e-7ad9-11eb-15ee-0d0ed9d6ac3f
# ╟─91b995ae-7b24-11eb-136a-6586f2224f10
# ╟─d166d9b0-7b2f-11eb-1b25-a78253a1bf13
# ╟─b39623e0-7b30-11eb-36d4-65c1df7006c3
# ╟─a0981cf0-7b47-11eb-33bd-fbdd3583c463
# ╟─373046d0-7b46-11eb-01e4-8fb1c1b29ef8
# ╠═41b36400-7b39-11eb-0a12-2120db5658fb
# ╠═619c126e-7b3a-11eb-019c-418fb3c49900
# ╠═979bd030-7b3b-11eb-0b84-ed315decd42c
# ╟─6198d5c0-7b48-11eb-0c28-87a9cb35de69
# ╠═04329060-7b43-11eb-12b3-dbb35e4fd6a9
# ╟─b2bce370-7b47-11eb-0cfa-639f25075cd3
# ╟─351ac260-7b48-11eb-226f-c35b467128e9
# ╠═40c1da40-7b48-11eb-31e3-b39dca7f33b5
# ╠═aef7435e-7b5c-11eb-3a0d-a7b05baa136f
# ╠═06824840-7cad-11eb-031c-557c08c73dda
# ╠═0e4df5d0-7b5c-11eb-3bf9-cfbba68fcf4d
# ╠═8e39f610-7c3b-11eb-1df9-512b26dcd8ac
# ╠═c2f2d160-7c3b-11eb-1451-d34022d03511
# ╟─de2d8ce0-7ca4-11eb-0689-8b2f8bdd57f8
# ╠═e3221560-7ca2-11eb-1a83-7fe55bffc229
# ╠═9d0342a0-7c95-11eb-0354-91111a755b26
# ╠═84bfdc70-7ca0-11eb-0c57-9575c80a6860
# ╠═77a89d50-7ca1-11eb-3c3c-3d85710b5946
# ╠═9ac14b70-7ca1-11eb-2c62-b723ff0839f2
# ╠═4eed9cb2-7cb2-11eb-1877-b5afafa7ff06
# ╠═01bfc2b0-7ca3-11eb-0380-93f0d685d3be
# ╠═8e5441f0-7c95-11eb-0ac4-e721ec23f088
# ╠═deea0770-7c96-11eb-3239-f56043f36932
# ╠═40b0d910-7ca2-11eb-14ec-5d7a8b93f5a0
# ╟─c603ca30-7ca4-11eb-28d3-610f338c2971
# ╟─bce028e0-7ca4-11eb-1471-3fb028c89c39
# ╠═f3ecdf42-7ca4-11eb-28db-e5b75002643d
# ╠═1c12c9d0-7caa-11eb-1f0d-1da3b950b1cb
# ╠═3a6b8870-7cb6-11eb-1c52-534bb2a82792
# ╠═a12b5af0-7cb5-11eb-1e4c-25a6ab392010
# ╠═b7be1a30-7cc6-11eb-285a-090e236cb806
# ╠═1fc82880-7cdd-11eb-1402-e323fcd04224
# ╠═36e133ee-7cdc-11eb-253b-fd1e05b39dba
# ╠═75ca0000-7ca6-11eb-2812-3f4ee8f7b544
# ╠═108cadd0-7cb2-11eb-2765-db5c2ac1e9f9
# ╠═dca464f0-7cdd-11eb-24cc-e9f37f0e0b1f
