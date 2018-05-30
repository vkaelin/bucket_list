require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test 'changing the associated Idea for a Comment' do
    idea_1 = Idea.new title: 'Valid idea', user: User.new(email:'random@epfl.ch')
    idea_1.save!

    comment = Comment.new(body: 'I\'d like to do this!', idea: idea_1, user: User.new(email:'random@epfl.ch'))
    comment.save!

    idea_2 = Idea.new title: 'Second idea', user: User.new(email:'random@epfl.ch')
    idea_2.save!

    comment.idea = idea_2
    comment.save!

    assert_equal Comment.first.idea, idea_2
  end

  test 'cascading save' do
    idea = Idea.new title: 'Valid idea', user: User.new(email:'random@epfl.ch')
    idea.save!

    comment = Comment.new body: 'Great idea!', user: User.new(email:'random@epfl.ch')
    idea.comments << comment
    idea.save!

    assert_equal Comment.first, comment
  end

  test 'Comments are ordered correctly' do
    idea = Idea.new title: 'Valid idea', user: User.new(email:'random@epfl.ch')
    idea.save!

    comment_1 = Comment.new body: 'This would be great fun', user: User.new(email:'random@epfl.ch')
    comment_2 = Comment.new body: 'I agree! I\'d like to do this as well', user: User.new(email:'random@epfl.ch')

    idea.comments << comment_1
    idea.comments << comment_2
    idea.save!

    assert_equal idea.comments.first, comment_1
    assert_equal 2, idea.comments.length
  end
end
