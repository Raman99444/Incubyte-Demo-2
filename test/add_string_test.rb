require 'test_helper'
require 'string_mock'

class AddStringTest < ActiveSupport::TestCase
  setup do
    @mock = StringMock.new
  end

  class EmptyOrNilInputTest < AddStringTest
    test 'should be 0 while input empty' do
      assert_equal 0, @mock.add('')
    end

    test 'should be 0 while input was nil' do
      assert_equal 0, @mock.add(nil)
    end
  end

  class InvalidCharactersTest < AddStringTest
    test 'should be 0 with invalid chars' do
      assert_equal 0, @mock.add(';')
    end

    test 'should return 0 with invalid char sequence' do
      assert_equal 0, @mock.add('a,b,c,d')
    end

    test 'should throw an error if the given string was invalid' do
      error = assert_raises(ArgumentError) do
        @mock.add("1,\n")
      end

      assert_equal "Invalid input string format", error.message
    end

    test 'should throw an error if the given string end with comma' do
      error = assert_raises(ArgumentError) do
        @mock.add("1,2,3,")
      end

      assert_equal "Invalid input string format", error.message
    end
  end

  class ValidNumbersTest < AddStringTest
    test 'output should be 1 while input was 1' do
      assert_equal 1, @mock.add('1')
    end

    test 'output should be sum of the given input if the given string has two values' do
      assert_equal 6, @mock.add('1,5')
    end

    test 'should return the sum of the number even if the given string contains newline character' do
      assert_equal 6, @mock.add("1\n2,3")
    end

    test 'should not include numbers greater than 1000 in the sum' do
      assert_equal 6, @mock.add('1,5,1001,2000')
    end

    test 'should include the number 1000 in the sum' do
      assert_equal 1006, @mock.add('1,5,1000,2000')
    end
  end

  class CustomDelimitersTest < AddStringTest
    test 'should return the correct value with ;' do
      assert_equal 3, @mock.add("//;\n1;2")
    end

    test 'should return the correct value with custom delimiter' do
      assert_equal 6, @mock.add("//***\n1***2***3")
    end

    test 'should return the correct value with delimiter within []' do
      assert_equal 6, @mock.add("//[***]\n1***2***3")
    end

    test 'should return the correct value with multiple delimiters' do
      assert_equal 6, @mock.add("//[*][%]\n1*2%3")
    end
  end

  class NegativeNumbersTest < AddStringTest
    test 'should throw an error if the given number is negative' do
      error = assert_raises(ArgumentError) do
        @mock.add('-10')
      end

      assert_equal "negative numbers not allowed -10", error.message
    end

    test 'should return error with all the given negative numbers' do
      error = assert_raises(ArgumentError) do
        @mock.add('-10,90,-20,70,-30')
      end

      assert_equal "negative numbers not allowed -10,-20,-30", error.message
    end
  end
end


