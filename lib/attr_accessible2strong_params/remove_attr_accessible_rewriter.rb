require 'parser/current'

class RemoveAttrAccessibleRewriter < Parser::Rewriter
  def on_send(node)
    # Check if the statement starts with "do"
    if node.children[1] == :attr_accessible
      remove(node.loc.expression)
    end
  end
end