require 'astrolabe/builder'
require 'parser/current'
require 'unparser'

class AttrAccessible2StrongParams::Converter
  def read_attr_accessible(filename)
    buffer = Parser::Source::Buffer.new(filename)
    buffer.source = File.read(filename)

    builder = Astrolabe::Builder.new
    parser = Parser::CurrentRuby.new(builder)

    root_node = parser.parse(buffer)
    m = root_node.each_node(:send).select {|n| n.children[1] == :attr_accessible}.first
    @model_class_name = m.parent.parent.children[0].children[1]
    @aa_list = m.each_node(:sym).collect {|n| n.children[0]}
  end

  def write_controller_with_strong_params(filename)
    ast, comments = Parser::CurrentRuby.parse_with_comments(File.read(filename))
    rewritten = Unparser.unparse(ast, comments)
    temp_path = "#{filename}.rewritten"
    File.open(temp_path, 'w') do |temp_file|
      temp_file.write(rewritten)
      temp_file.puts unless rewritten.end_with?(?\n)
    end
    File.rename(temp_path, filename)
  end
end
