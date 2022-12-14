class StoriesController < ApplicationController
  before_action :authenticate_user!
  
  def new
    # @story = Story.new     #同下
    @story = current_user.stories.new             #在model裡加入hasmany後可以用此寫法
  end
  
  def create
    @story = current_user.stories.new(story_params)

    if @story.save
      redirect_to stories_path, notice: '新增成功'
    else
      render :new       
    end
  end

  private
  def story_params
    params.require(:story).permit(:title, :content)
  end
end
