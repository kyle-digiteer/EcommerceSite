class User::SessionsController < Devise::SessionsController
  layout 'user'
  # before_action :configure_sign_in_params, only: [:create]
  # before_action :check_migrated_customer, only: :create
  # before_action :set_user_cart, only: [:new]
  # after_action :transfer_guest_cart, only: [:create]
  # skip_before_action :verify_authenticity_token, only: [:create]

  # GET /login
  def new
    session[:customer_return_to] = params[:customer_return_to] if params[:customer_return_to].present?
    super
    flash.discard(:notice)
  end

  # DELETE /resource/sign_out
  def destroy
    super
    # Clear the customer_return_to in session.
    session[:customer_return_to] = nil
    flash.discard(:notice) # Remove the signed out successfully message.
  end

  protected

  #   def set_user_cart
  #     @cart = session[:cart_items] || []
  #
  #     return unless @cart != []
  #
  #     if current_customer
  #       cart_items = current_customer.cart_items
  #       @subtotal = cart_items.sum do |cart_item|
  #         price_to_use = cart_item.product_variant_size.promo_price != 0 ? cart_item.product_variant_size.promo_price : cart_item.product_variant_size.regular_price
  #         cart_item.quantity * price_to_use
  #       end
  #       @cart_count = @cart.count
  #     else
  #       cart_items = @cart
  #       @subtotal = cart_items.sum do |cart_item|
  #         price_to_use = ProductVariantSize.find(cart_item['product_variant_size_id']).promo_price != 0 ? ProductVariantSize.find(cart_item['product_variant_size_id']).promo_price : ProductVariantSize.find(cart_item['product_variant_size_id']).regular_price
  #         cart_item['quantity'] * price_to_use
  #       end
  #       @cart_count = @cart.count
  #     end
  #   end

  def after_sign_in_path_for(_resource)
    flash.discard
    session[:customer_return_to] || site_welcome_path
  end

  def check_migrated_customer
    customer = Customer.find_for_authentication(email: params[:customer][:login]) || Customer.find_for_authentication(contact_no: params[:customer][:login])
    return unless customer&.migrated

    redirect_to site_existing_users_path(email: params[:customer][:login]) and return
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
