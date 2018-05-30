class User < ApplicationRecord
  has_many :ideas
  has_many :comments
  has_and_belongs_to_many :goals, class_name: 'Idea'

  has_secure_password

  validates :email, uniqueness: true
  validates :role, inclusion: { in: %w(registered admin) }

  before_validation :downcase_email
  after_initialize :default_role!

  private

  def downcase_email
    self.email = email.downcase
  end

  def default_role!
    self.role ||= 'registered'
  end
end
