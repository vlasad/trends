class CustomBanner < ApplicationRecord
  belongs_to :banner

  serialize :params
end
