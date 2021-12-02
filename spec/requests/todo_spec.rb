require 'rails_helper'

RSpec.describe 'Test API for Todo', type: :request do
  user = FactoryBot.create(:user)
  work_space = FactoryBot.create(:work_space, user_id: user.id)
  todo = FactoryBot.create(:todo, work_space_id: work_space.id)
  headers = {}

  it "Run Login" do
    post api_users_path, params: {
      user: {
        email: user.email,
        password: user.password,
        password_confirmation: user.password_confirmation,
        full_name: user.full_name
      }
    }

    post auth_user_path, params: {
      email: user.email,
      password: user.password
    }
    hash = JSON.parse response.body
    token = hash["data"]["auth_token"]
    headers = { "Authorization" => "Bearer #{token}", "Content-Type" => "application/json" }
    expect(response).to have_http_status(:ok)
  end

  it "Create a todo" do
    params = {
      todo: {
        title: Faker::Lorem.sentence,
        description: Faker::Lorem.sentence,
        priority: "LOW",
        status: "DONE"
      }
    }

    post api_todos_path, params: params.to_json, headers: headers

    expect(response).to have_http_status(:ok)
  end

  it "Get all todo" do
    get "/api/todos?work_space_id=#{work_space.id}", headers: headers

    expect(response).to have_http_status(:ok)
    expect(response.body).to include(todo.title)
    expect(response.body).to include(todo.description)
  end

  it "Get todo by ID" do
    get "/api/todos/#{todo.id}", headers: headers

    expect(response).to have_http_status(:ok)
    expect(response.body).to include(todo.title)
    expect(response.body).to include(todo.description)
  end

  it "Update todo by ID" do
    params = {
      todo: {
        title: Faker::Lorem.sentence,
        description: Faker::Lorem.sentence,
        priority: "LOW",
        status: "DOING"
      }
    }
    put "/api/todos/#{todo.id}", params: params.to_json, headers: headers

    expect(response).to have_http_status(:ok)
    expect(response.body).to include(params[:todo][:title])
    expect(response.body).to include(params[:todo][:description])
  end

  it "Delete todo by ID" do
    delete "/api/todos/#{todo.id}", headers: headers

    expect(response).to have_http_status(:ok)
  end
end
