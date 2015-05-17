class RemoveAttrAccessibleRewriter < Parser::Rewriter
  def on_send(node)
    remove(node.loc.expression) if node.children[1] == :attr_accessible
    super
  end
end
