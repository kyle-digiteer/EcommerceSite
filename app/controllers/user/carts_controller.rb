class User::CartsController < UserController
  before_action :set_cart, only: %i[show update destroy]

  def show
    @cart_items = @cart.cart_items.includes(product_variant: :product)
  end

  def create
    @cart = current_user.cart || Cart.create(user_id: current_user.id)

    if @cart.save
      redirect_to user_cart_path(@cart), notice: 'Cart was successfully created.'
    else
      redirect_to user_products_path, alert: 'Failed to create cart.'
    end
  end

  def update
    if @cart.update(cart_params)
      @cart.update_total_price
      redirect_to user_cart_path(@cart), notice: 'Cart was successfully updated'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @cart.destroy
    redirect_to user_products_path, notice: 'Cart was successfully destroyed.'
  end

  private

  def set_cart
    @cart = current_user.cart || Cart.create(user_id: current_user.id)
  end

  def cart_params
    params.require(:cart).permit(:total_price)
  end
end
