# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  nom        :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :nom, presence: { message: "vous devez renseigner votre nom" },
					length: { maximum: 50 }
	validates :email, 	presence: { message: "vous devez renseigner votre email" },
						format: { with: email_regex, message: "Adresse email invalide" },
						uniqueness: { case_sensitive: true, message: "cette adresse est déja utilisé" }
end
