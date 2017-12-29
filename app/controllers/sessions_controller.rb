class SessionsController < ApplicationController
  def new
  	@titre = "S'identifier"
  end

  def create
  	user = User.authentifier(session_params)
  	if user.nil?
      flash[:error] = "Combinaison Email/Mot de passe invalide."
  		redirect_to app_signin_path
  	else
      user
  		redirect_to user
  	end
  end

  def destroy
  end

  def session_params
  	params.require(:session).permit(:email, :password)
  end
  
end