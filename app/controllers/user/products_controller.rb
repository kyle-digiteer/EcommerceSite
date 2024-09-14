class User::ProductsController < UserController
  before_action :set_product, only: %i[show]

  def index
    @products = Product.all
  end

  def show
    @variant = ProductVariant.where(product_id: @product.id)
  end

  def set_product
    @product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to user_products_path, alert: 'Product not Found'
  end
end
