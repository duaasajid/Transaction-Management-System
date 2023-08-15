class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  respond_to :json
  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
	devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :password, :password_confirmation, :current_password])
  end
end
