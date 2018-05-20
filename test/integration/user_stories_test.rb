require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :links

  setup do
    @existing_link = links(:one)
    @valid_link = Link.new(full_url: "http://iamvalid.com")
  end

  test "create link and click it in the table" do

    get "/"

    assert_response :success
    assert_template "index"

    # valid link
    xml_http_request :post, shorten_url, {link: {full_url: @valid_link.full_url}}
    assert_response :success

    # invalid link
    xml_http_request :post, shorten_url, {link: {full_url: "iaminvalid"}}
    assert_template "new"

    get "/"
    assert_response :success
    assert_template "index"

    links = Link.all
    assert_equal 3, links.count

    link1 = links[0]
    link2 = links[1]
    link3 = links[2]

    assert_equal "http://apple.com", link1.full_url
    assert_equal "abc", link1.short_url
    assert_equal 1, link1.access_count
    assert_select 'table tbody tr[1] td[1]', 'http://apple.com'
    assert_select 'table tbody tr[1] td[3]', '1'

    assert_equal "http://google.com", link2.full_url
    assert_equal "def", link2.short_url
    assert_equal 0, link2.access_count
    assert_select 'table tbody tr[2] td[1]', 'http://google.com'
    assert_select 'table tbody tr[2] td[3]', '0'

    assert_equal "http://iamvalid.com", link3.full_url
    assert_equal 0, link3.access_count
    assert_select 'table tbody tr[3] td[1]', 'http://iamvalid.com'
    assert_select 'table tbody tr[3] td[3]', '0'
  end
end
