require 'coveralls'
Coveralls.wear!

require 'test/unit'
require 'attr_accessible2strong_params'

class AttrAccessible2StrongParamsTest < Test::Unit::TestCase
  def test_english_hello
    assert_equal "hello world", AttrAccessible2StrongParams.hi("english")
  end

  def test_any_hello
    assert_equal "hello world", AttrAccessible2StrongParams.hi("ruby")
  end

  def test_spanish_hello
    assert_equal "hola mundo", AttrAccessible2StrongParams.hi("spanish")
  end

  def test_korean_hello
    assert_equal "anyoung ha se yo", AttrAccessible2StrongParams.hi("korean")
  end
end
