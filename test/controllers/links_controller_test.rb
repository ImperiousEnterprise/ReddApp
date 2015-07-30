require 'test_helper'

class LinksControllerTest < ActionController::TestCase
  setup do
    @link = links(:one)
    @user = users(:User1)
  end



  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:links)
  end

  test "should get new" do
    sign_in(@user)
    get :new
    assert_response :success
  end

  test "should create link" do
    sign_in(@user)
    @altlink = Link.new(:title => "GO SaddleBack", :url => "https://www.saddleback.edu")
    assert_difference('Link.count') do
      get :new
      post :create, link: { title: @altlink.title, url: @altlink.url }
    end

    assert_redirected_to link_path(assigns(:link))
  end

  test "should show link" do
    get :show, id: @link
    assert_response :success
  end

  test "should get edit" do
    sign_in(@user)
    get :edit, id: @link
    assert_response :success
  end




  test "should update link" do
    sign_in(@user)
    get :edit, id: @link
    assert_response :success
    @link.url ='http://www.miamioh.edu'
    patch :update, id: @link, link: {:title => "Updated MYINFO", :url => @link.url}
    assert_redirected_to link_path(assigns(:link))
  end


  test "should destroy link" do
    sign_in(@user)

    assert_difference('Link.count', -1) do
      get :show, id: @link
      delete :destroy, id: @link
    end

    assert_redirected_to links_url
  end



end
