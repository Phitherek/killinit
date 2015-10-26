Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "users/registrations"}
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
  root :to => "main#index"
  get '/helper/parameterize', to: "helper#parameterize"
  get '/given', to: "main#killin_its_given"
  get '/received', to: "main#killin_its_received"
  resources :killin_its, only: [:create, :edit, :update, :destroy]
  get '/:key/given', to: "main#profile_killin_its_given", as: :profile_given
  get '/:key/received', to: "main#profile_killin_its_received", as: :profile_received
  get '/:key', to: "main#profile", as: :profile
  post '/api/login', to: "api#login", as: :api_login
  post '/api/search', to: "api#search", as: :api_search
  post '/api/my_profile', to: "api#my_profile", as: :api_my_profile
  post '/api/my_given', to: "api#my_given", as: :api_my_given
  post '/api/my_received', to: "api#my_received", as: :api_my_received
  post '/api/user_profile', to: "api#user_profile", as: :api_user_profile
  post '/api/user_given', to: "api#user_given", as: :api_user_given
  post '/api/user_received', to: "api#user_received", as: :api_user_received
  post '/api/create_killin_it', to: "api#create_killin_it", as: :api_create_killlin_it
  post '/api/update_killin_it', to: "api#update_killin_it", as: :api_update_killin_it
  post '/api/destroy_killin_it', to: "api#destroy_killin_it", as: :api_destroy_killin_it
  post '/api/logout', to: "api#logout", as: :api_logout
end
