class ApplicationController < ActionController::Base
  
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  
  private
  def record_not_found
    render file: "#{Rails.root}/public/404.html",
            status:  :not_found,
            layout: false         #不要套用預設
  end

end
