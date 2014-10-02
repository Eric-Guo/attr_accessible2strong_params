require 'astrolabe/builder'
require 'parser/current'

class AttrAccessible2StrongParams::Converter
  def read_attr_accessible(filename)
    buffer = Parser::Source::Buffer.new(filename)
    buffer.source = File.read(filename)

    builder = Astrolabe::Builder.new
    parser = Parser::CurrentRuby.new(builder)

    root_node = parser.parse(buffer)
    m = root_node.each_node(:send).select {|n| n.children[1] == :attr_accessible}.first
    @aa = m.each_node(:sym).collect {|n| n.children[0]}
  end
end
