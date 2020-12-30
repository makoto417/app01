class Category < ApplicationRecord
  has_many :user_category_relations
  has_many :users, through: :user_category_relations
end
