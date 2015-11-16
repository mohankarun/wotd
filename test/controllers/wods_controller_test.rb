require 'test_helper'

class WodsControllerTest < ActionController::TestCase
  setup do
    @wod = wods(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wods)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wod" do
    assert_difference('Wod.count') do
      post :create, wod: { date: @wod.date, meaning: @wod.meaning, title: @wod.title }
    end

    assert_redirected_to wod_path(assigns(:wod))
  end

  test "should show wod" do
    get :show, id: @wod
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @wod
    assert_response :success
  end

  test "should update wod" do
    patch :update, id: @wod, wod: { date: @wod.date, meaning: @wod.meaning, title: @wod.title }
    assert_redirected_to wod_path(assigns(:wod))
  end

  test "should destroy wod" do
    assert_difference('Wod.count', -1) do
      delete :destroy, id: @wod
    end

    assert_redirected_to wods_path
  end
end
