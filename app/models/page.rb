class Page < ActiveRecord::Base
  attr_accessible :slug, :hidden, :seo_id, :seo_attributes, :layout,
                  :translations_attributes, :translations, :parent_id

  belongs_to :seo
  has_ancestry

  accepts_nested_attributes_for :seo, :allow_destroy => true, :reject_if => :all_blank
  validates :slug, presence: true, uniqueness: true

  translates :content, :name
  accepts_nested_attributes_for :translations
  validates :name, presence: true

  # Зачем это здесь?
  class Translation
    validates :name, presence: true
  end

  extend FriendlyId
  friendly_id :slug

  scope :visible, -> { where(hidden: false) }
  scope :invisible, -> { where(hidden: true) }
  scope :without, (lambda do |field, values|
    raise "Unknown field :#{field} in Box model" unless field.to_s.in? attribute_names
    values = [values] unless values.is_a? Array
    where("#{field} NOT IN (?)", values)
  end)
end
