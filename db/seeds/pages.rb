#coding: utf-8

Page.reset_column_information
[:index, :contacts].each_with_index do |slug, index|
  FactoryGirl.create(:page, slug: slug, position: index + 1)
end
