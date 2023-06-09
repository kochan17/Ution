class Conversation < ApplicationRecord
  belongs_to :user
  belongs_to :persona
  has_many :messages
end