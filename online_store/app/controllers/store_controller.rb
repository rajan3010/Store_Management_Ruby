class StoreController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categories }
    end
  end
end