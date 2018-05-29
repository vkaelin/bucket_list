require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'email is lowercase before validation' do
    user = User.new email: 'nEw@EpFl.Ch', password: 'password'
    assert user.valid?
    assert_equal user.email, 'new@epfl.ch'
  end
end
