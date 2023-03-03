require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @product = products(:one)
    @userSignedIn = users(:one)
    @anotherRandomUser = users(:two)
  end

  test 'should get index if signed in' do
    sign_in @userSignedIn
    get products_url
    assert_response :success
  end

  test 'should not get index if signed out, and redirect to sign in' do
    get products_url
    assert_redirected_to new_user_session_path
  end

  # test 'should get new' do
  #   get new_product_url
  #   assert_response :success
  # end

  # test 'should create product' do
  #   assert_difference('Product.count') do
  #     post products_url,
  #          params: { product: { description: @product.description, image_url: @product.image_url, price: @product.price,
  #                               title: @product.title } }
  #   end

  #   assert_redirected_to product_url(Product.last)
  # end

  # test 'should show created product' do
  #   @user = users(:one)
  #   @own_product = @user.products.find_by(id: @product.id)
  #   get product_url(@own_product)
  #   assert_response :success
  # end

  # test 'should not show created product' do
  #   get product_url(@product)
  #   assert_response :not_found
  # end

  # test 'should get edit' do
  #   get edit_product_url(@product)
  #   assert_response :success
  # end

  # test 'should update product' do
  #   patch product_url(@product),
  #         params: { product: { description: @product.description, image_url: @product.image_url, price: @product.price,
  #                              title: @product.title } }
  #   assert_redirected_to product_url(@product)
  # end

  # test 'should destroy product' do
  #   assert_difference('Product.count', -1) do
  #     delete product_url(@product)
  #   end

  #   assert_redirected_to products_url
  # end
end
