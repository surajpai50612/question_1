Rails.application.routes.draw do
  namespace :api do
    # GET /users - returns all users from users table
    # resources :users
    get 'users/' => "users#index"

    # GET /user/:id - returns specific user from users table
    get 'user/:id' => "users#show"

    # POST /user - adds new user to users table
    post 'user/' =>  "users#create"

    # PUT /user/:id - update specific user in users table
    put 'user/:id' => "users#update"

    # DELETE /user/:id - delete a specific user in users table
    delete 'user/:id' => "users#destroy"

    # GET /typeahead/:input - depending on input, returns entry from users table
    get 'typeahead/:input' => "users#typeahead"
  end
end