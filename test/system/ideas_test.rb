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

  test 'editing an Idea' do
    idea = Idea.new
    idea.save!

    visit(edit_idea_path(idea))
    fill_in('done_count', with: 73)
    fill_in('title', with: 'Learn Ruby on Rails')
    click_on('Update')

    click_on('Learn Ruby on Rails')
    assert page.has_content?('Learn Ruby on Rails')
    assert page.has_content?('73 have done this')
  end

  test 'search' do
    first_idea = Idea.new
    first_idea.title = 'Climb Mont Blanc'
    first_idea.save!

    second_idea = Idea.new
    second_idea.title = 'Visit Niagara Falls'
    second_idea.save!

    visit(root_path)
    fill_in('q', with: 'Mont').send_keys(:enter)
    assert current_path.include?(ideas_index_path)
    assert page.has_content?('Climb Mont Blanc')
    refute page.has_content?('Visit Niagara Falls')
  end

  test 'No search results' do
    visit(ideas_index_path)
    assert page.has_content?('No ideas found!')
  end
end
