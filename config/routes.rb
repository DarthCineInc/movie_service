Rails.application.routes.draw do

  namespace :api do
    get 'movie', to: 'movie#index'
  end

end
