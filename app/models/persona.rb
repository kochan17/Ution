class Persona < ApplicationRecord
  has_many :conversations
  has_many :messages, as: :sender
end
