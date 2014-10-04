require 'find'
require 'active_support/core_ext/object'
require 'active_support/inflector'

class AttrAccessible2StrongParams
  def self.convert(file_or_dir)
    @files = []
    file_or_dir ||= '.'
    if File.directory?(file_or_dir)
      Find.find("#{file_or_dir}/app/models/") do |path|
        next if path.end_with? '.rb.rb'
        @files << path if path.end_with? '.rb'
      end
    else
      @files << file_or_dir if File.exist? file_or_dir
    end
  end
end

require 'parser/current'
require 'attr_accessible2strong_params/remove_attr_accessible_rewriter'
require 'attr_accessible2strong_params/modify_controller_rewriter'
require 'attr_accessible2strong_params/converter'
require 'attr_accessible2strong_params/version'
