require 'coveralls'
Coveralls.wear!

require 'test/unit'
require 'attr_accessible2strong_params'

class AttrAccessible2StrongParamsTest < Test::Unit::TestCase
  def test_english_hello
    assert_equal "hello world", AttrAccessible2StrongParams.convert
  end
end
