Rails.application.routes.draw do
  resources :charges, only: [:new, :create]

  post 'charges/downgrade'

  resources :wikis do
    resources :collaborators, only: [:new, :create, :destroy]
  end

  devise_for :users

  get 'about' => 'welcome#about'

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
