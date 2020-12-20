class Category < ApplicationRecord
  validates :code, presence: true
  validates :code, uniqueness: { case_sensitive: false }
  validates :code, length: { maximum: 128 }

  has_many :pages, dependent: :delete_all
end
