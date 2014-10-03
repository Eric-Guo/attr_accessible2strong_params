require 'astrolabe/builder'
require 'parser/current'
require 'unparser'

class AttrAccessible2StrongParams::Converter
  def read_attr_accessible(filename)
    root_node, comments = parse_file_with_comments(filename)
    aa_nodes = root_node.each_node(:send).select {|n| n.children[1] == :attr_accessible}
    aa_fields = []
    aa_nodes.each do |m|
      @model_class_name = m.parent.parent.children[0].children[1]
      aa_fields <<= m.each_node(:sym).collect {|n| n.children[0]}
    end
    @model_fields = aa_fields.flatten
  end

  def write_controller_with_strong_params(filename)
    root_node, comments = parse_file_with_comments(filename)
    rewritten = Unparser.unparse(root_node, comments)
    temp_path = "#{filename}.rewritten"
    File.open(temp_path, 'w') do |temp_file|
      temp_file.write(rewritten)
      temp_file.puts unless rewritten.end_with?(?\n)
    end
    File.rename(temp_path, filename)
  end

private
  def parse_file_with_comments(filename)
    parser = Parser::CurrentRuby.new(Astrolabe::Builder.new)
    buffer = Parser::Source::Buffer.new(filename)
    buffer.source = File.read(filename)
    parser.parse_with_comments(buffer)
  end
end
