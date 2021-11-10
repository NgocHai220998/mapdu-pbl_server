class ApplicationController < ActionController::API
  attr_reader :current_user

  include ResponseHelper
  include PaginateHelper

  protected
  def authenticate_request!
    unless user_id_in_token?
      render json: format_response_error(message: Settings.errors.user.not_authenticated), status: :unauthorized
      return
    end

    @current_user = User.find_by id: auth_token["user_id"]
  rescue JWT::VerificationError, JWT::DecodeError
    render json: format_response_error(message: Settings.errors.user.not_authenticated), status: :unauthorized
  end

  def find_user user_id
    user = User.find_by id: user_id
    return user if user&.id

    nil
  end

  private
  def http_token
    request.headers["Authorization"].split(" ").last if request.headers["Authorization"].present?
  end

  def auth_token
    JsonWebToken.decode http_token
  end

  def user_id_in_token?
    http_token && auth_token && auth_token[:user_id].to_i
  end
end
