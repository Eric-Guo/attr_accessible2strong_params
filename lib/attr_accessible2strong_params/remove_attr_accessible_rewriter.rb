class RemoveAttrAccessibleRewriter < Parser::Rewriter
  def on_send(node)
    if node.children[1] == :attr_accessible
      remove(node.loc.expression)
    end
  end
end