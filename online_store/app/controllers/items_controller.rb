class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy, :cart, :wishlist]
  before_action :authenticate_user!, :except => [:show, :index]

  # GET /items
  # GET /items.json
  def index
    type = params[:type]
    field = params[:field]

    @items = Item.all.order("updated_at desc")
    if type == "sort"
      @items = Item.all.order("#{field} asc")
    end


  end

  # GET /items/1
  # GET /items/1.json
  def show
    if @item.purchase_count.nil?
      @item.update_column(:purchase_count, 0)
    end
    @item.update_column(:purchase_count, @item.purchase_count + 1)
  end

  # GET /items/new
  def new
    @item = current_user.items.build
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = current_user.items.build(item_params)
    authorize! :read,@item
    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  # add/remove items from cart of current user
  def cart
    type = params[:type]

    if type == "addcart"
      #current_user.cart_additions << @item
      current_user.carts.create!(:item =>@item, :iscart? =>true)
      redirect_to cart_index_path, notice: "#{@item.name} was added to your cart"
    elsif type == "removecart"
      current_user.carts.update(:item =>@item, :iscart? =>false)
      #current_user.cart_additions.delete(@item)
      redirect_to root_path, notice: "#{@item.name} was removed from your cart"
    else
      redirect_to item_path(@item), notice: "Looks like nothing happened. Try again!"

    end
  end

  def wishlist
    type = params[:type]

    if type =="addwishlist"
      #current_user.cart_additions.iswishlist? = true
      current_user.carts.create!(:item =>@item, :iswishlist? =>true)
      redirect_to wishlist_index_path, notice: "#{@item.name} was added to your wishlist"
    elsif type == "removewish"
      current_user.carts.update(:item =>@item, :iswishlist? =>false)
      #current_user.cart_additions.delete(@item)
      redirect_to root_path, notice: "#{@item.name} was removed from your wishlist"
    else
      redirect_to item_path(@item), notice: "Looks like nothing happened. Try again!"
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def item_params
    params.require(:item).permit(:brand, :name, :category, :thumbnail, :is_restricted?, :is_age_restricted?, :quantity, :cost, :purchase_count, :user_id)
  end
end
