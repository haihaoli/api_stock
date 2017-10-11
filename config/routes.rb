Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "usstocks#index"

  resources :usstocks do
    member do
      post "like" => "usstocks#like"
      post "unlike" => "usstocks#unlike"
    end
  end

  resources :likes do
    member do
      post "priearn_update" => "likes#priearn_update"
    end
  end

end
