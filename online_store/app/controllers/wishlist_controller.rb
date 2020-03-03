class WishlistController < ApplicationController
  before_action :authenticate_user!
  def index
    @wish_list = current_user.carts.where( iswishlist?:true )
    @wish_items=Item.find(@wish_list.pluck(:item_id))
  end
end
