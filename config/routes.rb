Rails.application.routes.draw do
  devise_for :users
  post 'auth_user' => 'authentication#authenticate_user'
  namespace :api do
    resources :users, only: [:show, :create]
    resources :todos
    resources :work_spaces, except: [:index]
    get 'work_spaces(/:page/:per_page)' => 'work_spaces#index'
  end
end
