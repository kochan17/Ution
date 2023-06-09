class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  
  has_many :conversations
  has_many :messages, as: :sender
end

