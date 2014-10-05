require 'find'
require 'active_support/core_ext/object'
require 'active_support/inflector'

class AttrAccessible2StrongParams
  def self.convert(file_or_dir, no_rename = false)
    @files = []
    if file_or_dir.nil? or not File.exist?(file_or_dir)
      puts 'aa2sp [filename OR dirname]'
      return
    end
    if File.directory?(file_or_dir)
      Find.find("#{file_or_dir}/app/models/") do |path|
        next if path.end_with? '.rb.rb'
        @files << path if path.end_with? '.rb'
      end
    else
      @files << file_or_dir if File.exist? file_or_dir
    end
    @files.each do |filename|
      c = AttrAccessible2StrongParams::Converter.new
      next if c.read_attr_accessible(filename).blank?
      print(filename, ' found:', c.model_fields)
      c.remove_attr_accessible_from_model(filename, no_rename)
      c.write_controller_with_strong_params(nil, no_rename)
      puts
    end
  end
end

require 'parser/current'
require 'attr_accessible2strong_params/remove_attr_accessible_rewriter'
require 'attr_accessible2strong_params/modify_controller_rewriter'
require 'attr_accessible2strong_params/converter'
require 'attr_accessible2strong_params/version'
