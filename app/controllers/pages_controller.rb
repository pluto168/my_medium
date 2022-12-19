class PagesController < ApplicationController

  def index
    @stories = Story.order(created_at: :desc).includes(:user)     #加上includes解決N+1
  end

  def show
    # @story = Story.published.friendly.find(params[:id]) 
    # impressionist(@story)
  end

  def user
  end

  def demo
  end 
  
end
