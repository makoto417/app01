class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true, uniqueness: { case_sensitive: true }, length: { maximum: 15 }

  has_one_attached :image
  has_many :boards
  has_many :comments
  
  has_many :user_console_relations
  has_many :consoles, through: :user_console_relations
  has_many :user_category_relations
  has_many :categories, through: :user_category_relations

  has_many :followed_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :follower_relationships, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy
  has_many :followed, through: :followed_relationships
  has_many :followers, through: :follower_relationships

  has_many :direct_messages, dependent: :destroy
  has_many :entries,         dependent: :destroy

  def followed?(other_user)
    followed_relationships.find_by(followed_id: other_user.id)
  end

  def follow(other_user)
    followed_relationships.create!(followed_id: other_user.id) unless self == other_user
  end

  def unfollow(other_user)
    relationship = followed_relationships.find_by(followed_id: other_user.id)
    relationship.destroy if relationship
  end
end
