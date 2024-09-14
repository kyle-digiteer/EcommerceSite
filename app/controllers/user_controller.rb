class UserController < ApplicationController
  # before_action :set_user_cart, if: -> { Product.any? }, unless: -> { controller_name == 'checkout' }
  # before_action :set_wishlist_count, if: -> { current_customer }
  #
  layout 'user'
  #   private
  #
  #   def set_user_cart
  #     if current_customer
  #       @cart = CartItem.where(customer_id: current_customer).order('created_at')
  #     else
  #       @cart = session[:cart_items] || []
  #     end
  #
  #     #calculate total
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
end
