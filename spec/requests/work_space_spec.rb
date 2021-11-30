require 'rails_helper'

RSpec.describe 'Test API for WorkSpace', type: :request do
  user = FactoryBot.create(:user)
  work_space = FactoryBot.create(:work_space, user_id: user.id)
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

  it "Create a work space" do
    params = {
      work_space: {
        name: Faker::Lorem.sentence,
        description: Faker::Lorem.sentence
      }
    }
    post api_work_spaces_path, params: params.to_json, headers: headers

    expect(response).to have_http_status(:created)
  end

  it "Get all work space" do
    get api_work_spaces_path, headers: headers

    expect(response).to have_http_status(:ok)
    expect(response.body).to include(work_space.name)
    expect(response.body).to include(work_space.description)
  end

  it "Get work space by ID" do
    get "/api/work_spaces/#{work_space.id}", headers: headers

    expect(response).to have_http_status(:ok)
    expect(response.body).to include(work_space.name)
    expect(response.body).to include(work_space.description)
  end

  it "Update work space by ID" do
    params = {
      work_space: {
        name: Faker::Lorem.sentence,
        description: Faker::Lorem.sentence
      }
    }
    put "/api/work_spaces/#{work_space.id}", params: params.to_json, headers: headers

    expect(response).to have_http_status(:ok)
    expect(response.body).to include(params[:work_space][:name])
    expect(response.body).to include(params[:work_space][:description])
  end

  it "Delete work space by ID" do
    delete "/api/work_spaces/#{work_space.id}", headers: headers

    expect(response).to have_http_status(:ok)
  end
end
