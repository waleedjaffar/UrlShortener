require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  fixtures :links

  setup do
    @valid_link = Link.new(full_url: "http://iamvalid.com")
  end  

  test "link attributes must not be empty" do
    link = Link.new
    assert link.invalid?
    assert link.errors[:full_url].any?
  end

  test "link access count defaults to zero" do
    link = Link.new
    assert_equal link.access_count, 0
  end

  test "short_url to be generated before validation" do
    assert @valid_link.valid?
    assert_not_empty @valid_link.short_url
  end
end
