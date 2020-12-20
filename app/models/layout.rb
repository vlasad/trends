class Layout < ApplicationRecord
  validates :file_name, presence: true
  validates :file_name, uniqueness: { case_sensitive: false }
end
