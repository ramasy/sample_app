class PagesController < ApplicationController
  def home
  	@titre = "home"
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
