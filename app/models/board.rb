class Board < ApplicationRecord
  belongs_to :game, optional: true
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :board_console_relations, dependent: :destroy
  has_many :board_category_relations, dependent: :destroy
  has_many :consoles, through: :board_console_relations
  has_many :categories, through: :board_category_relations

  validates :title, presence: true
end
