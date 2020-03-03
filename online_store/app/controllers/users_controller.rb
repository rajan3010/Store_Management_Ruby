class UsersController < ApplicationController
  def index
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "Successfully updated User."
      redirect_to root_path
    else
      render :action => 'edit'
    end
  end
  def new

  end
  def create
      @user = User.create!(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_path, notice: 'A new user has been created. ' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @users=User.all
  end

  def edit
    @user = User.find(params[:id])
  end


  def update
    @user = User.find(params[:id])
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?

    if @user.update(user_params)
      flash[:notice] = "Successfully updated User."
      redirect_to root_path
    else
      render :action => 'edit'
    end
  end

  def remove
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "Successfully updated User."
      redirect_to root_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "Successfully updated User."
      redirect_to root_path
    else
      render :action => 'edit'
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :phone, :address, :age, :id, :password, :password_confirmation, :card_name, :card_no, :card_exp, :cvv)
  end
end