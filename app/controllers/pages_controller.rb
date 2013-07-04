class PagesController < ApplicationController
  layout :layout
  before_filter :menu_main

  def show
    @page = Page.find_by_slug(params[:slug]) || Page.find(params[:slug])
    render params[:slug] if controller_view_exists?(params[:slug])
  end

  def menu_main
    @page = Page.find_by_slug(params['slug'])
    if @page
      @top_menu = @page.root.siblings.visible
      @middle_menu = @page.ancestors.visible
      @bottom_menu = @page.children.visible
      @main_menu = @page.siblings.visible
    end
  end

  private

  def view_exists?(view)
    File.exists? Rails.root.join("app", "views", view)
  end

  def controller_view_exists?(name)
    view_exists?("#{params[:controller]}/#{name}.html.erb")
  end

  def layout_exists?(name)
    view_exists?("layouts/#{name}.html.erb")
  end

  def layout
    main_layout = 'application'
    if @page && @page.layout != main_layout && layout_exists?(@page.layout)
      @page.layout
    else
      main_layout
    end
  end

end
