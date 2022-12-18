class PagesController < ApplicationController

  def index
    @stories = Story.order(created_at: :desc).includes(:user)     #加上includes解決N+1
  end

  def show
  end

  def user
  end
  
end
