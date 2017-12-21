module UsersHelper
	def gravatar_for (user, size = 50)
		gravatar_option = {default: :identicon, size: size}
		gravatar_image_tag(user.email.downcase, alt: user.nom, title: user.nom ,class: "gravatar", gravatar: gravatar_option) 
	end
end
