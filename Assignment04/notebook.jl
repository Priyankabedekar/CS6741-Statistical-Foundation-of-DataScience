### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ c8091590-ac03-11eb-2b7b-1b8ac83f3a40
begin
	using Distributions
	using StatsBase
	using Plots
	using Statistics
	using StatsPlots
	using QuadGK
	plotly()
end

# ╔═╡ 339ee280-abf5-11eb-1c8e-659adb6c81ef
md" ## Assignment 04"

# ╔═╡ 40ebc5b0-abf6-11eb-2e9f-ab97e7c8176a
md"#### Question 01"

# ╔═╡ 5cccfbde-ad87-11eb-1386-130ad89463bc
coin = DiscreteUniform()

# ╔═╡ 8df6e86e-ada5-11eb-2e06-572af97264f7
md"(a)"

# ╔═╡ 9ef0d560-abf6-11eb-0c0a-bf16c336085a
begin
	k = 100000
	count = 0
	for _ in (1:k)
		if sum(rand(coin, 50)) >= 30
			count += 1
		end
	end
end

# ╔═╡ 30b259d0-ac09-11eb-3882-eb41df06a764
count/k

# ╔═╡ a21f2010-ada5-11eb-3ca3-e3edc62ef78d
md"(b)"

# ╔═╡ 16c4aa90-ac0a-11eb-380a-e53a20ffb4c2
begin
	c = 0
	for i in (30:50)
		c += binomial(50,i) * (1/2^50)
	end 
	c
end

# ╔═╡ ae678100-ada5-11eb-2f64-d90e9b801115
md"(c)"

# ╔═╡ 8189f310-ada6-11eb-3246-2d73fbc69aa6
begin
	D = Normal(50*0.5, 0.5 * sqrt(50))
	1 - cdf(D,29.5)
end

# ╔═╡ 59203a00-ada7-11eb-240b-67b3bc7ba441
Z_score = (29.5 - 25 )/(0.5 * sqrt(50))

# ╔═╡ 6f377f50-b037-11eb-051d-15f2321cdeba
ccdf(Normal(0,1),Z_score)

# ╔═╡ 072bdfd0-adaf-11eb-2e59-c33898eed46b
md"#### Question 02"

# ╔═╡ 21d63fce-b055-11eb-3152-ff447ee5542e
md"Calculate required probability of heads"

# ╔═╡ 9eeb9750-ae3d-11eb-194a-076961eb4708
begin
	p = 0.5
	n = 50
	while true
		m = n*p
		sig = sqrt(n * p * (1-p))
		Biased_Coin = Normal(m, sig)
		prob = 1 - cdf(Biased_Coin, 29.5)
		if prob >= 0.5
			break
		end
		p = p + 0.001
	end
	p
end

# ╔═╡ 40dc9a00-b055-11eb-2583-cd7401ead87c
md"(b)"

# ╔═╡ 5cce3fe0-ae41-11eb-3250-e131eed5c49e
begin
	k1 = 100000
	count1 = 0
	for _ in (1:k1)
		if sum(rand(Bernoulli(0.59), 50)) >= 30
			count1 += 1
		end
	end
	count1/k1
end

# ╔═╡ 74864f3e-b055-11eb-1a77-7162d01a1b77
md"(c)"

# ╔═╡ d0800ede-ae42-11eb-1c55-05596d17c875
begin
	T = Binomial(50,0.59)
	1 - cdf(T, 29)
end

# ╔═╡ 89edd8f0-b03a-11eb-36c5-ef38c7aae6bd
begin
	c1 = 0
	for k in (30:50)
		c1 += binomial(50,k) * (0.59)^k * (0.41)^(50-k)
	end 
	c1
end

# ╔═╡ bdf68140-aff1-11eb-293d-536f2e8aa47a
md"#### Question 03"

# ╔═╡ f8a129a0-b017-11eb-07a0-035df2e189c4
function Space_suit(mu, sig)
	n = 1
	while true
		flag = (3000 - (mu * n))/ (sig * sqrt(n))
		if ccdf(Normal(0,1), flag) >= 0.95
			break
		end
		n = n + 1
    end
	return n
end

# ╔═╡ 4fdfde90-b03c-11eb-0d1b-47e0dbb61bb7
Space_suit(100,30)

# ╔═╡ 7565a690-ae43-11eb-23ee-4f0baf324ac5
md"#### Question 04"

# ╔═╡ ff6898d0-afd2-11eb-302f-c1e837f49245
function Q4(Dist, p)
	n = 2
	k = 1000
	C = zeros(k)
	D1 = zeros(k)
	if Dist == "Uniform"
		D = Uniform(0,1)
	end
	if Dist == "Binomial"
		D = Binomial(100,p)
	end
	if Dist == "Chisquare"
		D = Chisq(p)
	end
	while true
		D11 = rand(D,(k,n))
		mean_ = mean(D)
		std_ = std(D)
		D1 = mean(D11, dims = 2)
		C = (D1 .-  mean_) ./ (std_/ sqrt(n))
		if abs(skewness(C)) < 0.1 
			if abs(kurtosis(C)) < 0.1 
				break
			end
		end
		n = n + 1
	end
	
	return n
