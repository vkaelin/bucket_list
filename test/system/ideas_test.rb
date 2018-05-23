require "application_system_test_case"

class IdeasTest < ApplicationSystemTestCase
  test 'create new idea' do
    visit('ideas/new')
    fill_in('title', with: 'Learn to swim')
    fill_in('done_count', with: 36)
    fill_in('photo_url', with: '/images/mountains-forests.jpg')
    click_on('Create idea')
    assert page.has_content?('Learn to swim')
  end

  test 'index loads idea' do
    first_idea = Idea.new
    first_idea.title = 'Join a tennis club'
    first_idea.save!

    second_idea = Idea.new
    second_idea.title = 'Start a blog'
    second_idea.save!

    visit('ideas/index')
    assert page.has_content?('Join a tennis club')
    assert page.has_content?('Start a blog')
  end
end
