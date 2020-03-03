class Purchase < ApplicationRecord
  belongs_to :user
  has_many :purchaselists
  has_many :purchaseaddons, through: :purchaselists, source: :item
end
