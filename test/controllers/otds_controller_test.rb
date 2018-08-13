require 'test_helper'

class OtdsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wiki_fact = :null
  end

  test "should get On This Day (Otd) index" do
    get otds_url
    assert_response :success
  end

end
