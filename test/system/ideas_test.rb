require "application_system_test_case"

class IdeasTest < ApplicationSystemTestCase
  test 'create new idea' do
    user = User.new email: 'test@epfl.ch', password: 'password'
    user.save!

    visit(new_session_path)
    fill_in('Email', with: user.email)
    fill_in('password', with: user.password)
    click_on('Log in')

    visit(new_idea_path)
    fill_in('Title', with: 'Learn to swim')
    fill_in('Done count', with: 36)
    fill_in('Photo url', with: '/images/mountains-forests.jpg')
    click_on('Create Idea')
    assert page.has_content?('Learn to swim')
  end

  test 'index loads idea' do
    first_idea = Idea.new title: 'Join a tennis club', user: User.new
    first_idea.save!

    second_idea = Idea.new title: 'Start a blog', user: User.new
    second_idea.save!

    visit(ideas_path)
    assert page.has_content?('Join a tennis club')
    assert page.has_content?('Start a blog')
  end

  test 'editing an Idea' do
    user = User.new email: 'new@epfl.ch', password: 'password'
    idea = Idea.new title: 'Unedited idea', user: user
    idea.save!

    visit(edit_idea_path(idea))
    fill_in('Done count', with: 73)
    fill_in('Title', with: 'Learn Ruby on Rails')
    click_on('Update')

    click_on('Learn Ruby on Rails')
    assert page.has_content?('Learn Ruby on Rails')
    assert page.has_content?('73 have done this')
  end

  test 'search' do
    first_idea = Idea.new title: 'Climb Mont Blanc', user: User.new
    first_idea.save!

    second_idea = Idea.new title: 'Visit Niagara Falls', user: User.new
    second_idea.save!

    visit(root_path)
    fill_in('q', with: 'Mont')
    click_on('Search', match: :first)
    assert current_path.include?(ideas_path)
    assert page.has_content?('Climb Mont Blanc')
    refute page.has_content?('Visit Niagara Falls')
  end

  test 'No search results' do
    visit(ideas_path)
    assert page.has_content?('No ideas found!')
  end

  test 'homepage hightlights' do
    4.times do |i|
      idea = Idea.new
      idea.title = "Exciting Idea #{i+1}"
      idea.user = User.new
      idea.save!
    end

    visit(root_path)
    assert page.has_content?('Exciting Idea 4')
    assert page.has_content?('Exciting Idea 3')
    assert page.has_content?('Exciting Idea 2')
    refute page.has_content?('Exciting Idea 1')
  end

  test 'search by description and title' do
    idea_1 = Idea.new title: 'Go cycling across Europe', description: 'An amazing way to see lots of Europe', user: User.new
    idea_1.save!

    idea_2 = Idea.new title: 'Visit Provence', description: 'Go to vineyards, go cycling up Mont Ventoux, see the fields of lavender', user: User.new
    idea_2.save!

    idea_3 = Idea.new title: 'Overnight hike in Switzerland', description: 'Stay in a Swiss refuge in the mountains', user: User.new
    idea_3.save!

    visit(root_path)
    fill_in('q', with: 'cycling')
    click_on('Search', match: :first)
    assert page.has_content?('Go cycling across Europe')
    assert page.has_content?('Visit Provence')
    refute page.has_content?('Overnight hike in Switzerland')
  end

  test 'new idea with a too long title' do
    user = User.new email: 'test@epfl.ch', password: 'password'
    user.save!

    visit(new_session_path)
    fill_in('Email', with: user.email)
    fill_in('Password', with: user.password)
    click_on('Log in')

    visit(new_idea_path)
    fill_in('Title', with: 'This is a very, very, very, very, very, very, very, very, very, too much long title for an Idea')
    fill_in('Done count', with: 36)
    fill_in('Photo url', with: '/images/mountains-forests.jpg')
    click_on('Create Idea')
    assert page.has_content?('Title is too long')
  end

  test 'existing idea updated with a too long title' do
    idea = Idea.new title: 'This is a good title', user: User.new
    idea.save!

    visit(edit_idea_path(idea))
    fill_in('Title', with: 'This is a very, very, very, very, very, very, very, very, very, too much long title for an Idea')
    click_on('Update Idea')
    assert page.has_content?('Title is too long')
  end
end
