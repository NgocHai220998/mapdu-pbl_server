require 'rails_helper'

RSpec.describe 'Test API for User', type: :request do
  user = FactoryBot.create(:user)

  before(:all) { # Signup
    post api_users_path, params: {
      user: {
        email: user.email,
        password: user.password,
        password_confirmation: user.password_confirmation,
        full_name: user.full_name
      }
    }
  }

  it "Login" do
    post auth_user_path, params: {
      email: user.email,
      password: user.password
    }

    expect(response.content_type).to eq("application/json; charset=utf-8")
    expect(response).to have_http_status(:ok)
    expect(response.body).to include(user.email)
    expect(response.body).to include(user.full_name)
  end
end
