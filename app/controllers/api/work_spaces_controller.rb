class Api::WorkSpacesController < ApplicationController
  before_action :authenticate_request!
  before_action :set_work_space, only: [:show, :update, :destroy]

  def index
    work_spaces = paginate @current_user.work_spaces

    work_spaces = ActiveModelSerializers::SerializableResource.new(work_spaces, {})
    render json: format_response(work_spaces: work_spaces), status: :ok
  end

  def show
    if @work_space.blank?
      render json: format_response_error(message: Settings.errors.work_space.work_space_not_found), status: :ok
    else
      work_space = ActiveModelSerializers::SerializableResource.new(@work_space, {})
      render json: format_response(work_space: work_space), status: :ok
    end
  end

  def create
    work_space = @current_user.work_spaces.new(work_space_params)

    if work_space.save
      render json: format_response(ActiveModelSerializers::SerializableResource.new(work_space, {})), status: :created
    else
      render json: format_response_error(work_space.errors.messages), status: :ok
    end
  end

  # PATCH/PUT /work_spaces/1
  def update
    if @work_space.update(work_space_params)
      render json: @work_space
    else
      render json: @work_space.errors, status: :unprocessable_entity
    end
  end

  # DELETE /work_spaces/1
  def destroy
    @work_space.destroy
  end

  private
  def set_work_space
    @work_space = @current_user.work_spaces.find_by(id: params[:id])
  end

  def work_space_params
    params.require(:work_space).permit WorkSpace::WORK_SPACE_PARAMS
  end
end
