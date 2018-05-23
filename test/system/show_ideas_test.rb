require "application_system_test_case"

class ShowIdeasTest < ApplicationSystemTestCase
  test 'show displays title' do
    idea = Idea.new
    idea.title = "See the northern lights"
    idea.save!

    visit(show_idea_path(idea))
    assert page.has_content?('See the northern lights')
  end
end
