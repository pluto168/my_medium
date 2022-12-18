class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  
  private
  #錯誤轉址
  def record_not_found
    render file: "#{Rails.root}/public/404.html",
            status:  :not_found,
            layout: false         #不要套用預設
  end

  # devise user 過濾驗證 
  def configure_permitted_parameters
    # added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :account_update, keys: [:username, :intro, :avatar, :email, :password, :password_confirmation, :remember_me]
  end

end
