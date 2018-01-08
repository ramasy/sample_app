class PagesController < ApplicationController
  def home
  	@titre = "home"
    if signed_in?
      @feed = current_user.feed.page(params[:page]).per(10)
      @micropost = Micropost.new
    end
  end

  def contact
    @titre = "contact"
  end
  
  def about    
    @titre = "about"
  end

  def help
  	@titre = "aide"
  end
end
