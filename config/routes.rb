Rails.application.routes.draw do
  devise_for :users
  post 'auth_user' => 'authentication#authenticate_user'
  namespace :api do
    resources :users, only: [:show, :create]
    resources :todos, except: [:index]
    resources :work_spaces, except: [:index]
    get 'work_spaces(/:page/:per_page)' => 'work_spaces#index'
    get 'todos(/:work_space_id)' => 'todos#index'
  end
end
