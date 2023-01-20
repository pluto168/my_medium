class Api::StoriesController < Api::BaseController
  # before_action :authenticate_user!,except: [:clap]
  # skip_before_action :verify_authenticity_token, only: [:clap]   #不檢查clap這個token,only可以省略,已放到Base

  before_action :find_story       #用find_story後,story要換成實體變數@story

  def clap
    # if user_signed_in?
      # story=Story.friendly.find(params[:id])
      @story.increment!(:clap)                   
      render json: {status: @story.clap}
    # else
      # render json: {status: 'sign_in_first'}
    # end
  end

  def bookmark
    # story = Story.find(params[:id]) 先找出文章
    render json: {status: current_user.bookmark!(@story)}   
  end

  private
    def find_story
      @story = Story.friendly.find(params[:id])
  end

end