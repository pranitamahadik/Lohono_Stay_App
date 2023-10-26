Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :villa do
    collection do
      get 'fetch_villas_details'
      get 'calculate_total_rate'
    end
  end
end
