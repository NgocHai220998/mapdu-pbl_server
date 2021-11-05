class AuthenticationController < ApplicationController
  def authenticate_user
    user = User.find_for_database_authentication email: params[:email]

    if user.blank?
      render json: format_response_error(message: Settings.errors.user.email_not_registered), status: :bad_request
    elsif user.valid_password?(params[:password]).present?
      render json: format_response(payload(user)), status: :ok
    else
      render json: format_response_error(message: Settings.errors.user.invalid_password), status: :unauthorized
    end
  end

  private

  def payload user
    return nil unless user&.id

    {
      auth_token: JsonWebToken.encode(user_id: user.id),
      user: {id: user.id, email: user.email}
    }
  end
end
