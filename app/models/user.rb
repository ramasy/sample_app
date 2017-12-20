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

require "digest"

class User < ApplicationRecord
	before_save :encrypt_password
	attr_accessor :password

	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :nom, presence: { message: "vous devez renseigner votre nom" },
					length: { maximum: 50 }
	validates :email, presence: { message: "vous devez renseigner votre email" },
						format: { with: email_regex, message: "Adresse email invalide" },
						uniqueness: { case_sensitive: true, message: "cette adresse est déja utilisé" }
	validates :password, presence: { message: "vous n'avez pas renseigné de mot de passe" },
							confirmation: true,
							length: { within: 6..40, message: "Mot de passe trop court" }
	#fontion de comparaison de mot de passe
	def hasPassword?(passwordSoumis)
		self.encrypted_password == encrypt(passwordSoumis)
	end

	def self.authentifier(email,passwordSoumis)
		user = self.find_by_email(email)
		return nil if user.nil?
		return user if user.hasPassword?(passwordSoumis)
	end

	private
		def encrypt_password
			self.salt = make_salt if self.new_record?
			self.encrypted_password = encrypt(self.password)
		end

		def encrypt(str)
			secure_hash("#{self.salt}--#{str}")
		end

		def secure_hash(str)
			Digest::SHA2.hexdigest(str)
		end

		def make_salt
			secure_hash("#{Time.now.utc}--#{self.password}")
		end
end
