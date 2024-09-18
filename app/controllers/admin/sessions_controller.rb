class Admin::SessionsController < Devise::SessionsController
  layout 'devise'

  # GET /admin/login
  def new
    session[:admin_return_to] = params[:admin_return_to] if params[:admin_return_to].present?
    super
    flash.discard
  end

  # POST /admin/login
  def create
    self.resource = Admin.find_by_email(params[:admin][:email].downcase)
    if Admin.find_by_email(params[:admin][:email].downcase)&.valid_password?(params[:admin][:password])
      sign_in(:admin, resource) # Signing in the admin user
      yield resource if block_given?

      respond_with resource, location: after_sign_in_path_for(resource), turbo: false
    else
      if resource.nil?
        @admin = Admin.new
        @admin.errors.add(:invalid, 'email or password.')
      else
        resource.errors.add(:invalid, 'email or password.')
      end
      render :new
    end
  end

  # DELETE /admin/logout
  def destroy
    super
    session[:admin_return_to] = nil
    flash.discard(:notice) # Remove the signed-out message.
  end

  # Overwrite the sign-in redirect path method
  def after_sign_in_path_for(_resource)
    flash.discard
    admin_dashboard_index_path
  end

  # Overwrite the sign-out redirect path method
  def after_sign_out_path_for(_resource)
    new_admin_session_path # Ensure this points to the admin login
  end
end
