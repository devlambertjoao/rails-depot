require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @product = products(:one)
    @user_signed_in = users(:one)
    @user_random = users(:two)

    sign_in @user_signed_in
  end

  test 'should get index if signed in' do
    get products_url
    assert_response :success
  end

  test 'should not get index if signed out, and redirect to sign in' do
    sign_out @user_signed_in
    get products_url
    assert_redirected_to new_user_session_path
  end

  test 'should get new' do
    get new_product_url
    assert_response :success
  end

  test 'should create product' do
    assert_difference('Product.count') do
      post products_url,
           params: { product: {
             description: @product.description,
             image_url: @product.image_url,
             price: @product.price,
             title: 'Random title',
           } }
    end
    assert_redirected_to product_url(@user_signed_in.products.last)
  end

  test 'should not create product with duplicated title' do
    assert_difference('Product.count', 0) do
      post products_url,
           params: { product: {
             description: @product.description,
             image_url: @product.image_url,
             price: @product.price,
             title: @product.title,
             user_id: @user_signed_in.id
           } }
    end
    assert_response :unprocessable_entity
  end

  test 'should show created product' do
    @user = users(:one)
    @own_product = @user.products.find_by(id: @product.id)
    get product_url(@own_product)
    assert_response :success
  end

  test 'should redirect after try to show a product created by other user' do
    @product = Product.all.where.not(user_id: @user_signed_in.id).last
    get product_url(@product)
    assert_redirected_to products_path
  end

  test 'should get edit' do
    get edit_product_url(@product)
    assert_response :success
  end

  test 'should update product' do
    patch product_url(@product),
          params: { product: {
            description: @product.description,
            image_url: @product.image_url,
            price: @product.price,
            title: @product.title,
            user_id: @user_signed_in.id
          } }
    assert_redirected_to product_url(@product)
  end

  test 'should redirect after try to update product created by other user' do
    patch product_url(@product),
          params: { product: {
            description: @product.description,
            image_url: @product.image_url,
            price: @product.price,
            title: @product.title,
            user_id: @user_random.id
          } }
    assert_redirected_to product_url(@product)
  end

  test 'should destroy product' do
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end

  test 'should redirect after try to destroy product created by other user' do
    assert_difference('@user_signed_in.products.count', 0) do
      sign_in @user_random
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end
end
