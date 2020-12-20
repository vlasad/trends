class Banner < ApplicationRecord
  validates :banner_type, :code, presence: true
  validates :code, uniqueness: { case_sensitive: false }
  validates :code, length: { maximum: 16 }
  validates :views, :clicks, numericality: { greater_than_or_equal_to: 0 }
  validates :banner_type_id, uniqueness: { scope: :page_id, message: "should be one per page" }

  belongs_to :banner_type
  belongs_to :page

  serialize :data
end
