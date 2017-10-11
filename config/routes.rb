Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :usstocks do
    member do
      post "like" => "usstocks#like"
      post "unlike" => "usstocks#unlike"
    end
  end
  root "usstocks#index"
end
