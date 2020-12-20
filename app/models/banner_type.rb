class BannerType < ApplicationRecord
  validates :file_name, presence: true
  validates :file_name, uniqueness: { case_sensitive: false }
  validates :views, :clicks, numericality: { greater_than_or_equal_to: 0 }

  has_many :banners, dependent: :delete_all
end
