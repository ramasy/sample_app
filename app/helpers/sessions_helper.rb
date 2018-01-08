module SessionsHelper

	def sign_in(user)
		cookies.permanent.signed[:remember_token] = [user.id, user.salt]
		self.current_user = user
	end

	def sign_out
		cookies.delete(:remember_token)
		self.current_user = nil
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		@current_user ||= user_from_remember_token 
	end

	def signed_in?
		!current_user.nil?
	end

	private

	def user_from_remember_token
		User.authentifier_par_salt(*remember_token)
	end

	def remember_token
		cookies.signed[:remember_token] || [nil,nil]
	end

	def deny_access
		flash[:notice] = "Merci de vous identifier pour rejoindre cette page."
		session[:return_to] = request.fullpath
		redirect_to app_signin_path
	end

	def current_user?(user)
		current_user == user
	end

	def back_to_url_or(default)

		url = session[:return_to]
		session[:return_to] = nil 
		redirect_to url || default
	end

	def authentifier
    	deny_access unless signed_in?
  	end
end
