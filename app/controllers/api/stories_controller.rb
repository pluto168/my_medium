class Api::StoriesController < Api::BaseController
  # before_action :authenticate_user!,except: [:clap]
  # skip_before_action :verify_authenticity_token, only: [:clap]   #不檢查clap這個token,only可以省略,已放到Base


  def clap
    # if user_signed_in?
      story=Story.friendly.find(params[:id])
      story.increment!(:clap)
      render json: {status: story.clap}
    # else
      # render json: {status: 'sign_in_first'}
    # end
  end
end
