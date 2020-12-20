class Offer < ApplicationRecord
  validates :code, :affiliate_url, presence: true
  validates :code, :affiliate_url, uniqueness: { case_sensitive: false }
  validates :code, length: { maximum: 256 }

  has_many :pages, dependent: :delete_all
end
