require "application_system_test_case"

class LogInsTest < ApplicationSystemTestCase
  test 'sign up creates a User' do
    visit(new_user_path)
    fill_in('Email', with: 'valikaelin@gmail.com')
    fill_in('Password', with: 'password')
    click_on('Sign up', match: :first)

    assert_equal 1, User.all.length
    assert_equal 'valikaelin@gmail.com', User.first.email
  end

  test 'log in does not create a User' do
    user = User.new email: 'valikaelin@gmail.com', password: 'password'
    user.save
    visit(new_session_path)
    fill_in('Email', with: user.email)
    fill_in('Password', with: user.password)
    click_on('Log in', match: :first)

    assert_equal 1, User.all.length
  end
end
