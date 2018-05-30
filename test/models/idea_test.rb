require 'test_helper'

class IdeaTest < ActiveSupport::TestCase
  test 'the first empty Idea created is first in the list' do
    first_idea = Idea.new title: 'First idea', user: User.new(email:'random@epfl.ch')
    first_idea.save!
    second_idea = Idea.new title: 'Second idea', user: User.new(email:'random@epfl.ch')
    second_idea.save!
    assert_equal(first_idea, Idea.all.first)
  end

  test 'the first complete Idea created is first in the list' do
    first_idea = Idea.new title: 'Cycle the length of the United Kingdom', photo_url: 'http://mybucketlist.ch/an_image.jpg', done_count: 12, user: User.new(email:'random@epfl.ch')
    first_idea.save!
    second_idea = Idea.new title: 'Visit Japan', photo_url: 'http://mybucketlist.ch/second_image.jpg', done_count: 3, user: User.new(email:'random@epfl.ch')
    second_idea.save!
    assert_equal(first_idea, Idea.all.first)
  end

  test 'updated_at is changed after updating title' do
    idea = Idea.new title: 'Visit Marrakech', user: User.new(email:'random@epfl.ch')
    idea.save!
    first_updated_at = idea.updated_at
    idea.title = 'Visit the market in Marrakech'
    idea.save!
    refute_equal(idea.updated_at, first_updated_at)
  end

  test 'updated_at is changed after updating done_count' do
    idea = Idea.new title: 'Idea', done_count: 46, user: User.new(email:'random@epfl.ch')
    idea.save!
    first_updated_at = idea.updated_at
    idea.done_count = 184
    idea.save!
    refute_equal(idea.updated_at, first_updated_at)
  end

  test 'updated_at is changed after updating photo_url' do
    idea = Idea.new title: 'Idea', photo_url: '/images/swimmers.jpg', user: User.new(email:'random@epfl.ch')
    idea.save!
    first_updated_at = idea.updated_at
    idea.photo_url = '/images/runners.jpg'
    idea.save!
    refute_equal(idea.updated_at, first_updated_at)
  end

  test 'One matching result' do
    idea = Idea.new title: 'Stand at the top of the Empire State Building', user: User.new(email:'random@epfl.ch')
    idea.save!
    results = Idea.search("the top")
    assert_equal 1, results.length
  end

  test 'No matching results' do
    idea = Idea.new title: 'Stand at the top of the Empire State Building', user: User.new(email:'random@epfl.ch')
    idea.save!
    results = Idea.search("snorkelling")
    assert_empty results
  end

  test 'Two matching results' do
    first_idea = Idea.new title: 'Stand at the top of the Empire State Building', user: User.new(email:'random@epfl.ch')
    first_idea.save!
    second_idea = Idea.new title: 'Stand on the pyramids', user: User.new(email:'random@epfl.ch')
    second_idea.save!

    results = Idea.search("Stand")
    assert_equal 2, results.length
  end

  test 'most_recent with no Ideas' do
    assert_empty Idea.most_recent
  end

  test 'most_recent with two Ideas' do
    first_idea = Idea.new title: 'Exciting Idea 1', user: User.new(email:'random@epfl.ch')
    first_idea.save!
    second_idea = Idea.new title: 'Exciting Idea 2', user: User.new(email:'random@epfl.ch')
    second_idea.save!

    assert_equal 2, Idea.most_recent.length
    assert_equal Idea.most_recent.first, second_idea
  end

  test 'most_recent with six Ideas' do
    6.times do |i|
      idea = Idea.new
      idea.title = "Exciting Idea #{i+1}"
      idea.user = User.new(email:'random@epfl.ch')
      idea.save!
    end

    assert_equal 3, Idea.most_recent.length
    assert_equal Idea.most_recent.first.title, 'Exciting Idea 6'
  end

  test 'search with description' do
    idea = Idea.new title: 'Surfing in Portugal', description: 'See what Atlantic coast waves are like!', user: User.new(email:'random@epfl.ch')
    idea.save!

    assert_equal 1,  Idea.search('coast').length
  end

  test 'search with description and title' do
    idea_1 = Idea.new title: 'Overnight hike in Switzerland', description: 'Stay in a Swiss refuge in the mountains', user: User.new(email:'random@epfl.ch')
    idea_1.save!

    idea_2 = Idea.new title: 'Hike the mountains in Italy', description: 'See the Dolomites and Italian Alps', user: User.new(email:'random@epfl.ch')
    idea_2.save!

    assert_equal 2,  Idea.search('mountains').length
  end

  test 'maximum length of title' do
    idea = Idea.new title: 'This is a very very very very very very very very very very very very, too much long title for an Idea', user: User.new(email:'random@epfl.ch')
    refute idea.valid?
  end

  test 'presence of title' do
    idea = Idea.new user: User.new(email:'random@epfl.ch')
    refute idea.valid?
  end
end
