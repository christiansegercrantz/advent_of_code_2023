using DelimitedFiles



function parse_digits(txt, include_char_digits = false)::String
	pat = !include_char_digits ? r"(\d)" : r"(\d|one|two|three|four|five|six|seven|eight|nine)"
	numbers = [match.match for match in eachmatch(pat, txt, overlap = true)]
	return first(numbers) * last(numbers)
end

function replace_string_with_integers(txt)::String
	return replace.(txt, Pair("one", 1), Pair("two", 2), Pair("three", 3), Pair("four", 4), Pair("five", 5), Pair("six", 6), Pair("seven", 7), Pair("eight", 8), Pair("nine", 9))
end

function main()
	array_txt = readdlm("./Day1/input.csv")

	# array_txt = split(long_txt, "\n")
	sum = 0

	for row in array_txt
		if row isa Number
			row = string(row)
		end
		print(row * " --> ")
		digits = parse_digits(row, true)
		print(digits * " --> ")
		replaced_string = replace_string_with_integers(digits)
		println(replaced_string)
		sum += parse(Int, replaced_string)
	end

	println("Sum: " * string(sum))
end

main()

