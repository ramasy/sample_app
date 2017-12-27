class UsersController < ApplicationController
  def new
  	@titre = "Inscription"
  	@user = User.new
  end
  def show 	
  	@user = User.find(params[:id])
  	@titre = @user.nom
  end
  def create
  	@user = User.new(user_params)
  	if @user.save
      flash[:info] = "Bienvenue sur sample app #{@user.nom}"
  		redirect_to @user
  	else
      @titre = "Inscription"
  		render 'new'
  	end
  end
  def user_params
    params.require(:user).permit(:nom,:email,:password,:password_confirmation)
  end
end
