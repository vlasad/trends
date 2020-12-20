class Page < ApplicationRecord
  belongs_to :category
  belongs_to :offer
  belongs_to :custom_banner
end
