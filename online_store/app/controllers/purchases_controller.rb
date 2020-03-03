class PurchasesController < ApplicationController
  def index
  end

  def show
    @purchases=User.find(user_params).purchases.all
  end

  def user_params
    params.require(:id)
  end
end