end

# ╔═╡ 85100360-b055-11eb-104a-61c99e990587
md"(a)"

# ╔═╡ f163fbc0-b03c-11eb-22c7-5705e5b2dd9f
begin
	result2 = zeros(10000)
	for i in 1:10000
		result2[i]  = Q4("Uniform", 0.5) 
	end
	mean(result2)
end

# ╔═╡ 8d483340-b055-11eb-0899-43ab16016341
md"(b)"

# ╔═╡ 28d94330-af25-11eb-3663-112bfb07e088
begin
	result = zeros(10000)
	for i in 1:10000
		result[i]  = Q4("Binomial", 0.01) 
	end
	mean(result)
end

# ╔═╡ 91efc250-b055-11eb-087a-952eed3f3b9d
md"(c)"

# ╔═╡ cb801fb0-b03c-11eb-1353-b9d0fba47511
begin
	result1 = zeros(10000)
	for i in 1:10000
		result1[i]  = Q4("Binomial", 0.5) 
	end
	mean(result1)
end

# ╔═╡ 958aea72-b055-11eb-161f-2d5ecb885548
md"(d)"

# ╔═╡ 02fbc480-b03d-11eb-28c6-050dd6fe1e6d
begin
	result3 = zeros(10000)
	for i in 1:10000
		result3[i]  = Q4("Chisquare", 3) 
	end
	mean(result3)
end

# ╔═╡ 57fa26d0-afe7-11eb-1c2d-33e4e216d685
md"#### Question 05"

# ╔═╡ ca0b81ae-afe7-11eb-129a-ab80ab3aaaad
function Q5()
	D5 = Chisq(99)
	sig = 1
	while true
		if ccdf(D5, 5*99/sig) >= 0.1
			break
		end
		sig = sig + 0.01
	end
	return sig
end

# ╔═╡ ab1d4b1e-b02e-11eb-171e-e5700ba240c0
Max_variance = Q5()

# ╔═╡ Cell order:
# ╟─339ee280-abf5-11eb-1c8e-659adb6c81ef
# ╟─40ebc5b0-abf6-11eb-2e9f-ab97e7c8176a
# ╠═c8091590-ac03-11eb-2b7b-1b8ac83f3a40
# ╠═5cccfbde-ad87-11eb-1386-130ad89463bc
# ╟─8df6e86e-ada5-11eb-2e06-572af97264f7
# ╠═9ef0d560-abf6-11eb-0c0a-bf16c336085a
# ╠═30b259d0-ac09-11eb-3882-eb41df06a764
# ╟─a21f2010-ada5-11eb-3ca3-e3edc62ef78d
# ╟─16c4aa90-ac0a-11eb-380a-e53a20ffb4c2
# ╟─ae678100-ada5-11eb-2f64-d90e9b801115
# ╠═8189f310-ada6-11eb-3246-2d73fbc69aa6
# ╠═59203a00-ada7-11eb-240b-67b3bc7ba441
# ╠═6f377f50-b037-11eb-051d-15f2321cdeba
# ╟─072bdfd0-adaf-11eb-2e59-c33898eed46b
# ╟─21d63fce-b055-11eb-3152-ff447ee5542e
# ╠═9eeb9750-ae3d-11eb-194a-076961eb4708
# ╟─40dc9a00-b055-11eb-2583-cd7401ead87c
# ╠═5cce3fe0-ae41-11eb-3250-e131eed5c49e
# ╟─74864f3e-b055-11eb-1a77-7162d01a1b77
# ╠═d0800ede-ae42-11eb-1c55-05596d17c875
# ╠═89edd8f0-b03a-11eb-36c5-ef38c7aae6bd
# ╟─bdf68140-aff1-11eb-293d-536f2e8aa47a
# ╠═f8a129a0-b017-11eb-07a0-035df2e189c4
# ╠═4fdfde90-b03c-11eb-0d1b-47e0dbb61bb7
# ╟─7565a690-ae43-11eb-23ee-4f0baf324ac5
# ╠═ff6898d0-afd2-11eb-302f-c1e837f49245
# ╟─85100360-b055-11eb-104a-61c99e990587
# ╠═f163fbc0-b03c-11eb-22c7-5705e5b2dd9f
# ╟─8d483340-b055-11eb-0899-43ab16016341
# ╠═28d94330-af25-11eb-3663-112bfb07e088
# ╟─91efc250-b055-11eb-087a-952eed3f3b9d
# ╠═cb801fb0-b03c-11eb-1353-b9d0fba47511
# ╟─958aea72-b055-11eb-161f-2d5ecb885548
# ╠═02fbc480-b03d-11eb-28c6-050dd6fe1e6d
# ╟─57fa26d0-afe7-11eb-1c2d-33e4e216d685
# ╠═ca0b81ae-afe7-11eb-129a-ab80ab3aaaad
# ╟─ab1d4b1e-b02e-11eb-171e-e5700ba240c0
