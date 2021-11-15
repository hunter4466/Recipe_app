class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :inventories, foreign_key: 'user_id', class_name: 'Food'
  has_many :recipes, foreign_key: 'user_id', class_name: 'Recipe'
  has_many :foods, foreign_key: 'user_id', class_name: 'Food'

  def self.most_recent_posts(user)
    Post.joins(:author).where(author: { id: user.id }).order(created_at: :desc).limit(3)
  end
end
