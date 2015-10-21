class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :setup_devise_parameters, if: :devise_controller?

  private

  def setup_devise_parameters
      devise_parameter_sanitizer.for(:sign_up) << :email
      devise_parameter_sanitizer.for(:sign_up) << :firstname
      devise_parameter_sanitizer.for(:sign_up) << :lastname
      devise_parameter_sanitizer.for(:sign_up) << :userkey
  end
end
