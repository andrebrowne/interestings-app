require "application_system_test_case"

class OtdsTest < ApplicationSystemTestCase
  # setup do
  #   @wiki_fact = :null
  # end

  test "visiting the On This Day (Otd) index" do
    visit otds_url
    assert_selector "h1", text: DateTime.now.strftime("%B %e Interesting Facts:")
  end
end
