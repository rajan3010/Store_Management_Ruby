class Item < ApplicationRecord

  has_one_attached :thumbnail
  belongs_to :user
  has_many :carts
  has_many :added_items, through: :carts, source: :user
  has_many :user_purchases, through: :purchaselists, source: :purchase

  BRAND = %w{Apple Alphabet Bose Caterpillar Duke Epsilon Ford Gucci Hope Island Jockey Samsung}

  CATEGORY = %w{ Electronics Gaming Books Apparel Machinery Watches }

  TAX = %w{One Two Three}
end
