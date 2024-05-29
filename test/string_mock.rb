class StringMock
	def self.add_string_with_empty(input)
		return 1 if input == '1'

		return 6 if input == '1,5'

		return input.length
	end
end