class Admin::ProductsController < AdminController
  before_action :set_product, only: %i[show edit update destroy]

  # GET /products or /products.json
  def index
    @products = Product.all
  end

  # GET /products/1 or /products/1.json
  def show
    @product_variants = @product.product_variants
  end

  # GET /products/new
  def new
    @product = Product.new
    @product.product_variants.build # add this if you want to automatically add
  end

  # GET /products/1/edit
  def edit; end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to admin_products_path, notice: 'Product was successfully created.'

    else
      render :new, status: :unprocessable_entity

    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    if @product.update(product_params)
      redirect_to admin_products_path, notice: 'Product was successfully updated.'

    else
      render :edit, status: :unprocessable_entity

    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy!

    redirect_to admin_products_path, notice: 'Product was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:name, :description,
                                    product_variants_attributes: %i[_destroy id price color size stock])
  end
end
