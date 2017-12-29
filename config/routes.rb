Rails.application.routes.draw do
  root 'pages#home'
  get 'pages/home' => 'pages#home' , as: :app_home
  get 'pages/about' => 'pages#about' , as: :app_about
  get 'pages/contact' => 'pages#contact' , as: :app_contact
  get 'pages/help' => 'pages#help' , as: :app_help
  get 'signup' => 'users#new' , as: :app_signup
  resources :users
  get 'signin' => 'sessions#new'
  delete 'signout' => 'sessions#destroy'
  post 'signin' => 'sessions#create', as: :app_signin
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
