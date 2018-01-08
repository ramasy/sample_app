class Micropost < ApplicationRecord
	belongs_to :user

	validates :content, presence: { message: "Le micropost ne doit pas être vide" },
					length: { maximum: 140, message: "Le micropost est trop long" }
	validates :user_id, presence: true

	default_scope { order ('created_at DESC') }
end
