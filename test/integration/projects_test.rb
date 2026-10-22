require "test_helper"

class ProjectsTest < ActionDispatch::IntegrationTest
  test "lists projects" do
    get projects_path
    assert_response :success
  end
end
