module PageHelper

  def menu_item_state(page)
    slug = params[:slug]
    if page.slug == slug || page.children.find{|p| p.slug == slug }
      'current'
    end
  end

end
