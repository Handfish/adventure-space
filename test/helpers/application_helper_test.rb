require 'test_helper'

class ApplciationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title, 'Adventure Space'
    assert_equal full_title("Help"), 'Help | Adventure Space'
  end
end
