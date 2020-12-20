class Banner < ApplicationRecord
  validates :banner_type, :code, presence: true
  validates :code, uniqueness: { case_sensitive: false }
  validates :code, length: { maximum: 16 }
  validates :views, :clicks, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :banner_type
  belongs_to :page

  serialize :data
end
