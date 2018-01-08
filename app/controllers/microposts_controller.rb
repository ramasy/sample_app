class MicropostsController < ApplicationController
  	before_action :authentifier, only: [:create, :destroy]
  	def create
  		@micropost = current_user.microposts.build(micropost_params)
  		if @micropost.save
  			flash[:info] = "Nouveau micropost crée!"
  			redirect_to root_path
  		else
  			@titre = "home"
  			# Rails.logger.info("----------------->#{root_path}")
  			# Rails.logger.info("+++++++++++++++++>#{app_home_path}")
  			redirect_to request.url
  		end
  	end

  	def destroy
			Micropost.find_by_id(params[:id]).destroy();
			flash[:info] = "Supprssion effectué"
			redirect_to root_path
  	end
  	private

  	def micropost_params
  		params.require(:micropost).permit(:content)
  	end
end
