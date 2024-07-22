using DelimitedFiles

function main(data)

	sum = 0

	for raw_string in data
		max_allowed = Dict{String, Integer}("red" => 12, "green" => 13, "blue" => 14)
		if parse_game_id(raw_string) == 100
			1 + 1
		end

		arr_of_strings = parse_string(raw_string)

		input = string_to_dict(arr_of_strings)

		sum += get_product_of_balls(input)

	end

	println("Sum: ", sum)

end

function parse_string(raw_string)
	non_game_string = split(raw_string, ":")[end]
	return split(non_game_string, ";")
end

function parse_game_id(raw_string)::Integer
	pattern = r"Game (\d+):"
	m = match(pattern, raw_string)
	return parse(Int32, m.captures[1])
end

function string_to_dict(arr_of_strs::Array)::Dict
	pat = r"(\d+) (\D+)"
	col_to_value = Dict{String, Integer}()
	for str in arr_of_strs
		for pair in split(str, ",")
			m = match(pat, pair)
			key = m.captures[2]
			value = parse(Int32, m.captures[1])
			if (!haskey(col_to_value, key) || col_to_value[key] < value)
				col_to_value[key] = value
			end
		end
	end
	return col_to_value
end

function check_if_possible(input::Dict, max_allowed::Dict)::Bool
	possible::Bool = true
	for (key, value) in input
		possible = value <= max_allowed[key] && possible
	end
	return possible
end

function get_product_of_balls(dict::Dict)
	return reduce(*, values(dict))
end

data = readdlm("./Day2/input.csv", '\n')

main(data)

using Test

@testset "get_product_of_balls" begin
	@test get_product_of_balls(Dict("blue" => 2, "red" => 5, "green" => 3)) == 30
end

@testset "string_to_dict" begin
	input = ["1 green, 2 blue", "3 red", "3 green, 2 blue, 1 red", "1 green, 3 blue, 1 red"]
	@test string_to_dict(input) == Dict("blue" => 3, "red" => 3, "green" => 3)
	@test string_to_dict(["3 blue, 4 red", "1 red, 2 green, 6 blue", "2 green"]) == Dict("blue" => 6, "red" => 4, "green" => 2)
end

@testset "string_to_dict + get_product_of_balls" begin
	@test get_product_of_balls(string_to_dict(["3 blue, 4 red", "1 red, 2 green, 6 blue", "2 green"])) == 48
	@test get_product_of_balls(string_to_dict(["1 blue, 2 green", "3 green, 4 blue, 1 red", "1 green, 1 blue"])) == 12
	@test get_product_of_balls(string_to_dict(["8 green, 6 blue, 20 red", "5 blue, 4 red, 13 green", " 5 green, 1 red"])) == 1560
	@test get_product_of_balls(string_to_dict(["1 green, 3 red, 6 blue", "3 green, 6 red", "3 green, 15 blue, 14 red"])) == 630
	@test get_product_of_balls(string_to_dict(["6 red, 1 blue, 3 green", "2 blue, 1 red, 2 green"])) == 36
end