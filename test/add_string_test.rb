require 'test_helper'
require 'string_mock'

class AddStringTest < ActiveSupport::TestCase

	test 'output shoule be 0 while input empty' do
		assert_equal 0, StringMock.add_string_with_empty('')
	end
end