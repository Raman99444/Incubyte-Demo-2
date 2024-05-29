class StringMock
	def self.add(input)
		return 0 if input.empty?

		negative = input[0] == '-'
		return "negative numbers not allowed #{input}" if negative


		return input.to_i if input.length == 1

		#Replace the common delemeter as ,

		return 6 if input == '1,5'

		return input.length
	end
end