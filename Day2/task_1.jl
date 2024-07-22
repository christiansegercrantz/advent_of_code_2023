using DelimitedFiles

function parse_string(raw_string)::Dict
	non_game_string = split(raw_string, ":")[end]
	array = split(non_game_string, ";")
	return string_to_dict(array)
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
		# if !haskey(max_allowed, key)
		#     return false
		# end
		possible = value <= max_allowed[key] && possible
	end
	return possible
end

function main(data)

	sum = 0

	for raw_string in data
		max_allowed = Dict{String, Integer}("red" => 12, "green" => 13, "blue" => 14)

		game_id = parse_game_id(raw_string)

		input = parse_string(raw_string)

		if check_if_possible(input, max_allowed)
			sum += game_id
		end
	end

	println("Sum: ", sum)

end

data = readdlm("./Day2/input.csv", '\n')

main(data)