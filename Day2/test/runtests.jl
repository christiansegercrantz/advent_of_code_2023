# test/runtests.jl
push!(LOAD_PATH, "Day2")

using Day2
using Test

@testset "get_product_of_balls" begin
	@test Day2.get_product_of_balls(Dict("blue" => 2, "red" => 5, "green" => 3)) == 30
end

@testset "get_least_amount_of_balls" begin
	input = "Game 1: 1 green, 2 blue, 3 red; 3 green, 2 blue, 1 red; 3 green, 1 blue, 3 red;"
	@test get_least_amount_of_balls() == Dict("blue" => 1, "red" => 1, "green" => 1)
    
end
