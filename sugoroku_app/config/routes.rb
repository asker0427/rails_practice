Rails.application.routes.draw do
  root "games#show", id:1
  resources :games, only: [:show] do
    post :roll, on: :member
    post :start, on: :member
    post :reset, on: :member
  end
  get "up" => "rails/health#show", as: :rails_health_check

end
