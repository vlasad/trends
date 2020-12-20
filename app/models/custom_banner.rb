class CustomBanner < ApplicationRecord
  validates :banner, :code, presence: true
  validates :code, uniqueness: { case_sensitive: false }
  validates :code, length: { maximum: 16 }
  validates :views, :clicks, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :banner

  serialize :data
end
