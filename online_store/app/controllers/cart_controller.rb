class CartController < ApplicationController
  include ItemsHelper
  before_action :authenticate_user!

  def index
    #@cart_items = current_user.cart_additions
    #@wish_list = current_user.carts.where( iswishlist?:true )
    @cart_list = current_user.carts.where(iscart?: true )
    #@wish_user=Cart.users.where(user: current_user, iswishlist?: true)
    #@wish_items=Item.find(@wish_list.pluck(:item_id))
    @cart_items = Item.find(@cart_list.pluck(:item_id))
  end

  def clear_cart
    current_user.carts.where(iscart?: true ).update(:iscart? => false)

    redirect_to cart_index_path, notice: " All items was cleared from your cart"
  end

  def add_purchase

    total_price = total_cost(current_user)
    @purchase= current_user.purchases.create!(:tax_cost =>total_price)

    @cart_list = current_user.carts.where(user: current_user, iscart?: true)
    @cart_items = Item.find(@cart_list.pluck(:item_id))

    @cart_items.each do |item|
      @purchase.purchaseaddons << item
      item.update(quantity: item.quantity - 1)
    end
    current_user.carts.where(iscart?: true ).update(:iscart? => false)
    PurchaseMailer.with(user: current_user,items: @cart_items).purchased_notification.deliver_now
    redirect_to root_path, notice: " Purchase was successful"
  end

  def buy_now
    @item=Item.find(item_id)
    total_price=total_cost_item(@item)
    @purchase=current_user.purchases.create!(:tax_cost =>total_price)
    @purchase.purchaseaddons << @item
    @item.update(quantity: @item.quantity - 1)
    PurchaseMailer.with(user: current_user,items: @item).purchased_notification.deliver_now
    redirect_to root_path, notice: " Purchase was successful"
  end
  def item_id
    params.require(:id)
  end
end
