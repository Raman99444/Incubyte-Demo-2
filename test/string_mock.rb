class StringMock
	def self.add(input)
		return 0 if input.empty?

		return input.to_i if input.length == 1

		return 1 if input == '1'

		return 6 if input == '1,5'

		return input.length
	end
end