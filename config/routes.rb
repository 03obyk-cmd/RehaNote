Rails.application.routes.draw do
  # 管理者用
  namespace :admin do
    resource :session, only: [:new, :create, :destroy]
    root 'users#index'
    resources :users, only: [:index, :show, :destroy]
    resources :communities, only: [:index, :show, :destroy]
  end

  # エンドユーザー用
  resources :community_users, only: [:update]

  resources :communities do
    resources :posts
    resources :community_users, only: [:create, :update, :destroy]
    get "members", on: :member
  end

  resources :posts, only: [:show, :new, :create, :edit, :update, :destroy] do
    resource :favorite, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :users, path_names: { new: 'sign_up' }
  get "mypage", to: "users#mypage"

  resource :session
  resources :passwords, param: :token

  root "homes#top"
  get "about", to: "homes#about"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

end
