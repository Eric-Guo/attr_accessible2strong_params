class AttrAccessible2StrongParams
  def self.convert
    t = Converter.new
    t.convert
  end
end

require 'attr_accessible2strong_params/converter'
require 'attr_accessible2strong_params/version'
