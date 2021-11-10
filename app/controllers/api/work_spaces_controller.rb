class Api::WorkSpacesController < ApplicationController
  before_action :set_work_space, only: [:show, :update, :destroy]
  before_action :authenticate_request!

  # GET /work_spaces
  def index
    @work_spaces = paginate WorkSpace.all

    render json: @work_spaces
  end

  # GET /work_spaces/1
  def show
    render json: @work_space
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
      @work_space = WorkSpace.find(params[:id])
    end

    def work_space_params
      params.require(:work_space).permit WorkSpace::WORK_SPACE_PARAMS
    end
end
