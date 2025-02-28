Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  get "watchlists", to: "watchlist#index"
  get "watchlists/all", to: "watchlist#all", as: :all
  get "watchlists/lists", to: "watchlist#lists", as: :lists
  get "watchlists/:id", to: "watchlist#show", as: :movie
  get "watchlists/lists/edit", to: "watchlist#edit", as: :edit
  get "watchlists/lists/edit/:id", to: "watchlist#list", as: :list
  get "watchlists/:id/add_to_list", to: "watchlist#add_to_list",  as: :add_to_list



  # root "posts#index"
end
