class Users::SessionsController < Devise::SessionsController
  layout "app_login"

  def new
    super
  end

  def create
    super
  end

  def after_sign_in_path_for resource_or_scope
    dashboard_path
  end
end