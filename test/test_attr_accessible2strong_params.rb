require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'attr_accessible2strong_params'

class AttrAccessible2StrongParamsTest < MiniTest::Test
  def test_read_model_attr_accessible_sym_list
    c = AttrAccessible2StrongParams::Converter.new
    assert_equal [:create_badge, :create_shift_code, :in_time, :out_time, :profile_check, :update_badge, :update_shift_code] \
      , c.read_attr_accessible('test/example_model.rb')
  end

  def test_remove_attr_accessible_from_model
    c = AttrAccessible2StrongParams::Converter.new
    assert_equal 0, c.remove_attr_accessible_from_model('test/example_model.rb', true)
  end

  def test_write_controller_src
    c = AttrAccessible2StrongParams::Converter.new
    c.read_attr_accessible('test/example_model.rb')
    assert_equal 0, c.write_controller_with_strong_params('test/example_controller.rb', true)
  end
end
