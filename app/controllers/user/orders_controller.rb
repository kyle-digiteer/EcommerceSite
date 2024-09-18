class User::OrdersController < UserController
  def index
    @pagy, @orders = pagy(Order.where(user_id: current_user.id).order(created_at: :desc), limit: 3, items: 3)
  end

  def confirmation
    @order = Order.find(params[:id])
  end

  def checkout
    @cart = current_user.cart

    return redirect_to user_cart_path(@cart), alert: 'Your Cart is Empty' if @cart.cart_items.empty?

    total_price = @cart.total_price
    wallet = current_user.wallet

    if wallet.balance >= total_price
      order = Order.create(user: current_user, cart: @cart, order_status: 'pending',
                           payment_status: params[:payment_method] == 'cod' ? :paid : :pending_payment, total: @cart.total_price)

      @cart.cart_items.each do |cart_item|
        order.order_items.create(
          product_variant: cart_item.product_variant,
          quantity: cart_item.quantity,
          price: cart_item.product_variant.price
        )

        cart_item.product_variant.update!(stock: cart_item.product_variant.stock - cart_item.quantity)
      end

      case params[:payment_method]
      when 'cod'
        order.update(payment_status: 'paid', order_status: 'completed')
      when 'bank_transfer'
        order.update(payment_status: 'pending', order_status: 'pending')
      end

      wallet.update(balance: wallet.balance - total_price)

      @cart.cart_items.destroy_all

      redirect_to confirmation_user_orders_path(order), notice: 'Order placed Successfully'
    else
      redirect_to user_cart_path(@cart), alert: 'Insufficient funds in wallet'
    end
  end
end
