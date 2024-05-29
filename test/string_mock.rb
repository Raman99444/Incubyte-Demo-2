class StringMock
	def self.add(input)
		return 0 if input.empty?

		negative = input[0] == '-'
		return "negative numbers not allowed #{input}" if negative

		# given input was single?, then convert and return
		return input.to_i if input.length == 1

		#Replace the common delemeter as
		total = 0
		input.each_char do |chr|
			next if chr == /\d/

			total += chr.to_i
		end

		return total
	end
end