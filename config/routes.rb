Rails.application.routes.draw do
  root "home#index"

  get '/p/:code', to: 'page#index'
end
