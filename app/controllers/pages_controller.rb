class PagesController < ApplicationController

  def index
    #@stories = Story.order(created_at: :desc).includes(:user)     #加上includes解決N+1
    # @stories = Story.where(status: 'published').order(created_at: :desc).includes(:user)
    
    #published_stories,model裡的scope方法
    #@stories = Story.published_stories.order(created_at: :desc).includes(:user) 

    #AASM狀態機可以只用published查詢,可省掉scope,ex:Story.published.count
    @stories = Story.published.order(created_at: :desc).includes(:user)
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
