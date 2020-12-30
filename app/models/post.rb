class Post < ApplicationRecord
  belongs_to :game, optional: true
  belongs_to :user
  has_many :post_console_relations, dependent: :destroy
  has_many :post_category_relations, dependent: :destroy
  has_many :consoles, through: :post_console_relations
  has_many :categories, through: :post_category_relations

  validates :message, presence: true
end
