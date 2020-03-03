class RegistrationsController < Devise::RegistrationsController

  private

  private

  def after_inactive_sign_up_path_for(resource)
    new_user_session_path
  end
  
  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,  :phone, :address, :age, :card_name, :card_no, :card_exp, :cvv)
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password, :phone, :address, :age, :card_name, :card_no, :card_exp, :cvv)
  end

  protected

  #method from devise
  def after_sign_up_path_for(resource)
    '/items'
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end