class ProductsController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :edit, :create, :update, :destroy]
  
  before_action :set_product, only: %i[ show edit update destroy ]

  def show_by_category
    @category = Category.find(params[:category_id])
    @products = @category.products
  end

  # GET /products or /products.json
  def index

    @categories = Category.all
    @products = Product.includes(:category)
    @products = @products.where("name LIKE ?", "%#{params[:search]}%") if params[:search].present?
    @products = @products.where(category_id: params[:category]) if params[:category].present?
    @products = @products.page(params[:page]).per(5)

  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
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
      # This is to prevent updates from deleting old images
      if @product.update(product_params.reject { |p| p['images']})

        if product_params['images']
          product_params['images'].each do |image|
            @product.images.attach(image)
          end
        end

        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
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
      params.require(:product).permit(:name, :description, :price, :category_id, images: [])
    end
end
