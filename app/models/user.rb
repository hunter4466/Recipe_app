class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
         devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :inventories, foreign_key: 'user_id', class_name: 'Inventory'
  has_many :recipes, foreign_key: 'user_id', class_name: 'Recipe'
  has_many :foods, foreign_key: 'user_id', class_name: 'Food'
end
