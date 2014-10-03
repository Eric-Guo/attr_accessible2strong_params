class ModifyControllerRewriter < Parser::Rewriter
  def initialize(model_class_name, model_fields)
    @model_class_name = model_class_name
    @model_fields = model_fields
    super()
  end

  def on_class(node)
    if node.children[1].children[1] == :ApplicationController \
      and node.children[2].begin_type? == true
      insert_after node.children[2].loc.expression.end, <<-END

  private
    # Only allow a trusted parameter "white list" through.
    def #{@model_class_name.underscore}_params
      params.require(:#{@model_class_name.underscore}).permit(#{@model_fields.collect {|s| ":#{s}"}.join ", "})
    end
END
    end
  end
end