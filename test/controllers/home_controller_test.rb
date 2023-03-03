require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'should get index' do
    get '/'

    assert_response :success
  end

  test 'should redirect to admin#index if is signed_up' do
    @user = users(:one)
    sign_in @user
    get '/'
    assert_redirected_to admin_index_path
  end
end
