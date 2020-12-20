class Page < ApplicationRecord
  validates :category, :offer, :custom_banner, :layout, :code, :content_url, :title presence: true
  validates :code, uniqueness: { case_sensitive: false }

  belongs_to :category
  belongs_to :offer
  belongs_to :custom_banner
  belongs_to :layout
end
