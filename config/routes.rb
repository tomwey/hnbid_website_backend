Rails.application.routes.draw do
  
  devise_for :users, path: 'account', controllers: {
    registrations: :account,
    sessions: :sessions,
  }
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # 富文本上传路由
  mount RedactorRails::Engine => '/redactor_rails'
  
  root 'home#index'
  
  # 网页文档
  resources :pages, path: :p, only: [:show]
  
  resources :projects,  only: [:index, :show]
  resources :bids,      only: [:index, :show]
  resources :companies, only: [:index, :show]
  
  get 'about' => 'home#about', as: :about
  
  resources :users, path: 'u' do
    member do
      get 'new_company'
      post 'save_company'
    end
  end
  
  namespace :portal do 
    root 'home#index'
  end
  
  # resources :projects, path: :case, only: [:show]
  
  # 队列后台管理
  require 'sidekiq/web'
  authenticate :admin_user do
    mount Sidekiq::Web => 'sidekiq'
  end
  
  # # API 文档
  mount GrapeSwaggerRails::Engine => '/apidoc'
  # #
  # # API 路由
  mount API::Dispatch => '/api'
  
  match '*path', to: 'home#error_404', via: :all
end
