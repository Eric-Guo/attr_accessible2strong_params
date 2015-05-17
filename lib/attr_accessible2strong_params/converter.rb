require 'astrolabe/builder'

class AttrAccessible2StrongParams::Converter
  attr_reader :model_fields

  def read_attr_accessible(filename)
    @model_file_name = filename
    root_node, comments, buffer = parse_file_with_comments(filename)
    aa_nodes = root_node.each_node(:send).select { |n| n.children[1] == :attr_accessible }
    aa_fields = []
    aa_nodes.each do |m|
      @model_class_name = m.parent.parent.children[0].children[1].to_s
      aa_fields <<= m.each_node(:sym).collect { |n| n.children[0] }
    end
    @model_fields = aa_fields.flatten
  end

  def remove_attr_accessible_from_model(filename, no_rename = false)
    root_node, comments, buffer = parse_file_with_comments(filename)
    no_aa_src_buffer = Parser::Source::Buffer.new('(string)')
    rewritten_src = RemoveAttrAccessibleRewriter.new.rewrite(buffer, root_node)
    write_file_with_comments(filename, rewritten_src, no_rename)
  end

  def write_controller_with_strong_params(filename = nil, no_rename = false)
    filename = "#{File.dirname @model_file_name}/../controllers/#{@model_class_name.pluralize.underscore}_controller.rb" if filename.nil?
    return unless File.exist? filename
    root_node, comments, buffer = parse_file_with_comments(filename)
    source = ModifyControllerRewriter.new(@model_class_name, @model_fields).rewrite(buffer, root_node)
    write_file_with_comments(filename, source, no_rename)
  end

  private

  def parse_file_with_comments(filename)
    parser = Parser::CurrentRuby.new(Astrolabe::Builder.new)
    buffer = Parser::Source::Buffer.new(filename)
    buffer.source = File.read(filename)
    root_node, comments = parser.parse_with_comments(buffer)
    [root_node, comments, buffer]
  end

  def write_file_with_comments(filename, source_code, no_rename)
    temp_path = "#{filename}.rb"
    File.open(temp_path, 'w') do |temp_file|
      temp_file.write(source_code)
      temp_file.puts unless source_code.end_with?(?\n)
    end

    return 0 if no_rename
    File.rename(temp_path, filename)
  end
end
