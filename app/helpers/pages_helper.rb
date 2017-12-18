module PagesHelper
	def logo
		logo = image_tag "logo.png", :alt => "Application Exemple", :class => "round"
	end
end
