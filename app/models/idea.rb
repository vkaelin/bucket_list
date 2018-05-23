class Idea < ApplicationRecord
  def self.search(search_term)
    where('title LIKE ?', "%#{search_term}%")
  end
end
