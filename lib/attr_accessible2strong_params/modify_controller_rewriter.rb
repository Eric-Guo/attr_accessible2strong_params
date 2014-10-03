class ModifyControllerRewriter < Parser::Rewriter
  def initialize(model_class_name, model_fields)
    @model_class_name = model_class_name
    @model_fields = model_fields
    super()
  end

  def on_class(node)
    if node.children.count == 3 and node.children[1].children[1] == :ApplicationController \
      and node.children[2].begin_type? == true then
      insert_after node.children[2].loc.expression.end, <<-END

  private
    # Only allow a trusted parameter "white list" through.
    def #{@model_class_name.underscore}_params
      params.require(:#{@model_class_name.underscore}).permit(#{@model_fields.collect {|s| ":#{s}"}.join ", "})
    end
END
    end
    super
  end

  def on_send(node)
    if node.children.count == 3 and node.children[1] == :[] \
      and node.children[0].children[1] == :params and node.children[2].sym_type? \
      and node.children[2].children[0].to_s == @model_class_name.underscore then
      replace node.loc.expression, "#{@model_class_name.underscore}_params"
    end
    super
  end
end