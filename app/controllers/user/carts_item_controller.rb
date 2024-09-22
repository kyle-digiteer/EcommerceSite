class User::CartsItemController < UserController
  before_action :set_cart_item, only: %i[update destroy]

  def create
    @cart = current_user.cart || Cart.create(user_id: current_user.id)
    product_variant = ProductVariant.find(params[:product_variant_id])

    cart_item = @cart.cart_items.find_or_initialize_by(product_variant:)
    cart_item.quantity ||= 0
    cart_item.quantity += params[:quantity].to_i

    if cart_item.quantity <= product_variant.stock
      if cart_item.save
        @cart.update_total_price
        redirect_to user_cart_path(@cart), notice: 'Item added to cart successfully'
      end
    else
      redirect_to user_product_path(product_variant.product_id),
                  alert: 'Your order quantity is not be greater than stock'
    end
  end

  def update
    if @cart_item.update(cart_item_params)
      @cart_item.cart.update_total_price
      redirect_to user_cart_path(@cart_item.cart), notice: 'Cart item updated successfully'
    else
      redirect_to user_cart_path(@cart_item.cart), alert: 'Failed to update the Cart Item'
    end
  end

  def destroy
    @cart = @cart_item.cart
    @cart_item.destroy
    @cart.update_total_price

    redirect_to user_cart_path(@cart), notice: 'Item removed from cart'
  end

  private

  def set_cart_item
    @cart_item = CartItem.find(params[:id])
  end

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end
