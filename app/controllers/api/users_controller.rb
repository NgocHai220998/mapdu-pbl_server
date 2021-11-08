class Api::UsersController < ApplicationController
  before_action :authenticate_request!, only: [:show]

  def show
    user = find_user params[:id]

    if user.blank?
      render json: format_response_error(message: Settings.errors.user.email_not_registered), status: :ok
    else
      user = ActiveModelSerializers::SerializableResource.new(user, {})
      render json: format_response(user: user), status: :ok
    end
  end

  def create
    user = User.new user_params

    if user.save
      render json: format_response(ActiveModelSerializers::SerializableResource.new(user, {}))
    elsif User.find_by(email: user_params[:email]).present?
      render json: format_response_error(message: Settings.errors.user.email_was_registered), status: :ok
    else
      render json: format_response_error(user.errors.messages), status: :ok
    end
  end

  private

  def user_params
    params.require(:user).permit User::USERS_PARAMS
  end
end
