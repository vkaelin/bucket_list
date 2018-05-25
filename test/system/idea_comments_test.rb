require "application_system_test_case"

class IdeaCommentsTest < ApplicationSystemTestCase
  test 'adding a Comment to an Idea' do
    idea = Idea.new title: 'Valid idea'
    idea.save!

    visit(idea_path(idea))
    fill_in('Add a comment', with: 'This is a fantastic idea!')
    click_on('Post', match: :first)
    
    assert_equal idea_path(idea), page.current_path
    assert page.has_content?('This is a fantastic idea!')
  end
end
