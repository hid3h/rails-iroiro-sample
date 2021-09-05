Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/', to: 'test#index'
  get '/delete_all', to: 'delete_all#index'
  get '/auth/line/callback', to: 'sessions#create'
end
