Rails.application.routes.draw do
  devise_for :users, :controllers => { 
    :omniauth_callbacks => "users/omniauth_callbacks",
     sessions: 'users/sessions',  
     registrations: 'users/registrations'}
  root 'welcome#index'
  resources :boards do
    resources :posts, shallow: true
  end
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
