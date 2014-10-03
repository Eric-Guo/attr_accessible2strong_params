require 'active_support/inflector'

class AttrAccessible2StrongParams
  def self.convert(filename)
    t = Converter.new
    t.read_attr_accessible filename
  end
end

require 'attr_accessible2strong_params/remove_attr_accessible_rewriter'
require 'attr_accessible2strong_params/converter'
require 'attr_accessible2strong_params/version'
