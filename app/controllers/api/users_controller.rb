class Api::UsersController < Api::BaseController
  before_action :find_user
  # skip_before_action :verify_authenticity_token, only: [:follow] #only可以省略,已放到Base

  def follow
    # if user_signed_in?   搬到base
      render json: {status: current_user.follow!(@user) }
    # else
      # render json: {status: 'sign_in_first'}
    # end
  end

  private
    def find_user
      @user = User.find(params[:id])
    end
end
