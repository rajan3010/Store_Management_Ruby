class ApplicationController < ActionController::Base

  private

  # Overwriting the sign_out redirect path method
  @items=Item.all
  def after_sign_out_path_for(resource_or_scope)
    mainpage_index_path
  end
end
