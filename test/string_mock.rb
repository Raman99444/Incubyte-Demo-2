class StringMock
	def add(input)
		return 0 if input.nil? || input.empty?

	    raise ArgumentError, "Invalid input string format" if input.end_with?(',', "\n")

		#Replace the common delemeter as
		str_arr = convert_string_to_array(input)

		is_negative = str_arr.select { |val| val < 0 }
		if is_negative.any?
			raise ArgumentError, "negative numbers not allowed #{is_negative.join(',')}"
		end

		str_arr.reject! { |val| val > 1000 }

		return str_arr.inject(:+)
	end

	private

	def convert_string_to_array(s)
		return [] if s.nil? || s.empty?

	  if s.start_with?("//")
	    delimiter, s = s[2..-1].split("\n", 2)
	    delimiter = if delimiter.start_with?('[') && delimiter.end_with?(']')
                      #Regexp.escape(delimiter[1..-2])
                      parse_multiple_delimiters(delimiter)
                    else
                      Regexp.escape(delimiter)
                    end
	  else
	    delimiter = "\n|,"
	  end

	  result = s.split(Regexp.new(delimiter))

	  result.map(&:to_i)
	end

	def parse_multiple_delimiters(delimiter_part)
	    delimiters = delimiter_part.scan(/\[([^\]]+)\]/).flatten
	    delimiters.map { |delim| Regexp.escape(delim) }.join('|')
	  end
end