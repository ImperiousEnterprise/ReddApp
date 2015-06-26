require 'test_helper'

class LinkTest < ActiveSupport::TestCase

  def setup
    @link = Link.new(:title => "Test Case",:url => 'https://www.youtube.com')
  end

  test "should be valid" do
    assert @link.valid? ,"Not valid"
  end
  test "title should not be blank" do
    @link.title = ""
    assert_not @link.valid?
  end
  test "title should be more than 5 characters" do
    @link.title = "Test"
    assert_not @link.valid?
  end
  test "title should be less than 50 characters" do
    @link.title = 'a'*51
    assert_not @link.valid?
  end
  test "url should not be blank" do
    @link.url = ""
    assert_not @link.valid?
  end
  test "url should be unique" do
    dup_link = @link.dup
    dup_link.url = @link.url.upcase
    @link.save
    assert_not dup_link.valid?
  end
  test "url should be valid" do
    valid_urls = %w[https://www.facebook.com http://www.aol.com http://www.sony.com http://over-ti.me meta.stackoverflow.com]
    valid_urls.each{|valid_url|
      @link.url = valid_url
      assert @link.valid?
    }
  end
  test "url should be invalid" do
    invalid_urls = %w[http://http:// hello.http:// https://www.facebook..com ftp://hello helohttp://]
    invalid_urls.each{|invalid_url|
      @link.url = invalid_url
      assert_not @link.valid?
    }
  end

end
