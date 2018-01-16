require 'csv'

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

  def upload
    @titre = "aide"
    uploaded_io = params[:person][:picture]
    dir_path = Rails.root.join('public','uploads').to_s
    file_path = Rails.root.join('public', 'uploads', (('a'..'z').to_a + (1..9).to_a).shuffle[0..16].join + uploaded_io.original_filename)
    Dir.mkdir(dir_path) unless File.exists?(dir_path)
    File.open(file_path, 'wb') do |file|
      file.write(uploaded_io.read)
    end
    CSV.foreach(file_path, headers: true, col_sep: ";" ) do |row|
      info_user = row.to_hash
      user_not_exist = User.find_by_email(info_user["email"]).nil?
      #Rails.logger.debug user
      User.create! nom: info_user["name"], email: info_user["email"], password: info_user["password"] if user_not_exist == true
    end
    render 'help'
  end

end
