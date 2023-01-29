class StoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_story, only: [:edit, :update, :show, :destroy]
  # skip_before_action :verify_authenticity_token, only: [:clap]      此CRUD就不會有不檢查的問題


  def index
    @stories = current_user.stories.order(created_at: :desc)           #撈自己current_user的所有文章stories
    # @stories = current_user.stories.where(deleted_at: nil)
  end

  def new
    # @story = Story.new     #同下
    @story = current_user.stories.new             #在model裡加入hasmany後可以用此寫法
  end
  
  def create
    @story = current_user.stories.new(story_params)
    @story.publish! if params[:publish]
    #@story.status = 'published' if params[:publish]      #發布文章按鈕:publish,status狀態變'published'

    if @story.save
      if params[:publish]
        redirect_to stories_path, notice: '已成功發布'
      else
        redirect_to edit_story_path(@story), notice: '已儲存'
      end
    else
      render :new   
    end
  end

  def edit 
    
  end

  def update
    if @story.update(story_params)
      case 
      when params[:publish]
        @story.publish!
        redirect_to stories_path, notice: '已經發佈' 
      when params[:unpublish]
        @story.unpublish!
        redirect_to stories_path, notice: '已經下架'
      else
        redirect_to edit_story_path(@story), notice: '故事已儲存'     #儲存草稿
      end
    else
      render :edit
    end
  end

  def destroy
    @story.destroy       #複寫到model,story.rb
    redirect_to stories_path, notice: '已刪除'
  end


  #搬到 app/controllers/api/stories_controller.rb
  # def clap                                      
  #   if user_signed_in?
  #     story=Story.friendly.find(params[:id])
  #     story.increment!(:clap)
  #     render json: {status: story.clap}
  #   else
  #     render json: {status: 'sign_in_first'}
  #   end
  # end

  private
  def find_story
    @story = current_user.stories.friendly.find(params[:id])     #加入friendly_id

  end

  def story_params
    params.require(:story).permit(:title, :content, :cover_image)
  end
end
