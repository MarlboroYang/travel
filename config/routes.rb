Rails.application.routes.draw do

  devise_for :users, :controllers => { 
    :omniauth_callbacks => "users/omniauth_callbacks",
     sessions: 'users/sessions',  
     registrations: 'users/registrations'}

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    get '/user' => "boards#index", :as => :user_root
  end

  root 'welcome#index'

  resources :boards do
    member do
      patch :hide
      patch :open
      patch :lock
    end
    resources :posts, shallow: true
  end

end
