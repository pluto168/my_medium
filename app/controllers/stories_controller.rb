class StoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_story, only: [:edit, :update, :show, :destroy]


  def index
    @stories = current_user.stories.order(created_at: :desc)           #撈自己的所有文章
    # @stories = current_user.stories.where(deleted_at: nil)
  end

  def new
    # @story = Story.new     #同下
    @story = current_user.stories.new             #在model裡加入hasmany後可以用此寫法
  end
  
  def create
    @story = current_user.stories.new(story_params)
    @story.status = 'published' if params[:publish]      #發布文章按鈕:publish,status狀態變'published'

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
      redirect_to stories_path, notice: '更新成功'
    else
      render :edit
    end
  end

  def destroy
    @story.destroy       #複寫到model
    redirect_to stories_path, notice: '已刪除'
  end


  private
  def find_story
    @story = current_user.stories.find(params[:id])
  end

  def story_params
    params.require(:story).permit(:title, :content)
  end
end
