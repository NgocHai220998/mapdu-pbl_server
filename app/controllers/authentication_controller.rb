# frozen_string_literal: true

class AuthenticationController < ApplicationController
  def authenticate_user
    user = User.find_for_database_authentication email: params[:email]

    handle_check_user user
  end

  private

  def payload user
    return nil unless user&.id

    {
      auth_token: JsonWebToken.encode(user_id: user.id),
      user: { id: user.id, email: user.email, full_name: user.full_name }
    }
  end

  def handle_check_user(user)
    if user&.valid_password?(params[:password]).present?
      render json: format_response(payload(user))
    else
      render json: format_response_error(message: Settings.errors.user.invalid_password)
    end
  end
end
