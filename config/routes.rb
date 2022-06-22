Rails.application.routes.draw do
  namespace :api do
    resources :users

    get 'user/:id' => "users#show"

    post 'user/' =>  "users#create"

    put 'user/:id' => "users#update"

    delete 'user/:id' => "users#destroy"

    get 'typeahead/:input' => "users#typeahead"
  end
end
