require "application_system_test_case"

class IdeaCommentsTest < ApplicationSystemTestCase
  test 'adding a Comment to an Idea' do
    idea = Idea.new title: 'Valid idea'
    idea.save!

    user = User.new email: 'valikaelin@gmail.com'
    user.save!
    visit(new_user_path)
    fill_in('Email', with: user.email)
    click_on('Log in')

    visit(idea_path(idea))
    fill_in('Add a comment', with: 'This is a fantastic idea!')
    click_on('Post', match: :first)

    assert_equal idea_path(idea), page.current_path
    assert page.has_content?('This is a fantastic idea!')
  end

  test 'comments cannot be added when not logged in' do
    idea = Idea.new title: 'Valid idea'
    idea.save!

    visit(idea_path(idea))
    refute page.has_content?('Add a Comment')
  end
end
