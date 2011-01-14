class AjaxWillPaginate < WillPaginate::ViewHelpers::LinkRenderer

  private
  #----------------------------------------------------------------------------
  def link(text, target, attributes = {})
    if target.is_a? Fixnum
      attributes[:rel] = rel_value(target)
      target = url(target)
    end
    attributes[:href] = "javascript:void(0)"
    attributes[:"data-link"] = target.sub(/(#{Setting.base_url}\/\w+)\/[^\?]+\?/, "\\1?")
    tag(:a, text, attributes)
  end

end
