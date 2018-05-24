class Idea < ApplicationRecord
  def self.most_recent()
    all.order(created_at: :desc).limit(3)
  end
  
  def self.search(search_term)
    where('title LIKE ?', "%#{search_term}%")
  end
end
