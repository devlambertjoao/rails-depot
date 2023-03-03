class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  before_action :authenticate_user!
  skip_forgery_protection if Rails.env.test?

  # GET /products or /products.json
  def index
    @products = current_user.products
  end

  # GET /products/1 or /products/1.json
  def show
    @product = current_user.products.find_by(id: params[:id])

    respond_to do |format|
      if @product.blank?
        format.html { redirect_to products_path, notice: 'Not found' }
        format.json { render json: { message: 'Not Found' }, status: :not_found }
      else
        format.html { render :show }
        format.json { render :show, status: :ok }
      end
    end
  end

  # GET /products/new
  def new
    @product = current_user.products.create
  end

  # GET /products/1/edit
  def edit
    @product = current_user.products.find_by(id: params[:id])

    respond_to do |format|
      if @product.blank?
        format.html { redirect_to products_path, notice: 'Not found' }
        format.json { render json: { message: 'Not Found' }, status: :not_found }
      else
        format.html { render :edit }
      end
    end
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:title, :description, :price, :image_url, :user_id, :product)
  end
end
