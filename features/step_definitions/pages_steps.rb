Then /^(?:|I )should can visit each of base pages$/ do
  # Should be screened out by parent_id later
  base_pages = Page.visible.without(:slug, :index)
  base_pages.each do |base_page|
    step %Q(I follow "#{base_page.name}")
    current_path.sub('/', '').should == base_page.slug
    # Confirm that the page will display
    step %Q(I should see "Projects")
  end
end
