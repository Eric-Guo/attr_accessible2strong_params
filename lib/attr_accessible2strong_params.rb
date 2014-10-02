class AttrAccessible2StrongParams
  def self.hi(language)
    translator = Translator.new(language)
    translator.hi
  end
end

require 'attr_accessible2strong_params/translator'
require 'attr_accessible2strong_params/version'
