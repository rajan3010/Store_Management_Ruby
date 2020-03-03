class PurchaselistController < ApplicationController

  def index
  end

  def show
    @@purchase_id=purchase_params
    @purchase=Purchase.find(@@purchase_id)
    @purchase_list=@purchase.purchaselists
    @purchase_items=Item.find(@purchase_list.pluck(:item_id))
  end

  def return_update
    item_id=params.require(:id)
    @purchase=Purchase.find(@@purchase_id)
    @purchase_list=@purchase.purchaselists
    @status=@purchase_list.where(item_id: item_id).update(:ispending? => true)
    redirect_to root_path
  end

  def approve_request
    item_id=params.require(:id)
    @purchase=Purchase.find(@@purchase_id)
    @purchase_list=@purchase.purchaselists
    @status=@purchase_list.where(item_id: item_id).update(:ispending? => false)
    redirect_to root_path
  end
  def purchase_params
    params.require(:id)
  end
end
