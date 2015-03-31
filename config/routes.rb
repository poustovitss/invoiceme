Rails.application.routes.draw do
  resources :iv_templates

  resources :invoices

  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users
end
