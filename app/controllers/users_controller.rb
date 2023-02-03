class UsersController < ApplicationController

  def pricing
    
  end

  def payment
    @fee = ENV["price_#{params[:type]}"]  #價格fee
    @payment_type = (params[:type] == 'vip') ? 'VIP 會員' : '白金會員'
    @token = gateway.client_token.generate
  end

  private
  
  def gateway
    Braintree::Gateway.new(
      :environment => :sandbox,
      :merchant_id => ENV['braintree_merchant_id'],
      :public_key => ENV['braintree_public_id'],
      :private_key => ENV['braintree_private_id'],
    )
  end
end
