Rails.application.routes.draw do
  root to: 'home#index'

  get 'home/index'

  get 'styles/atoms'

  get 'styles/molecules'

  get 'styles/organisms'

  resources :users do
    resources :goals
  end

  resources :ideas do
    resources :comments
  end

  get '/account/ideas'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
