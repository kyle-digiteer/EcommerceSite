class Admin::OrdersController < AdminController
  before_action :set_orders, except: [:index]
  def index
    @pagy, @orders = pagy(@orders = Order.all.order(created_at: :desc), limit: 5, items: 5)
  end

  def show
    @order_items = @order.order_items.includes(product_variant: :product)
  end

  def edit; end

  def update
    if @order.update(order_item_params)
      redirect_to admin_orders_path, notice: 'Successfully changed the order'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def delete; end

  private

  def set_orders
    @order = Order.find(params[:id])
  end

  def order_item_params
    params.require(:order).permit(:payment_status, :order_status)
  end
end
