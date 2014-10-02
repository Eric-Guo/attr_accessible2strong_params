require 'astrolabe/builder'
require 'parser/current'

class AttrAccessible2StrongParams::Converter
  def convert(filename)
    buffer = Parser::Source::Buffer.new(filename)
    buffer.source = File.read(filename)

    builder = Astrolabe::Builder.new
    parser = Parser::CurrentRuby.new(builder)

    root_node = parser.parse(buffer)
    p root_node
    root_node.class.to_s # => Astrolabe::Node
  end
end
