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
    fill_in('q', with: 'Mont')
    click_on('Search', match: :first)
    assert current_path.include?(ideas_index_path)
    assert page.has_content?('Climb Mont Blanc')
    refute page.has_content?('Visit Niagara Falls')
  end

  test 'No search results' do
    visit(ideas_index_path)
    assert page.has_content?('No ideas found!')
  end

  test 'homepage hightlights' do
    4.times do |i|
      idea = Idea.new
      idea.title = "Exciting Idea #{i+1}"
      idea.save!
    end

    visit(root_path)
    assert page.has_content?('Exciting Idea 4')
    assert page.has_content?('Exciting Idea 3')
    assert page.has_content?('Exciting Idea 2')
    refute page.has_content?('Exciting Idea 1')
  end

  test 'search by description and title' do
    idea_1 = Idea.new
    idea_1.title = 'Go cycling across Europe'
    idea_1.description = 'An amazing way to see lots of Europe'
    idea_1.save!

    idea_2 = Idea.new
    idea_2.title = 'Visit Provence'
    idea_2.description = 'Go to vineyards, go cycling up Mont Ventoux, see the fields of lavender'
    idea_2.save!

    idea_3 = Idea.new
    idea_3.title = 'Overnight hike in Switzerland'
    idea_3.description = 'Stay in a Swiss refuge in the mountains'
    idea_3.save!

    visit(root_path)
    fill_in('q', with: 'cycling')
    click_on('Search', match: :first)
    assert page.has_content?('Go cycling across Europe')
    assert page.has_content?('Visit Provence')
    refute page.has_content?('Overnight hike in Switzerland')
  end
end
