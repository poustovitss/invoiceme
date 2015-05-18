# All controllers will inherit from this one
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :_get_layout

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  def authenticate_admin_user!
    authenticate_user!
    redirect_to new_user_session_path unless current_user.admin?
  end

  protected

  def _get_layout
    signed_in? ? 'authenticated' : 'application'
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end
end
