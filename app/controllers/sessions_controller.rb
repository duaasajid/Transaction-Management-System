# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token
  respond_to :json

  def create
    user = User.find_by(email: params[:email])

    if user&.valid_password?(params[:password])
      sign_in user
      render json: { user:, message: 'Logged in successfully.' }, status: :ok
    else
      render json: { message: 'Invalid email or password.' }, status: :unauthorized
    end
  end

  def destroy
    sign_out
    render json: { message: 'Logged out successfully.' }, status: :ok
  end
end
