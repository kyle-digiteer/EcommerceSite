class User::RegistrationsController < Devise::RegistrationsController
  layout 'user'

  # before_action :parse_birth_date, only: [:create]
  # before_action :set_user_cart, only: [:new]
  before_action :configure_sign_up_params, only: %i[create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    session[:user_return_to] = params[:user_return_to] if params[:user_return_to].present?
    super
  end

  # POST /resource
  def create
    # Handles the creation of the subscription after a customer signs up
    super do |resource|
      if resource.errors.any?
        flash.now[:alert] = resource.errors.full_messages.join('<br>').html_safe
      else
        # send_new_registration_email(resource)
        # Subscription.create(email: resource.email, active: true) if params[:user][:subscribe_newsletter] == '1'
        # transfer_guest_cart(resource)
      end
    end
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    super do |resource|
      if resource.errors.any?
        Rails.logger.debug "Errors: #{resource.errors.full_messages.join(', ')}"
      else
        Rails.logger.debug "Updated user: #{resource.inspect}"
      end
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  #   def set_user_cart
  #     @cart = session[:cart_items] || []
  #
  #     if @cart != []
  #       if current_customer
  #         cart_items = current_customer.cart_items
  #         @subtotal = cart_items.sum do |cart_item|
  #           price_to_use = cart_item.product_variant_size.promo_price != 0 ? cart_item.product_variant_size.promo_price : cart_item.product_variant_size.regular_price
  #           cart_item.quantity * price_to_use
  #         end
  #         @cart_count = @cart.count
  #       else
  #         cart_items = @cart
  #         @subtotal = cart_items.sum do |cart_item|
  #           price_to_use = ProductVariantSize.find(cart_item["product_variant_size_id"]).promo_price != 0 ? ProductVariantSize.find(cart_item["product_variant_size_id"]).promo_price : ProductVariantSize.find(cart_item["product_variant_size_id"]).regular_price
  #           cart_item["quantity"] * price_to_use
  #         end
  #         @cart_count = @cart.count
  #       end
  #     end
  #   end
  #
  #   def transfer_guest_cart(resource)
  #     if session[:cart_items]
  #       session[:cart_items].each do |item|
  #         product_variant_size_id = item["product_variant_size_id"]
  #         quantity = item["quantity"]
  #
  #         existing_cart_item = CartItem.find_by(customer_id: resource.id, product_variant_size_id: product_variant_size_id)
  #         existing_stock_count = Inventory.where(product_variant_size_id: product_variant_size_id).sum(:quantity)
  #
  #         if existing_cart_item && (existing_cart_item.quantity + quantity) < existing_stock_count
  #           existing_cart_item.update(quantity: existing_cart_item.quantity + quantity)
  #         elsif !existing_cart_item
  #           CartItem.create(customer_id: resource.id, product_variant_size_id: product_variant_size_id, quantity: quantity)
  #         end
  #       end
  #     end
  #   end
  #
  #   def send_new_registration_email(resource)
  #     Templates::NewRegistration.new(resource).send_creation_email
  #   end
  #
  #   def parse_birth_date
  #     arr = params[:user][:birth_date].split('/')
  #     params[:user][:birth_date] = arr.each_with_index.map  {|item, index| index == 0 ? arr[1] : index == 1 ? arr[0] : item}.join('/')
  #   end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[
                                        email
                                        first_name
                                        last_name
                                        address
                                        password
                                        password_confirmation
                                      ])
  end

  def after_sign_in_path_for(_resource)
    flash.discard
    session[:user_return_to] || root_path
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: %i[
                                        email
                                        first_name
                                        last_name
                                        address
                                        password
                                        password_confirmation
                                      ])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
