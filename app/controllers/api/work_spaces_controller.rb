# frozen_string_literal: true

module Api
  class WorkSpacesController < ApplicationController
    before_action :authenticate_request!
    before_action :set_work_space, only: %i[show update destroy]

    def index
      work_spaces = paginate @current_user.work_spaces.by_recently_updated

      work_spaces = ActiveModelSerializers::SerializableResource.new(work_spaces, {})
      render json: format_response(work_spaces: work_spaces), status: :ok
    end

    def show
      @work_space = ActiveModelSerializers::SerializableResource.new(@work_space, {})

      render json: format_response(work_space: @work_space), status: :ok
    end

    def create
      work_space = @current_user.work_spaces.new(work_space_params)

      if work_space.save
        render json: format_response(ActiveModelSerializers::SerializableResource.new(work_space, {})), status: :created
      else
        render json: format_response_error(work_space.errors.messages), status: :ok
      end
    end

    def update
      if @work_space.update(work_space_params)
        render json: format_response(ActiveModelSerializers::SerializableResource.new(@work_space, {})), status: :ok
      else
        render json: format_response_error(@work_space.errors.messages), status: :ok
      end
    end

    def destroy
      @work_space.destroy

      render json: format_response(ActiveModelSerializers::SerializableResource.new(@work_space, {})), status: :ok
    end

    private

    def set_work_space
      @work_space = @current_user.work_spaces.find_by(id: params[:id])

      render json: format_response_error(message: Settings.errors.work_space.work_space_not_found) if @work_space.nil?
    end

    def work_space_params
      params.require(:work_space).permit WorkSpace::WORK_SPACE_PARAMS
    end
  end
end
