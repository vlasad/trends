class Page < ApplicationRecord
  validates :category, :offer, :code, :content_url, :title presence: true
  validates :code, uniqueness: { case_sensitive: false }

  belongs_to :category
  belongs_to :offer
  has_many :banners
end
