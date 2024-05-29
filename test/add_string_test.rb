require 'test_helper'
require 'string_mock'

class AddStringTest < ActiveSupport::TestCase

	test 'output shoule be 0 while input empty' do
		assert_equal 0, StringMock.add('')
	end

	test 'output should 1 while input was 1' do
		assert_equal 1, StringMock.add('1')
	end

	test 'output should be sum of the given input if the given string has two value' do
		assert_equal 6, StringMock.add('1,5')
	end

	test 'should throw the error if the given number was negative' do
		assert_equal "negative numbers not allowed -10", StringMock.add('-10')
	end
end