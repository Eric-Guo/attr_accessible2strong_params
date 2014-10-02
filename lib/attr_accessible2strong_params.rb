class AttrAccessible2StrongParams
  def self.convert(filename)
    t = Converter.new
    t.convert filename
  end
end

require 'attr_accessible2strong_params/converter'
require 'attr_accessible2strong_params/version'
