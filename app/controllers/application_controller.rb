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
      devise_parameter_sanitizer.for(:account_update) << :email
      devise_parameter_sanitizer.for(:account_update) << :firstname
      devise_parameter_sanitizer.for(:account_update) << :lastname
      devise_parameter_sanitizer.for(:account_update) << :userkey
  end

  def render_error sym
      if sym == :notfound
          render "errors/notfound", status: :notfound, layout: "error" and return
      elsif sym == :forbidden
          render "errors/forbidden", status: :forbidden, layout: "error" and return
      end
  end
end
