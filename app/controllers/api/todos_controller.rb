# frozen_string_literal: true
class Api::TodosController < ApplicationController
  before_action :authenticate_request!
  before_action :set_work_space, only: [:create, :index]
  before_action :set_todo, only: [:show, :update, :destroy]

  # GET /todos
  def index
    todos = @work_space.todos.by_recently_created

    todos = ActiveModelSerializers::SerializableResource.new(todos, {})
    render json: format_response(todos: todos), status: :ok
  end

  def show
    todo = ActiveModelSerializers::SerializableResource.new(@todo, {})

    render json: format_response(todo: todo), status: :ok
  end

  # POST /todos
  def create
    todo = @work_space.todos.new(todo_params)

    if todo.save
      render json: format_response(ActiveModelSerializers::SerializableResource.new(todo, {})), status: :created
    else
      render json: format_response_error(todo.errors.messages), status: :ok
    end
  end

  # PATCH/PUT /todos/1
  def update
    if @todo.update(todo_params)
      render json: @todo
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /todos/1
  def destroy
    @todo.destroy

    render json: format_response(ActiveModelSerializers::SerializableResource.new(@todo, {})), status: :ok
  end

  private
  def set_todo
    @todo = Todo.find_by(id: params[:id])

    render json: format_response_error(message: Settings.errors.todo.not_found) if @todo.nil?
  end

  def set_work_space
    @work_space = @current_user.work_spaces.find_by(id: params[:work_space_id])

    render json: format_response_error(message: Settings.errors.work_space.work_space_not_found), status: :ok if @work_space.nil?
  end

  def todo_params
    params.require(:todo).permit Todo::TODO_PARAMS
  end
end
