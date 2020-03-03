module ItemsHelper

  def user_added_to_cart? user, item
    user.carts.where(user: user, item: item, iscart?: true).any?
  end

  def user_added_to_wish? user,item
    user.carts.where(user: user, item: item, iswishlist?: true).any?
  end


  def total_cost user
    @cart_list = user.carts.where(user: user, iscart?: true)
    @cart_items = Item.find(@cart_list.pluck(:item_id))

    total_price = 0
    @cart_items.each do |item|
      if item.tax_slab == "one"
        tax = 0.1
      elsif item.tax_slab == "two"
        tax = 0.15
      elsif item.tax_slab == "three"
        tax = 0.2
      else
        tax = 0.05
      end
      total_price = total_price + item.cost*(1 + tax)
    end

    #if user.age >= 65
    #total_price=total_price*0.9
    #end

    return total_price.round(2)
  end


  def total_cost_item item
    if item.tax_slab == "one"
      tax=0.1
    elsif item.tax_slab == "two"
      tax =0.15
    elsif item.tax_slab=="three"
      tax=0.2
    else
      tax=0.05

    end
    total_price=item.cost*(1+tax)
    return total_price.round(2)
  end

  def user_pending? user
    @purchases=user.purchases
    @purchases.each do |f|
      @purchase_lists=f.purchaselists
      @purchase_lists.each do |k|
        if k.ispending?
          return true
        end
      end
    end
    return false
  end

  def purchase_pending? purchase
    @purchase_lists=purchase.purchaselists
    @purchase_lists.each do |f|
        if f.ispending?
          return true
        end
    end
    return false
    end
end
