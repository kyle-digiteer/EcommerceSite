# frozen_string_literal: true

class AdminController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'

  # before_action :check_and_authenticate_user
  # before_action :authenticate_user!
end
