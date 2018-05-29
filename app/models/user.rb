class User < ApplicationRecord
  has_many :ideas
  has_many :comments
  has_and_belongs_to_many :goals, class_name: 'Idea'

  has_secure_password

  validates :email, uniqueness: true
end