module DropinFormBuilder
  def dropin_file_field(method, options={})
    @template.builder_dropin_file_field_tag method, self, options
  end
end
