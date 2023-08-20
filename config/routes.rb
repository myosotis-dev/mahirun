Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  namespace :discordbot do
    namespace :api do
      namespace :v1 do
        resources :servers, only: [:show]
      end
    end
  end

  namespace :minecraft do
    namespace :api do
      namespace :v1 do
        namespace :texture do
          resources :face, only: [:show]
        end
      end
    end
  end
end
