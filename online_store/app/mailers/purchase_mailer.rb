class PurchaseMailer < ApplicationMailer
  def purchased_notification
    @user=params[:user]
    @items=Array(params[:items])
    mail(to: @user.email, from: "services@gmail.com", subject:"Purchase Successful")
  end
end
