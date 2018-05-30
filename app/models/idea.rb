class Idea < ApplicationRecord
  validates :title, presence: true
  validates :title, length: { maximum: 75 }

  belongs_to :user
  has_many :comments
  has_and_belongs_to_many :users

  scope :most_recent,           -> { order(created_at: :desc).limit(3) }

  scope :title_contains,        ->(term) { where('title LIKE ?', "%#{term}%") }

  scope :description_contains,  ->(term) { where('description LIKE ?', "%#{term}%") }

  scope :search,                ->(search_term) { title_contains(search_term).or(description_contains(search_term)) }
end
