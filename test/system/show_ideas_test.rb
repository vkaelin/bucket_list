require "application_system_test_case"

class ShowIdeasTest < ApplicationSystemTestCase
  test 'show displays title' do
    idea = Idea.new title: "See the northern lights", done_count: 27, user: User.new
    idea.save!

    visit(idea_path(idea))
    assert page.has_content?('See the northern lights')
    assert page.has_content?('27 have done')
    assert page.has_content?(idea.created_at.strftime("%d %b '%y"))

    click_on('Edit')
    assert_equal current_path, edit_idea_path(idea)
  end
end
