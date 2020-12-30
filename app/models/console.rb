class Console < ApplicationRecord
  has_many :user_console_relations
  has_many :users, through: :user_console_relations
end
